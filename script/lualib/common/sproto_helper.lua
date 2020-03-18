--[[
ModuleName :
Path : script/lualib/common/sproto_helper.lua
Author : jinlei
CreateTime : 2019-06-26 20:48:15
Description :
--]]
local sprotoloader = require "sprotoloader"
local sprotoHost
local sprotoRequest

local sprotoHelper = {}
function sprotoHelper.Init()
	sprotoHost = sprotoloader.load(1):host "package"
	sprotoRequest = sprotoHost:attach(sprotoloader.load(2))
end

local msgHandlers = {}
function sprotoHelper.RegMsgHandler(protoName, handler)
	assert(type(protoName) == "string")
	msgHandlers[protoName] = handler
end

function sprotoHelper.RegMsgHandlers(handlers)
	for protoName, handler in pairs(handlers) do
		sprotoHelper.RegMsgHandler(protoName, handler)
	end
end

function sprotoHelper.Dispatch(msg, sz)
	return pcall(sprotoHost.dispatch, sprotoHost, msg, sz)
end

local emptyTable = {}
function sprotoHelper.HandleRequest(name, args, response, ...)
	local handler = msgHandlers[name]
	if not handler then
		return false, "sproto does not include" .. name
	end
	local ok, ret = xpcall(handler, __G_TRACE_BACK__, args, ...)
	return ok, response and response(ret or emptyTable)
end

function sprotoHelper.DispatchAndHandleRequest(msg, sz, ...)
	local ok, type, name, args, response = sprotoHelper.Dispatch(msg, sz)
	if not ok then
		return false, "execute error"
	end
	if type ~= "REQUEST" then
		return false, "bad proto direction"
	end
	return sprotoHelper.HandleRequest(name, args, response, ...)
end

function sprotoHelper.PackMsg(protoName, args, sessionId)
	return sprotoRequest(protoName, args, sessionId)
end

return sprotoHelper
