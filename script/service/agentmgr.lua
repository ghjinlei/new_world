--[[
ModuleName :
Path : agentmgr.lua
Author : jinlei
CreateTime : 2018-11-11 02:13:31
Description :
--]]
local skynet = require "skynet"
local sproto_helper = require "common.utils.sproto_helper"
local skynet_helper = require "common.utils.skynet_helper"
dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/agentmgr/main.lua")
MAIN.gate = ...

skynet.start(function()
	sproto_helper.load(1)
	MAIN:SystemStartup()

	skynet_helper.dispatch_lua_by_module(MAIN)
end)
