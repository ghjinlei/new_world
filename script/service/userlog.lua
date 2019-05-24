
local skynet = require "skynet"
require "skynet.manager"
local fs = require "common.fs"
local config_system = require "config_system"
dofile("script/lualib/common/base/preload.lua")

local LogDirPath = config_system.log.dir
local MaxCacheCount = config_system.log.cache_count or 1
local LogShiftTime = 3600 * 1

local LogTimeFormat = config_system.log.time_format or "%Y%m%d %H:%M:%S"
local function genLogHeader(timeNowMilli, address)
	local sec, decimals = math.modf(timeNowMilli)
	local timeStr = os.date(LogTimeFormat, sec)
	local tm10ms = math.floor(decimals * 100)
	return string.format("[%s.%02d][:%08d]", timeStr, tm10ms, address)
end

local function getLogFileTime(timeNow)
	local t = os.date("*t", timeNow)
	t.min = 0
	t.sec = 0
	return os.time(t)
end

local function genLogFilePath(timeNow)
	return string.format("%s/%s.log", LogDirPath, os.date("%Y%m%d%H", timeNow))
end

local function __G_TRACE_BACK__(err)
	print("\27[31m" .. "USERLOG ERROR:" .. tostring(err) .. "\n" ..  debug.traceback() .. "\27[0m")
end

--{{ clsLogger begin
local clsLogger = {}
function clsLogger.New()
	local o = {
		_logFile = nil,		-- 日志文件
		_logFileTime = 0,	-- 日志文件时间
		_logSize = 0,		-- 当前日志大小
		_cacheCount = 0,	-- 当前缓存日志数
	}
	setmetatable(o, {__index = clsLogger})
	return o
end

function clsLogger:Init()
	self:AddLog("[info]-----------------LOGGER START-----------------", 0)
end

function clsLogger:openLogFile(timeNow)
	self:closeLogFile()

	local newLogFilePath = genLogFilePath(timeNow)
	local dirPath = fs.Dirname(newLogFilePath)
	if not fs.IsDir(dirPath) then
		fs.Mkdir(dirPath)
	end

	self._logFile = assert(io.open(newLogFilePath, "a+"))
	self._logFileTime = timeNow
	self._logSize = self._logFile:seek("end")
end

function clsLogger:closeLogFile()
	if self._logFile then
		self:Flush()
		self._logFile:close()
		self._logFile = nil
	end
end

function clsLogger:AddLog(msg, address)
	local timeNowMilli = skynet.time()
	local logHeader = genLogHeader(timeNowMilli, address)
	msg = logHeader .. msg

	local timeNow = math.floor(timeNowMilli)
	if timeNow - self._logFileTime >= LogShiftTime then
		self:openLogFile(timeNow)
	end

	self._logFile:write(msg .. "\n")
	self._logSize = self._logSize + #msg
	self._cacheCount = self._cacheCount + 1

	-- 超过MaxCacheCount行刷新
	if self._cacheCount >= MaxCacheCount then
		self:Flush()
	end
end

function clsLogger:Flush()
	if self._logFile and self._cacheCount > 0 then
		self._logFile:flush()
		self._cacheCount = 0
	end
end

function clsLogger:Close()
	self:AddLog("[info]-----------------LOGGER SHUTDOWN-----------------", 0)
	self:closeLogFile()
end
--}} clsLogger end

local loggerObj
local function initLog()
	loggerObj = clsLogger.New()
	loggerObj:Init()
end

local function onMessage(msg, address)
	if not loggerObj then
		return
	end

	local tag = string.match(msg, "^%[(.-)%]")
	if tag == "!shutdown" then
		loggerObj:Close(msg, address)
		loggerObj = nil
	else
		loggerObj:AddLog(msg, address)
	end
end

skynet.register_protocol {
	name = "text",
	id = skynet.PTYPE_TEXT,
	unpack = skynet.tostring,
	dispatch = function(_, address, msg)
		xpcall(function()
			onMessage(msg, address)
		end, __G_TRACE_BACK__)
	end
}

skynet.start(function()
	print("init service start :userlog ......")
	xpcall(function()
		initLog()
	end, __G_TRACE_BACK__)

	skynet.register ".logger"
	print("init service finish :userlog")
end)
