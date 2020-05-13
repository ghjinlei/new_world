--[[
ModuleName :
Path : main.lua
Author : jinlei
CreateTime : 2020-03-12 22:33:40
Description :
--]]
local skynet = require "skynet"
local lunix = require "lunix"
local logger = require "common.logger"
local config_system = require("config_system")
local config_server = config_system.server
local config_auth = config_system.auth

debug_console = false
protoloader = false
gate = false
agentmgr = false
authList = {}


function Main()
	debug_console = skynet.uniqueservice("debug_console", config_server.debug_console_port)

	protoloader = skynet.uniqueservice("protoloader")

	gate = skynet.newservice("gate")

	agentmgr = skynet.newservice("agentmgr", gate)

	-- 启动多个auth
	for i = 1, config_auth.auth_count do
		local auth = skynet.newservice("auth", gate, agentmgr)
		table.insert(authList, auth)
	end
	skynet.call(gate, "lua", "set_auth_list", authList)

	skynet.call(agentmgr, "lua", "start")
	-- gate需要最后开放
	skynet.call(gate, "lua", "open")
end

local CMD = {}

function GetCmdHandler(cmd)
	return CMD[cmd]
end
