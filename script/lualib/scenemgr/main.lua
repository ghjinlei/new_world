--[[
ModuleName :
Path : main.lua
Author : jinlei
CreateTime : 2020-03-26 16:02:05
Description :
--]]
local skynet = require "skynet"
local logger = require "common.logger"
local config_system = require "config_system"

clsSceneMgr = clsObject:Inherit()

function clsSceneMgr:onInit()

end

function clsSceneMgr:loadNavMesh()
end

function clsSceneMgr:loadCollision()

end

local autocode_Scene = false
function GetSceneInfoMap()
	return autocode_Scene
end


function __init__(module, updated)
	local function initAutocode(m)
		autocode_Scene = m.GetContent("Scene")
	end
	initAutocode(AUTOCODE.Load("autocode/scene.lua", initAutocode))
end
