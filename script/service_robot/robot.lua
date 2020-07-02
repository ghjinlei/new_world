--[[
ModuleName :
Path : robot.lua
Author : jinlei
CreateTime : 2019-05-22 16:31:33
Description :
--]]
local skynet = require "skynet"
local skynet_helper = require "utils.skynet_helper"
local sproto_helper = require "utils.sproto_helper"
dofile("base/preload.lua")

GSOCK = GImport("lualib_robot/module/gsock.lua")
AUTH = GImport("lualib_robot/module/auth.lua")

local openId = ...

local TICK_INTERVAL = 200 -- 200毫秒一次tick
local function tick()
	GSOCK.Tick()
	skynet.timeout(TICK_INTERVAL / 10, tick)
end

local CMD = {}
function CMD.Connect()
	local serverAddr = skynet.getenv("server_addr")
	local paramList = string.split(serverAddr, ":")
	local host, port = paramList[1], tonumber(paramList[2])
	GSOCK.Connect(host, port)
end

function CMD.Login()
	AUTH.Login()
end

function CMD.Disconnect()
	GSOCK.Disconnect()
end

function CMD.Send(msg)
	GSOCK.Send(msg)
end

skynet.start(function()
	sproto_helper.load(1)
	skynet_helper.dispatch_lua_by_cmd(CMD)

	AUTH.SetOpenId(openId)
	skynet.timeout(1, tick)
end)

