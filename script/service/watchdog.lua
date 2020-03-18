local skynet = require "skynet"
local socket = require "skynet.socket"
local config_system = require "config_system"
local logger = require "common.logger"

local gate
local agentmgr
local authList = {}
local authIdx = 0

local connection = {}

local SOCKET = {}
function SOCKET.open(fd, addr)
	skynet.error("New client from : " .. addr)
	-- 负载均衡，选择一个auth
	local authNum = #authList
	if authNum == 0 then
		logger.debug("watchdog has no auth")
		skynet.send(gate, "lua", "kick", fd)
		return
	end

	authIdx = authIdx % authNum + 1
	local auth = authList[authIdx]
	connection[fd] = {conn = auth, address = addr}

	skynet.call(gate, "lua", "accept", skynet.self(), fd)
	skynet.send(auth, "lua", "socket", "connect", fd, address)
end

local function close_conn(fd)
	local c = connection[fd]
	connection[fd] = nil
	if c then
		skynet.call(gate, "lua", "kick", fd)
		-- disconnect never return
		skynet.send(c.conn, "lua", "socket", "disconnect")
	end
end

function SOCKET.close(fd)
	print("socket close",fd)
	close_conn(fd)
end

function SOCKET.error(fd, msg)
	print("socket error",fd, msg)
	close_conn(fd)
end

function SOCKET.warning(fd, size)
	-- size K bytes havn't send out in fd
	print("socket warning", fd, size)
end

function SOCKET.data(fd, msg)
	local c = connection[fd]
	if c then
		skynet.send(c.conn, "lua", "socket", "data", fd, msg)
	end
end

local CMD = {}
function CMD.start(conf)
	skynet.call(gate, "lua", "open" , conf)
end

function CMD.close(fd)
	close_conn(fd)
end

function CMD.SendMsg(msg)
	if connection[fd] then
		socket.write(fd, msg)
	end
end

function CMD.Forward(fd, addr)
	local c = connection[fd]
	if c then
		c.conn = addr
	end
end

skynet.start(function()
	skynet.dispatch("lua", function(session, source, cmd, subcmd, ...)
		if cmd == "socket" then
			local f = SOCKET[subcmd]
			f(...)
			-- socket api don't need return
		else
			local f = assert(CMD[cmd])
			skynet.ret(skynet.pack(f(subcmd, ...)))
		end
	end)

	gate = skynet.newservice("gate")
	agentmgr = skynet.newservice("agentmgr", gate)
	for i = 1, config_system.auth.auth_count do
		local auth = skynet.newservice("auth")
		table.insert(authList, auth)
	end

	skynet.register ".watchdog"
end)
