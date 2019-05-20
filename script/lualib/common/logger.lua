--[[
ModuleName :
Path : ../lualib/common/logger.lua
Author : jinlei
CreateTime : 2018-11-11 03:45:55
Description :
--]]
local skynet = require "skynet"
local config_system = require "config_system"

local LogLevel = config_system.log.level
local LogLevelForConsole = config_system.log.level_for_console

local loglevel_debug = 1
local loglevel_info = 2
local loglevel_warn = 3
local loglevel_error = 4
local loglevel_fatal = 5

local LogLevelPrefixMap = {
	[loglevel_debug] = "\27[0m",
	[loglevel_info] = "\27[32m",
	[loglevel_warn] = "\27[33m",
	[loglevel_error] = "\27[31m",
	[loglevel_fatal] = "\27[36m",
}
local LogLevelTagMap = {
	[loglevel_debug] = "[debug]",
	[loglevel_info] = "[info]",
	[loglevel_warn] = "[warn]",
	[loglevel_error] = "[error]",
	[loglevel_fatal] = "[fatal]",
}
local LogSuffix = "\27[0m"

local LogTimeFormat = config_system.log.time_format or "%Y%m%d %H:%M:%S"
local function genLogHeader(timeNowMilli, address)
	local sec, decimals = math.modf(timeNowMilli)
	local timeStr = os.date(LogTimeFormat, sec)
	local tm10ms = math.floor(decimals * 100)
	return string.format("[%s.%02d][:%08d]", timeStr, tm10ms, address)
end

local function printConsole(level, msg)
	local prefix = LogLevelPrefixMap[level]
	local levelTag = LogLevelTagMap[level]
	local logHeader = genLogHeader(skynet.time(), skynet.self())
	msg = prefix .. logHeader .. levelTag .. msg .. LogSuffix
	io.write(msg .. '\n')
end

local function sendLogger(level, msg)
	local levelTag = LogLevelTagMap[level]
	msg = levelTag .. msg
	skynet.error(msg)
end

local function write(level, msg)
	if not (level and msg) then return end

	if level >= LogLevelForConsole then
		printConsole(level, msg)
	end
	if level >= LogLevel then
		sendLogger(level, msg)
	end
end

local logger = {}
function logger.debug(msg)
	write(loglevel_debug, msg)
end

function logger.debugf(...)
	write(loglevel_debug, string.format(...))
end

function logger.info(msg)
	write(loglevel_info, msg)
end

function logger.infof(...)
	write(loglevel_info, string.format(...))
end

function logger.error(msg)
	write(loglevel_error, msg)
end

function logger.errorf(...)
	write(loglevel_error, string.format(...))
end

function logger.fatal(msg)
	write(loglevel_fatal, msg)
end

function logger.fatalf(...)
	write(loglevel_fatal, string.format(...))
end

function logger.shutdown()
	skynet.error("[!shutdown]")
end

return logger
