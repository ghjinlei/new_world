local skynet = require "skynet"
local netpack = require "skynet.netpack"
local socketdriver = require "skynet.socketdriver"
local config_gate = require("config_system").gate
local utils = require "common.utils"
local logger = require "common.logger"

local maxclient = config_gate.maxclient or 1024
local client_number = 0
local nodelay = false
local queue           -- message queue
local authList = false
local authIdx = 0
local connection = {}
--[[
	[fd] = {
		agent = xxx,
		conn = xxx,
	}
--]]

skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
}

skynet.register_protocol {
        name = "socket",
        id = skynet.PTYPE_SOCKET,       -- PTYPE_SOCKET = 6
        unpack = function ( msg, sz )
                return netpack.filter( queue, msg, sz)
        end,
        dispatch = function (_, _, q, type, ...)
                queue = q
                if type then
                        MSG[type](...)
                end
        end
}

local MSG = {}
local function dispatch_msg(fd, msg, sz)
	-- recv a package, forward it
	local c = connection[fd]
	local agent = c.agent
	if agent then
		-- It's safe to redirect msg directly , gateserver framework will not free msg.
		skynet.redirect(agent, c.client, "client", fd, msg, sz)
	else
		skynet.send(c.conn, "lua", "socket", "data", fd, skynet.tostring(msg, sz))
		-- skynet.tostring will copy msg to a string, so we must free msg here.
		skynet.trash(msg,sz)
	end
end

MSG.data = dispatch_msg

local function dispatch_queue()
	local fd, msg, sz = netpack.pop(queue)
	if fd then
		-- may dispatch even the handler.message blocked
		-- If the handler.message never block, the queue should be empty, so only fork once and then exit.
		skynet.fork(dispatch_queue)
		dispatch_msg(fd, msg, sz)

		for fd, msg, sz in netpack.pop, queue do
			dispatch_msg(fd, msg, sz)
		end
	end
end

MSG.more = dispatch_queue

function MSG.open(fd, address)
	if client_number >= maxclient then
		logger.infof("msg.open too many client! will close! fd=%d address=%s", fd, address)
		socketdriver.close(fd)
		return
	end
	logger.infof("msg.open fd=%d address=%s", fd, address)

	if nodelay then
		socketdriver.nodelay(fd)
	end

	--负载均衡,选择一个authd;
	local authNum = #authList
	if authNum == 0 then
		logger.errorf("msg.open has no authd")
		socketdriver.close(fd)
		return
	end

	authIdx = authIdx + 1
	if authIdx > authNum then
		authIdx = 1
	end

	local auth = authList[authIdx]

	connection[fd] = { conn = auth, address = address }
	client_number = client_number + 1
	socketdriver.start(fd)
	skynet.send(auth, "lua", "socket", "connect", fd, address)
end

local CMD = setmetatable({}, { __gc = function() netpack.clear(queue) end })
-- 启动坚挺，开始服务
function CMD.open(source)
	assert(not listen_sock)
	local ip,port = table.unpack( string.split(config_gated.listen_addr, ":") )
	port = tonumber(port)
	 
	listen_sock = socketdriver.listen(ip,port)
	logger.infof("******************Listen on %s:%d sock(%d)******************", ip,port, listen_sock)
	socketdriver.start(listen_sock)
	return true
end

-- 关闭监听
function CMD.close()
	logger.infof("*****************Close sock(%d)*****************",listen_sock or 0)
	if not listen_sock then 
		return 
	end
	socketdriver.close(listen_sock)
	listen_sock = nil
end

function CMD.forward(source, fd, client, address)
	local c = assert(connection[fd])
	c.client = client
	c.agent = address
	socketdriver.start(fd)
end

-- 建立客户端连接
function CMD.accept(source, fd)
	if connection[fd] then
		socketdriver.start(fd)
	end
end

-- 关闭客户端连接
function CMD.kick(source, fd)
	assert(fd and fd ~= listen_sock)
	logger.infof("gate_kick,source=%s,fd=%s", tostring(source), tostring(fd))

	connection[fd].conn = nil
	socketdriver.close(fd)
end

function CMD.SetAuthList(auths)
	authList = auths
end

skynet.start(function()
	logger.init()
	utils.DispatchLua(CMD)
end)
