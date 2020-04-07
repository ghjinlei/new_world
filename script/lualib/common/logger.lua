--[[
ModuleName :
Path : ../lualib/common/logger.lua
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

local loglevel_prefix_map = {
	[loglevel_debug] = "\27[0m",
	[loglevel_info] = "\27[32m",
	[loglevel_warn] = "\27[33m",
	[loglevel_error] = "\27[31m",
	[loglevel_fatal] = "\27[36m",
}
local loglevel_tag_map = {
	[loglevel_debug] = "[debug]",
	[loglevel_info] = "[info]",
	[loglevel_warn] = "[warn]",
	[loglevel_error] = "[error]",
	[loglevel_fatal] = "[fatal]",
}
local log_suffix = "\27[0m"

local log_time_format = config_system.log.time_format or "%Y%m%d %H:%M:%S"
local function gen_log_header(time_now_10ms, address)
	local sec, decimals = math.modf(time_now_10ms)
	local time_str = os.date(log_time_format, sec)
	local tm10ms = math.floor(decimals * 100)
	return string.format("[%s.%02d][:%08x]", time_str, tm10ms, address)
end

local function print_console(level, msg)
	local prefix = loglevel_prefix_map[level]
	local level_tag = loglevel_tag_map[level]
	local log_header = gen_log_header(skynet.time(), skynet.self())
	msg = prefix .. log_header .. level_tag .. msg .. log_suffix
	io.write(msg .. '\n')
end

local function send_logger(level, msg)
	local level_tag = loglevel_tag_map[level]
	msg = level_tag .. msg
	skynet.error(msg)
end

local function write(level, msg)
	if not (level and msg) then return end

	if level >= loglevel_for_console then
		print_console(level, msg)
	end
	if level >= loglevel then
		send_logger(level, msg)
	end
end
--]]

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

function logger.warning(msg)
	write(loglevel_warn, msg)
end

function logger.warningf(...)
	write(loglevel_warn, string.format(...))
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
