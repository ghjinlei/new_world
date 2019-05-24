--[[
ModuleName :
Path : service/gated.lua
Author : jinlei
CreateTime : 2018-11-05 04:05:55
Description :
--]]
local skynet = require "skynet"
local netpack = require "skynet.netpack"
local socketdriver = require "skynet.socketdriver"
local utils = require "common.utils"
local config_gate = require("config_system").gate
local logger = require "common.logger"
dofile("script/lualib/common/base/preload.lua")

local connection = {}
local handler = {}
local authList = {}

local queue		-- message queue
skynet.register_protocol {
	name = "socket",
	id = skynet.PTYPE_SOCKET,	-- PTYPE_SOCKET = 6
	unpack = function ( msg, sz )
		return netpack.filter( queue, msg, sz)
	end,
	dispatch = function (_, _, q, type, ...)
		print("type:" .. tostring(type))
		queue = q
		if type then
			handler[type](...)
		end
	end
}

function handler.data(fd, msg, sz)
	logger.infof("handler.data:fd=%d,msg=%s,sz=%d", fd, tostring(msg), sz)
	--[[
	local c = connection[fd]
	local agent = c.agent
	if agent then	-- 存在agent发往agent
		skynet.send(agent, "lua", "socket", "message", fd, msg, sz)
	end
	--]]
end

function handler.more()
	logger.infof("handler.more")
end

function handler.open(fd, address)
	logger.infof("handler.open:fd=%d,address=%s", fd, address)
end

function handler.close()
	logger.infof("handler.more")
end

function handler.error(fd, msg)
	logger.infof("handler.error:fd=%s,msg=%s", fd, tostring(msg))
end

function handler.warning(fd, sz)
	logger.infof("handler.warning:fd=%s,sz=%d", fd, sz)
end

local CMD = setmetatable({}, { __gc = function() netpack.clear(queue) end })
local listen_socket = nil
-- 启动监听，开始服务;
function CMD.open()
	assert(not listen_socket)
	local ip, port = table.unpack(string.split(config_gate.listen_addr, ":"))
	port = tonumber(port)

	listen_socket = socketdriver.listen(ip, port)
	socketdriver.start(listen_socket)
end

function CMD.close()
	assert(listen_socket)
	socketdriver.close(listen_socket)
	listen_socket = nil
end

function CMD.close_fd(fd)
	assert(fd ~= listen_socket)
	socketdriver.close(fd)
end

function CMD.SetAuthList(list)
	authList = list
end

skynet.start(function()
	utils.DispatchLua(CMD)
end)

