--[[
ModuleName :
Path : lualib/robot/sproto_helper.lua
Author : jinlei
CreateTime : 2020-03-30 19:38:52
Description :
--]]
local sprotoloader = require "sprotoloader"
local sproto_host
local sproto_request

local sproto_helper = {}

function sproto_helper.init()
	sproto_host = sprotoloader.load(1):host "package"
	sproto_request = sproto_host:attach(sprotoloader.load(2))
end

local msg_handlers = {}
function sproto_helper.reg_msghandler(proto_name, handler)
	assert(type(proto_name) == "string")
	msg_handlers[proto_name] = handler
end

function sproto_helper.reg_msghandlers(handlers)
	for proto_name, handler in pairs(handlers) do
		sproto_helper.reg_msghandler(proto_name, handler)
	end
end

function sproto_helper.dispatch(msg, sz)
	return pcall(sproto_host.dispatch, sproto_host, msg, sz)
end

local empty_table = {}
function sproto_helper.handle(userdata, name, args, response, ...)
	local handler = msg_handlers[name]
	if not handler then
		return false, "sproto does not include" .. name
	end
	local ok, ret = xpcall(handler, __G_TRACE_BACK__, userdata, args, ...)
	return ok, response and response(ret or empty_table)
end

function sproto_helper.dispatch_and_handle(userdata, msg, sz, ...)
	local ok, type, name, args, response = sproto_helper.dispatch(msg, sz)
	if not ok then
		return false, "execute error"
	end
	if type ~= "REQUEST" then
		return false, "bad proto direction"
	end
	return sproto_helper.handle(userdata, name, args, response, ...)
end
