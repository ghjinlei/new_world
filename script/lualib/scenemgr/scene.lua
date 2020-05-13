--[[
ModuleName :
Path : lualib/scenemgr/scene.lua
Author : jinlei
CreateTime : 2020-04-20 17:54:47
Description :
--]]
local skynet = require "skynet"

function CreateScene(sceneId, service)

end

clsScene = clsObject:Inherit()

function clsScene:onInit()

end

function clsScene:SendScene(...)
	skynet.send(self._addr, "lua", ...)
end

function clsScene:CallScene(....)
	return skynet.call(self._addr, "lua", ...)
end

--{{begin of clsSceneService
clsSceneService = clsObject:Inherit()

function clsSceneService:onInit(OCI)

end

function clsSceneService:SendScene(...)
	skynet.send(self._addr, "lua", ...)
end

function clsSceneService:CallScene(...)
	return skynet.call(self._addr, "lua", ...)
end

function clsSceneService:GetScene(sceneId)
	return self._sceneId2Scene[sceneId]
end

function clsSceneService:AddScene(scene)
	local sceneId = scene._sceneId
end

function clsSceneService:RemoveScene(sceneId)
	self._sceneId2Scene[sceneId] = nil
end
--}}
