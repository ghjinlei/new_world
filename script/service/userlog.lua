local skynet = require "skynet"
require "skynet.manager"
local misc = require "misc"

local LogDirPath = "./log"
local MaxCacheCount = 1
local LogShiftTime = 3600 * 1

local LogTimeFormat = "%Y%m%d %H:%M:%S"
function genLogHeader(sec, usec, address)
	local timeStr = os.date(LogTimeFormat, sec)
	return string.format("[%s.%06d][:%08d]", timeStr, usec, address)
end

function genLogFilePath(logTime)
	return string.format("%s/%s.log", LogDirPath, os.date("%Y%m%d%H", logTime))
end

function __G_TRACE_BACK__(err)
	print("\27[31m" .. "USERLOG ERROR:" .. tostring(err) .. "\n" ..  debug.traceback() .. "\27[0m")
end

--{{ clsLogger begin
local clsLogger = {}
function clsLogger.New()
	local o = {
		_logFile = nil,		-- 日志文件
		_logFileTime = nil,	-- 日志文件时间
		_logSize = 0,		-- 当前日志大小
		_cacheCount = 0,	-- 当前缓存日志数
	}
	setmetatable(o, {__index = clsLogger})
	return o
end

function clsLogger:Init()
	self:AddLog("[info]-----------------LOGGER START-----------------",0)
end

function clsLogger:openLogFile(timeNow)
	self:closeLogFile()

	local newLogFilePath = genLogFilePath(timeNow)
	local dirPath = FS.Dirname(newLogFilePath)
	if not FS.IsDir(dirPath) then
		FS.Mkdir(dirPath)
	end

	self._logFile = assert(io.open(newLogFilePath, "a+"))
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
	local sec, usec = misc.gettimeofday()
	local logHeader = genLogHeader(sec, usec, address)
	msg = logHeader .. msg

	if sec - self._logFileTime >= LogShiftTime then
		self:openLogFile(timeNow)
	end

	self._logFile:write(msg)
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
local function writeLog(msg, address)
	if not loggerObj then
		return
	end
	loggerObj:AddLog(msg, address)
end

skynet.register_protocol {
	name = "text",
	id = skynet.PTYPE_TEXT,
	unpack = skynet.tostring,
	dispatch = function(_, address, msg)
		xpcall(function()
			writeLog(msg, address)
		end, __G_TRACE_BACK__)
	end
}

skynet.register_protocol {
	name = "SYSTEM",
	id = skynet.PTYPE_SYSTEM,
	unpack = function(...) return ... end,
	dispatch = function()
		-- reopen signal
		print("SIGHUP")
	end
}

skynet.start(function()
	print("userlog init ......")
	initLog()
	skynet.register ".logger"
	print("userlog ready")
end)
