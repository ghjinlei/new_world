--[[
ModuleName :
Path : auth.lua
Author : jinlei
CreateTime : 2018-11-11 01:33:27
Description :
--]]

local skynet = require "skynet"
local utils = require "common.utils"
local sproto_helper = require "common.sproto_helper"
dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/auth/main.lua")

skynet.start(function()
	print("init service start :auth ......")
	sproto_helper.Init()
	MAIN:SystemStartup()
	utils.DispatchLuaByModule(MAIN)
	print("init service finish :auth")
end)


