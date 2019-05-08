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
		queue = q
		if type then
			handler[type](...)
		end
	end
}

function handler.open()
end

function handler.connect(fd, addr)
	local c = {
		fd = fd,
		ip = addr,
	}
	connection[fd] = c
end

function handler.message(fd, msg, sz)
	local c = connection[fd]
	local agent = c.agent
end

function handler.error(fd, msg)
end

local CMD = setmetatable({}, { __gc = function() netpack.clear(queue) end })
local socket = nil
-- 启动监听，开始服务;
function CMD.open()
	assert(not socket)
	local ip, port = table.unpack(string.split(config_gated.listen_addr, ":"))
	port = tonumber(port)

	socket = socketdriver.listen(address, port)
	socketdriver.start(socket)
end

function CMD.close()
	assert(socket)
	socketdriver.close(socket)
end

function CMD.close_fd(fd)
	assert(fd ~= socket)
	socketdriver.close(fd)
end

function CMD.SetAuthList(list)
	authList = list
end

skynet.start(function()
	utils.DispatchLua(CMD)
end)

