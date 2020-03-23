--[[
ModuleName :
Path : robot.lua
Author : jinlei
CreateTime : 2019-05-22 16:31:33
Description :
--]]
local skynet = require "skynet"
local utils = require "common.utils"
dofile("common/base/preload.lua")

GSOCK = GImport("robot/gsock.lua")

local CMD = {}
function CMD.Connect()
	local serverAddr = skynet.getenv("server_addr")
	local paramlist = string.split(serverAddr, ":")
	local host, port = paramlist[1], tonumber(paramlist[2])
	GSOCK.Connect(host, port)
end

function CMD.Send(msg)
	GSOCK.Send(msg)
end

function CMD.Disconnect()
	GSOCK.Disconnect()
end

skynet.start(function()
	utils.DispatchLuaByCmd(CMD)
end)

