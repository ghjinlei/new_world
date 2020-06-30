--[[
ModuleName :
Path : ../lualib/common/utils/skynet_helper.lua
Author : jinlei
CreateTime : 2018-11-11 02:37:51
Description :
--]]
local skynet = require "skynet"
local ltrace = require "ltrace"
local logger = require "common.utils.logger"

local function pcall_ret(session, ok, ...)
	if session ~= 0 then
		if not ok then
			skynet.ret()
		else
			skynet.retpack(...)
		end
	end
end

local skynet_helper = {}

function skynet_helper.traceback(err)
	local errMsg = err .. "\n" .. ltrace.traceback()
	logger.error(errMsg)
end

function skynet_helper.dispatch_lua_by_cmd(CMD)
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local f = CMD[cmd]
		if f then
			pcall_ret(session, xpcall(f, skynet_helper.traceback, ...))
			return
		end

		logger.errorf("drop command=%s from %08x session=%d:", cmd, source, session)

		if session ~= 0 then
			skynet.ret()
		end
	end)
end

function skynet_helper.dispatch_lua_by_module(module)
	assert(module and type(module.GetCmdHandler) == "function")
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local func = module.GetCmdHandler(cmd)
		if func then
			pcall_ret(session, xpcall(func, skynet_helper.traceback, ...))
			return
		end
		logger.errorf("drop command=%s from %08x session=%d:", cmd, source, session)
		if session ~= 0 then
			skynet.ret()
		end
	end)
end

return skynet_helper
