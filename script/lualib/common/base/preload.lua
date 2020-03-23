--[[
ModuleName :
Path : preload.lua
Author : jinlei
CreateTime : 2019-05-21 14:16:12
Description :
--]]
local utils = require "common.utils"

__G_TRACE_BACK__ = utils.traceback

local __LUA_SERACH_PATH__ = "./script"
function GLoadFile(relaPath, env)
	return loadfile(__LUA_SERACH_PATH__ .. "/" .. relaPath, "bt", env)
end

function GDoScriptFile(relaPath)
	local m = nil
	xpcall(function()
		local func, err = assert(GLoadFile(relaPath, _G))
		m = func()
	end, utils.traceback)
	return m
end

local function loadGlobalFileList()
	local globalFileList = {
		"lualib/common/base/extend.lua",
		"lualib/common/base/import.lua",
	}

	for _, filePath in ipairs(globalFileList) do
		GDoScriptFile(filePath)
	end
end

loadGlobalFileList()

