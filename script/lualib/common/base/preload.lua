--[[
ModuleName :
Path : preload.lua
Author : jinlei
CreateTime : 2019-05-21 14:16:12
Description :
--]]
local skynet_helper = require "common.utils.skynet_helper"

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
		"common/base/macro.lua",
		"lualib/common/base/macro.lua",
		"lualib/common/base/global.lua",
		"common/base/import.lua",
		"common/base/class.lua",
		"common/base/extend.lua",
	}

	for _, filePath in ipairs(globalFileList) do
		GDoScriptFile(filePath)
	end
end

loadGlobalFileList()

TIME          = GImport("common/module/time.lua")
SERV_TIMER    = GImport("lualib/common/module/serv_timer.lua")
TIMER         = GImport("common/module/timer.lua")
