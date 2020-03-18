--[[
ModuleName :
Path : auth.lua
Author : jinlei
CreateTime : 2018-11-11 01:33:27
Description :
--]]

local skynet = require "skynet"
local logger = require "common.logger"
local config = require "config_system"
local sprotoHelper = require "sproto_helper"

local clientMap = { }

local function genSalt()
	local a = math.random(1 << 31)
	local b = math.random(1 << 31)
	local c = math.random(1 << 31)
	return string.format("%08x%08x%08x", a, b, c)
end

-- 客户端
local clsClient = { }
function clsClient.New(fd, address)
	local o = {
		fd = fd,
		address = address,
		salt = genSalt(),
		userInfo = nil,
		mq = skynet.queue(),
	}
	setmetatable(o, {__index = clsClient})
	return o
end

function clsClient:HandShake(args)
	self.userInfo = args
	return {ok = true, salt = self.salt, patch = config.client_patch}
end

function clsClient:Auth(args)
	--TODO: 处理登录超时
	--TODO: 认证合法性
	--TODO: 检查是否封号
	local ok = true
	if ok then
		-- TODO: 校验成功
		skynet.send(".agentmgr", "lua", "NewClient", self.fd, self)
	else
		-- TODO: 校验失败
	end
	self.finish = true
	return {ok = ok}
end

function clsClient:Release()
	local fd = self.fd
	clientMap[fd] = nil
	skynet.send(".watchdog", "lua", "close", fd)
end

function clsClient:SendBinMsg(msg)
	skynet.send(".watchdog", "lua", "SendMsg", self.fd, string.pack(">s2", msg))
end

function clsClient:HandleClientMsg(msg)
	self.mq(function()
		if self.finish then --认证结束
			self:Release()
			return
		end

		local ok, result = sprotoHelper.DispatchAndHandleRequest(self, msg)
		if not ok then
			self:Release()
			return
		end

		if result then
			self:SendBinMsg(result)
		end
	end)
end

local SOCKET = {}
function SOCKET.data(fd, msg)
	logger.debugf("SOCKET.data:fd=%d,msg=%s", fd, tostring(msg))
	local client = clientMap[fd]
	if not client then
		return
	end
	client:HandleClientMsg(msg)
end

function SOCKET.connect(fd, address)
	logger.debugf("SOCKET.connect:fd=%d,address=%s", fd, address)
	assert(not clientMap[fd])
	local client = clsClient.New(fd, address)
	clientMap[fd] = client
end

local function handleDisconnect(fd)
	local client = clientMap[fd]
	if not client then
		return
	end
	clientMap[fd] = nil
end

function SOCKET.disconnect(fd)
	logger.debugf("SOCKET.disconnect:fd=%d", fd)
	handleDisconnect(fd)
end

local CMD = {}
function CMD.socket(cmd, ...)
	return SOCKET[cmd](...)
end

skynet.start(function()
	sprotoHelper.Init()
	sprotoHelper.RegMsgHandler("HandShake", clsClient.HandShake)
	sprotoHelper.RegMsgHandler("Auth", clsClient.Auth)

	skynet.dispatch("lua", function(session, source, cmd, ...)
		local f = assert(CMD[cmd])
		skynet.ret(skynet.pack(f(...)))
	end)
end)

