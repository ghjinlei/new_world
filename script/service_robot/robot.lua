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

local CMD = {}
function CMD.Connect()
	local serverAddr = skynet.getenv("server_addr")
	local paramList = string.split(serverAddr, ":")
	local host, port = paramList[1], tonumber(paramList[2])
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

