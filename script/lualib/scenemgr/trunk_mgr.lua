--[[
ModuleName :
Path : lualib/scenemgr/trunk_mgr.lua
Author : jinlei
CreateTime : 2020-04-20 17:44:47
Description :
--]]

local skynet = require "skynet"
local logger = require "logger"
local skynet_queue = require "skynet.queue"

clsTrunkMgr = clsObject:Inherit()
function clsTrunkMgr:onInit()
	self._lock = skynet_queue()      -- 串行化一些操作

	self._protoId2SceneId = {}
	self._sceneMap = {}
end

function clsTrunkMgr:GetScene(sceneId)
	return self._sceneMap[sceneId]
end

function clsTrunkMgr:OnUserEnter(sceneId, userId)
	local scene = self:GetScene(sceneId)
	assert(scene, string.format("scene(%d) is not found", sceneId))
	scene:OnUserEnter(userId)

	self._userId2SceneId[userId] = sceneId
end

function clsTrunkMgr:OnUserLeave(userId)
	local sceneId = self._userId2SceneId[userId]
	local scene = sceneId and self:GetScene(sceneId)
	if scene then
		scene:OnUserLeave(userId)
	else
		logger.warningf("clsTrunkMgr:OnUserLeave:can not find scene by userid(%s)", tostring(userId))
	end

	self._userId2SceneId[userId] = nil
end

function clsTrunkMgr:GetOrCreateScene(sceneId, sceneProtoId)
	local scene = self:GetScene(sceneId)
	if scene then
		return scene
	end

	self._lock(function()

	end)
end
