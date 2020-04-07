--[[
ModuleName :
Path : ../lualib/common/utils.lua
Author : jinlei
CreateTime : 2018-11-11 02:37:51
Description :
--]]
local skynet = require "skynet"
local logger = require "common.logger"

local utils = {}

function utils.traceback(err)
	local errMsg = err .. "\n" .. debug.traceback()
	logger.error(errMsg)
end

function utils.pcallRet(session, ok, ...)
	if session ~= 0 then
		if not ok then
			skynet.ret()
		else
			skynet.retpack(...)
		end
	end
end

function utils.DispatchLuaByCmd(CMD)
	skynet.dispatch("lua", function(session, source, cmd, ...)
		local f = CMD[cmd]
		if f then
			utils.pcallRet(session, xpcall(f, utils.traceback, ...))
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
			utils.pcallRet(session, xpcall(func, utils.traceback, ...))
			return
		end
		logger.errorf("drop command=%s from %08x session=%d:", cmd, source, session)
		if session ~= 0 then
			skynet.ret()
		end
	end)
end

return utils
