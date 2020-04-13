--[[
ModuleName :
Path : main.lua
Author : jinlei
CreateTime : 2020-03-19 19:58:26
Description :
--]]
local skynet = require "skynet"
local logger = require "common.logger"
local config_system = require "config_system"
local config_agentmgr = config_system.agentmgr
local socket = require "skynet.socket"

local maxAgentCount = config_agentmgr.max_agent_count
local agentPerDatabase = config_agentmgr.agent_per_database
local maxEnterPerBatch = config_agentmgr.max_enter_per_batch

gate = ...

local totalAgentCount = 0
local freeAgentPool = {}
local function newAgent()
	local agent
	if #freeAgentPool > 0 then
		agent = table.remove(freeAgentPool)
	else
		agent = skynet.newservice("agent", gate, skynet.self())
		totalAgentCount = totalAgentCount + 1
	end
	return agent
end

local function freeAgent(agent)
	table.insert(freeAgentPool, agent)
end

local function getUseAgentCount()
	return totalAgentCount - #freeAgentPool
end

local databasePool = {}
local databaseIdx = 0
local function nextDB()
	databaseIdx = databaseIdx % #databasePool + 1
	return databasePool[databaseIdx]
end

local clsQueue = {}
clsQueue.__class_mt = {__index = clsQueue}
function clsQueue.New()
	local q = {
		_queue = {}
	}
	setmetatable(q, clsQueue.__class_mt)
	return q
end

function clsQueue:Pop()
	local value
	if #self._queue > 0 then
		value = table.remove(self._queue, 1)
	end
	return value
end

function clsQueue:Push(value)
	table.insert(self._queue, value)
end

function clsQueue:Remove(value)
	local q = self._queue
	for idx = 1, #q do
		if q[idx] == value then
			return table.remove(self._queue, idx)
		end
	end
end

local clientQueue = clsQueue.New()
local clientMap = {}           -- accountId --> client
local fd2ClientId = {}         -- fd -- > accountId

function getClientByFd(fd)
	local accountId = fd2ClientId[fd]
	return accountId and clientMap[accountId]
end

-- 客户端
local clsClient = {clientCount = 0 }
clsClient.__class_mt = {__index = clsClient}
function clsClient.New(clientData)
	local o = {
		accountId = clientData.accountId,
		salt = clientData.salt,
		userInfo = clientData.userInfo,
		fd = clientData.fd,
		userId = nil,
	}
	setmetatable(o, clsClient.__class_mt)
	return o
end

function clsClient:Init()
	local accountId = self.accountId
	assert(not clientMap[accountId])

	clientMap[accountId] = self
	clientQueue:Push(accountId)	-- 开始排队

	clsClient.clientCount = clsClient.clientCount + 1
end

function clsClient:Update(clientData)
	self.fd = clientData.fd
	self.salt = clientData.salt
	self.userInfo = clientData.userInfo
end

function clsClient:EnterGame()
	assert(not self.agent)
	self.agent = newAgent()
	skynet.send(self.agent, "lua", "start", self.fd, self, true)
end

function clsClient:ReenterGame(fd)
	assert(fd and fd ~= self.fd)
	assert(self.agent)
	self.fd = fd
	skynet.send(self.agent, "lua", "start", self.fd, self, false)
end

function clsClient:SendBinMsg(msg)
	local packet, err = lrc4.xor_pack(msg, 100)
	if packet then
		socket.write(self.fd, packet)
	else
		logger.errorf("send_bin_msg error:%s", tostring(err))
	end
end

function clsClient:SendMsg(protoName, args)
	self:SendBinMsg(sproto_helper.pack_msg(protoName, args))
end

function clsClient:closeFd(reason)
	skynet.send(gate, "lua", "close_fd", skynet.self(), self.fd, reason)
end

function clsClient:Kick(reason)
	logger.infof("agentmgr_kick,agent=%s,reason=%s", tostring(self.agent), tostring(reason))
	if self.agent then
		skynet.send(self.agent, "lua", "Kick", reason)
		return
	end

	-- 同账号正在排队
	self:closeFd(reason)
	self:Release()
end

function clsClient:Release()
	fd2ClientId[self.fd] = nil
	clientMap[self.accountId] = nil

	clientQueue:Remove(self.accountId)
	if self.agent then
		freeAgent(self.agent)
	end
	clsClient.clientCount = clsClient.clientCount + 1
end

local function update()
	if shutingdown then
		return
	end

	local maxEnterCount = math.min(maxEnterPerBatch, maxAgentCount - getUseAgentCount())
	for i = 1, maxEnterCount do
		local accountId = clientQueue:Pop()
		if not accountId then
			break
		end
		client = clientMap[accountId]
		client:EnterGame()
	end

	-- TODO:提示排队玩家具体名次

	skynet.timeout(100, update)
end

local SOCKET = {}
function SOCKET.data(fd, msg)
	logger.debugf("SOCKET.data:fd=%d,msg=%s", fd, msg)
	skynet.send(gate, "lua", "close_fd", skynet.self(), self.fd, "agentmgr cant't receive data'")
end

local function handleSocketClose(fd)
	local client = getClientByFd(fd)
	if client then
		client:Release()
	end
end

function SOCKET.close(fd)
	logger.debugf("SOCKET.close:fd=%d", fd)
	handleSocketClose(fd)
end

function SOCKET.error(fd, msg)
	logger.debugf("SOCKET.error:fd=%d,msg=%s", fd, msg)
	handleSocketClose(fd)
end

function SOCKET.warning(fd, sz)
	logger.debugf("SOCKET.warning:fd=%d,sz=%s", fd, sz)
end

local CMD = {}
function CMD.socket(cmd, ...)
	return SOCKET[cmd](...)
end

function CMD.start()
	-- 启动多个数据库服务,负载均衡
	local databaseCount = math.ceil(maxAgentCount / agentPerDatabase)
	for i = 1, databaseCount do
		db = skynet.newservice("database")
		table.insert(databasePool, db)
	end

	-- 预分配一定数量的agent
	for i = 1, config_agentmgr.pre_alloc_agent_count or 0 do
		local agent = skynet.newservice("agent", gate, skynet.self(), nextDB())
		freeAgent(agent)
	end
	totalAgentCount = #freeAgentPool

	skynet.timeout(100, update)
end

function CMD.HandClient(clientData)
	skynet.send(gate, "lua", "forward_conn", skynet.self(), clientData.fd)

	local oriClient = clientMap[clientData.accountId]
	if oriClient then
		if oriClient.agent then
			-- 同账号客户端已进入游戏
			oriClient:Update(clientData)
			oriClient:ReenterGame()
		else
			-- 同账号客户端正在排队中
			oriClient:Kick("handle_client,same account")
			local newClient = clsClient.New(clientData)
			newClient:Init()
		end
	else
		local newClient = clsClient.New(clientData)
		newClient:Init()
	end
end

function GetCmdHandler(cmd)
	return CMD[cmd]
end

function SystemStartup(module)
end
