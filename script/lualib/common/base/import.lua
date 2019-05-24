--[[
ModuleName :
Path : import.lua
Author : jinlei
CreateTime : 2019-05-22 09:43:43
Description :
--]]

_G.ImportModule = _G.ImportModule or {}
local ImportModule = _G.ImportModule
_G.ModuleList = _G.ModuleList or {}
local ModuleList = _G.ModuleList

_G.setfenv = _G.setfenv or function(f, t)
	f = (type(f) == 'function' and f or debug.getinfo(f + 1, 'f').func)
	local name
	local up = 0
	repeat
		up = up + 1
		name = debug.getupvalue(f, up)
	until name == '_ENV' or name == nil
	if name then
		debug.setupvalue(f, up, t)
	end
	return f
end

local function loadLuaFile(relaPath)
	return GLoadFile(relaPath, nil)
end

local function callModuleInit(module, updated)
	if rawget(module, "__init__") then
		xpcall(module.__init__, __G_TRACE_BACK__, module, updated)
	end
end

local function safeImport(relaPath, env)
	local old = ImportModule[relaPath]
	if old then
		return old
	end

	local func, err = loadLuaFile(relaPath)
	if not func then
		return nil, err
	end

	local new = {__IS_MODULE__ = true}
	ImportModule[relaPath] = new
	table.insert(ModuleList, new)

	setmetatable(new, {__index = _G})
	setfenv(func, new)()

	callModuleInit(new, updated)

	return new
end

function GImport(relaPath, env)
	local module, err = safeImport(relaPath, env)
	assert(module, err)
	return module
end

