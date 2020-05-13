--[[
ModuleName :
Path : agent.lua
Author : jinlei
CreateTime : 2018-11-11 01:34:22
Description :
--]]
local skynet = require "skynet"
local utils = require "common.utils"
local sproto_helper = require "common.sproto_helper"
dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/agent/main.lua")
MAIN.gate, MAIN.agentmgr, MAIN.database = ...

skynet.start(function()
	sproto_helper.init()
	MAIN:SystemStartup()

	utils.DispatchLuaByModule(MAIN)
end)

