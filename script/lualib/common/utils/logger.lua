--[[
ModuleName :
Path : ../lualib/common/utils/logger.lua
Author : jinlei
CreateTime : 2018-11-11 03:45:55
Description :
--]]
local skynet = require "skynet"
local config_system = require "config_system"

local loglevel = config_system.log.level
local loglevel_for_console = config_system.log.level_for_console

local loglevel_debug = 1
local loglevel_info = 2
local loglevel_warn = 3
local loglevel_error = 4
local loglevel_fatal = 5
local loglevel_skynet = 6

local loglevel_tag_map = {
	[loglevel_debug] = "[debug]",
	[loglevel_info] = "[info]",
	[loglevel_warn] = "[warn]",
	[loglevel_error] = "[error]",
	[loglevel_fatal] = "[fatal]",
	[loglevel_skynet] = "[skynet]",
}

local log_time_format = config_system.log.time_format or "%Y%m%d %H:%M:%S"
local function gen_log_header(address, time_now_10ms)
	local sec, decimals = math.modf(time_now_10ms)
	local time_str = os.date(log_time_format, sec)
	local tm10ms = math.floor(decimals * 100)
	return string.format("[%s.%02d][:%08x]", time_str, tm10ms, address)
end

local function format_log(msg, level, address, time_now_10ms)
	local level_tag = loglevel_tag_map[level]
	local log_header = gen_log_header(address or skynet.self(), time_now_10ms or skynet.time())
	local log = log_header .. level_tag .. msg
	return log
end

local loglevel_prefix_map = {
	[loglevel_debug] = "\27[0m",
	[loglevel_info] = "\27[32m",
	[loglevel_warn] = "\27[33m",
	[loglevel_error] = "\27[31m",
	[loglevel_fatal] = "\27[36m",
}
local log_suffix = "\27[0m"
local function print_console(log, level)
	local log_prefix = loglevel_prefix_map[level]
	if log_prefix then
		log = log_prefix .. log .. log_suffix
	end
	io.write(log .. "\n")
end

local function write(msg, level)
	if not (level and msg) then return end

	local log = format_log(msg, level)

	if level >= loglevel_for_console then
		print_console(log, level)
	end

	if level >= loglevel then
		skynet.error(log)
	end
end
--]]

local logger = {}

logger.loglevel_debug = loglevel_debug
logger.loglevel_info = loglevel_info
logger.loglevel_warn = loglevel_warn
logger.loglevel_error = loglevel_error
logger.loglevel_fatal = loglevel_fatal
logger.loglevel_skynet = loglevel_skynet

logger.format_log = format_log
logger.print_console = print_console

logger.cmd_flush = ">!f"
logger.cmd_close = ">!c"

function logger.debug(msg)
	write(msg, loglevel_debug)
end

function logger.debugf(...)
	write(string.format(...), loglevel_debug)
end

function logger.info(msg)
	write(msg, loglevel_info)
end

function logger.infof(...)
	write(string.format(...), loglevel_info)
end

function logger.warning(msg)
	write(loglevel_warn, msg)
end

function logger.warningf(...)
	write(string.format(...), loglevel_warn)
end

function logger.error(msg)
	write(msg, loglevel_error)
end

function logger.errorf(...)
	write(string.format(...), loglevel_error)
end

function logger.fatal(msg)
	write(msg, loglevel_fatal)
end

function logger.fatalf(...)
	write(string.format(...), loglevel_fatal)
end

function logger.close()
	skynet.error(logger.cmd_close)
end

return logger
