--[[
ModuleName :
Path : preload.lua
Author : jinlei
CreateTime : 2019-05-21 14:16:12
Description :
--]]
local skynet_helper = require "utils.skynet_helper"

__G_TRACE_BACK__ = skynet_helper.traceback

local __LUA_SERACH_PATH__ = "./script"
function GLoadFile(relaPath, env)
	return loadfile(__LUA_SERACH_PATH__ .. "/" .. relaPath, "bt", env)
end

function GDoScriptFile(relaPath)
	local m = nil
	xpcall(function()
		local func, err = assert(GLoadFile(relaPath, _G))
		m = func()
	end, __G_TRACE_BACK__)
	return m
end

local function loadGlobalFileList()
	local globalFileList = {
		"lualib_robot/base/import.lua",
		"lualib_robot/base/class.lua",
		"lualib_robot/base/extend.lua",
	}

	for _, filePath in ipairs(globalFileList) do
		GDoScriptFile(filePath)
	end
end

loadGlobalFileList()

