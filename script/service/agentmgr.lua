--[[
ModuleName :
Path : agentmgr.lua
Author : jinlei
CreateTime : 2018-11-11 02:13:31
Description :
--]]
local skynet = require "skynet"
local sproto_helper = require "common.sproto_helper"
local utils = require "common.utils"
dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/agentmgr/main.lua")
MAIN.gate = ...

skynet.start(function()
	sproto_helper.init()
	MAIN:SystemStartup()

	utils.DispatchLuaByModule(MAIN)
end)
