--[[
ModuleName :
Path : scenemgr.lua
Author : jinlei
CreateTime : 2020-03-26 15:52:25
Description :
--]]

local skynet = require "skynet"
local logger = require "common.utils.logger"
local skynet_helper = require "common.utils.skynet_helper"

dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/scenemgr/main.lua")

skynet.start(function()
	logger.Init()

	skynet_helper.dispatch_lua_by_module(MAIN)

	skynet.register(".scenemgr")
end)
