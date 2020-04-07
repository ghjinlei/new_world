--[[
ModuleName :
Path : robot.lua
Author : jinlei
CreateTime : 2019-05-22 16:31:33
Description :
--]]
local skynet = require "skynet"
local utils = require "common.utils"
dofile("script/lualib/common/base/preload.lua")

GSOCK = GImport("lualib/robot/gsock.lua")
AUTH = GImport("lualib/robot/auth.lua")

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
	local sproto_helper = require "common.sproto_helper"
	sproto_helper.init()
	utils.DispatchLuaByCmd(CMD)

	AUTH.SetOpenId(openId)
	skynet.timeout(1, tick)
end)

