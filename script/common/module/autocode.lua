--[[
ModuleName :
Path : common/module/autocode.lua
Author : jinlei
CreateTime : 2020-04-20 17:35:52
Description :
--]]

function Load(filePath, observer, onUpdate)
	local autocodeModule = GImport(filePath)
	if observer then
		EVENT.AddEventListener(observer, nil, EVENT.EVENT_MODULE_UPDATED, filePath, function (event)
			local autocodeModule = event:GetData()
			onUpdate(autocodeModule)
		end)
	end
	return autocodeModule
end
