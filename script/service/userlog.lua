local skynet = require "skynet"
require "skynet.manager"
local fs = require "common.fs"
local logger = require "common.logger"
local config_system = require "config_system"
dofile("script/lualib/common/base/preload.lua")

local log_dirpath = config_system.log.dir
local max_cache_count = config_system.log.cache_count or 1
local log_shift_time = 3600 * 1

local function gen_log_filepath(time_now)
	return string.format("%s/%s.log", log_dirpath, os.date("%Y%m%d%H", time_now))
end

local function __G_TRACE_BACK__(err)
	print("\27[31m" .. "USERLOG ERROR:" .. tostring(err) .. "\n" ..  debug.traceback() .. "\27[0m")
end

--{{ clslogger begin
local clslogger = {}
function clslogger.new()
	local o = {
		_log_file = nil,        -- 日志文件
		_log_file_time = 0,     -- 日志文件时间
		_log_size = 0,          -- 当前日志大小
		_cache_count = 0,       -- 当前缓存日志数
	}
	setmetatable(o, {__index = clslogger})
	return o
end

function clslogger:init()
	local log = logger.format_log("-----------------LOGGER START-----------------", logger.loglevel_info, 0)
	self:add_log(log)
end

function clslogger:open_log_file(time_now)
	self:close_log_file()

	local new_log_filepath = gen_log_filepath(time_now)
	local dirpath = fs.dirname(new_log_filepath)
	if not fs.isdir(dirpath) then
		fs.mkdir(dirpath)
	end

	self._log_file = assert(io.open(new_log_filepath, "a+"))
	self._log_file_time = time_now
	self._log_size = self._log_file:seek("end")
end

function clslogger:close_log_file()
	if self._log_file then
		self:flush()
		self._log_file:close()
		self._log_file = nil
	end
end

function clslogger:add_log(log)
	local time_now = math.floor(skynet.time())
	if time_now - self._log_file_time >= log_shift_time then
		self:open_log_file(time_now)
	end

	self._log_file:write(log .. "\n")
	self._log_size = self._log_size + #log
	self._cache_count = self._cache_count + 1

	-- 超过max_cache_count行刷新
	if self._cache_count >= max_cache_count then
		self:flush()
	end
end

function clslogger:flush()
	if self._log_file and self._cache_count > 0 then
		self._log_file:flush()
		self._cache_count = 0
	end
end

function clslogger:close()
	local log = logger.format_log("-----------------LOGGER SHUTDOWN-----------------", logger.loglevel_info, 0)
	self:add_log(log)
	self:close_log_file()
end
--}} clslogger end

local logger_obj
local function init_log()
	logger_obj = clslogger.new()
	logger_obj:init()
end

local function on_message(msg, address)
	if not logger_obj then
		return
	end

	local msg_len = #msg
	if msg_len <= 3 then           -- 3字节以下为控制命令
		if msg == logger.cmd_close then
			logger_obj:close(msg, address)
			logger_obj = nil
		end
		return
	end

	local fmt_log = string.match(msg, "^%[%d+%s%d+:%d+:%d+%.%d+%]")
	if fmt_log then
		logger_obj:add_log(msg)
	else
		local log = logger.format_log(msg, logger.loglevel_skynet, address)
		logger_obj:add_log(log)
		logger.print_console(log, logger.loglevel_skynet)
	end
end

skynet.register_protocol {
	name = "text",
	id = skynet.PTYPE_TEXT,
	unpack = skynet.tostring,
	dispatch = function(_, address, msg)
		xpcall(function()
			on_message(msg, address)
		end, __G_TRACE_BACK__)
	end
}

skynet.start(function()
	print("init service start :userlog ......")
	xpcall(function()
		init_log()
	end, __G_TRACE_BACK__)

	skynet.register ".logger"
	print("init service finish :userlog")
end)
