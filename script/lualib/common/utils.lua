--[[
ModuleName :
Path : ../lualib/common/utils.lua
Author : jinlei
CreateTime : 2018-11-11 02:37:51
Description :
--]]
local skynet = require "skynet"
local ltrace = require "ltrace"
local logger = require "common.logger"

local function pcallRet(session, ok, ...)
	if session ~= 0 then
		if not ok then
			skynet.ret()
		else
			skynet.retpack(...)
		end
	end
end

local utils = {}

function utils.traceback(err)
	local errMsg = err .. "\n" .. ltrace.traceback()
	logger.error(errMsg)
end

function utils.DispatchLuaByCmd(CMD)
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local f = CMD[cmd]
		if f then
			pcallRet(session, xpcall(f, utils.traceback, ...))
			return
		end

		logger.errorf("drop command=%s from %08x session=%d:", cmd, source, session)

		if session ~= 0 then
			skynet.ret()
		end
	end)
end

function utils.DispatchLuaByModule(module)
	assert(module and type(module.GetCmdHandler) == "function")
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local func = module.GetCmdHandler(cmd)
		if func then
			pcallRet(session, xpcall(func, utils.traceback, ...))
			return
		end
		logger.errorf("drop command=%s from %08x session=%d:", cmd, source, session)
		if session ~= 0 then
			skynet.ret()
		end
	end)
end

return utils
