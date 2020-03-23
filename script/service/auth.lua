--[[
ModuleName :
Path : auth.lua
Author : jinlei
CreateTime : 2018-11-11 01:33:27
Description :
--]]

local skynet = require "skynet"
local utils = require "common.utils"
local sprotoHelper = require "common.sproto_helper"
dofile("common/base/preload.lua")

MAIN = GImport("lualib/auth/main.lua")

skynet.start(function()
	sprotoHelper.Init()
	MAIN:SystemStartup()
	utils.DispatchLuaByModule(MAIN)
end)


