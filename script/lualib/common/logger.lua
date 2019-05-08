--[[
ModuleName :
Path : ../lualib/common/logger.lua
Author : jinlei
CreateTime : 2018-11-11 03:45:55
Description :
--]]
local skynet = require "skynet"

local logger = {}

function logger.debug(...)
	print("debug:", ...)
end

function logger.debugf(...)
	logger.debug(string.format(...))
end

function logger.info(...)
	print("info:", ...)
end

function logger.infof(...)
	logger.info(string.format(...))
end

function logger.error(...)
	print("error:", ...)
end

function logger.errorf(...)
	logger.errorf(string.format(...))
end

return logger
