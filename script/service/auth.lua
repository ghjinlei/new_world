--[[
ModuleName :
Path : auth.lua
Author : jinlei
CreateTime : 2018-11-11 01:33:27
Description :
--]]

local skynet = require "skynet"
local skynet_helper = require "common.utils.skynet_helper"
local sproto_helper = require "common.utils.sproto_helper"
dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/auth/main.lua")
MAIN.gate, MAIN.agentmgr = ...

skynet.start(function()
	sproto_helper.load(1)
	MAIN:SystemStartup()

	skynet_helper.dispatch_lua_by_module(MAIN)
end)


