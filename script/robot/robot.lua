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

GSOCK = GImport("robot/module/gsock.lua")

local robot = {}
function robot.Connect()
	local serverAddr = skynet.getenv("server_addr")
	local paramlist = string.split(serverAddr, ":")
	local host, port = paramlist[1], tonumber(paramlist[2])
	GSOCK.Connect(host, port)
end

function robot.Send(msg)
	GSOCK.Send(msg)
end

function robot.Disconnect()
	GSOCK.Disconnect()
end

skynet.start(function()
	utils.DispatchLua(robot)
end)

