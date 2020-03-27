--[[
ModuleName :
Path : scenemgr.lua
Author : jinlei
CreateTime : 2020-03-26 15:52:25
Description :
--]]

local skynet = require "skynet"
local logger = require "common.logger"
local utils = require "common.utils"

dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/scenemgr/main.lua")

skynet.start(function()
	logger.Init()

	utils.DispatchLuaByModule(MAIN)

	skynet.register(".scenemgr")
end)
