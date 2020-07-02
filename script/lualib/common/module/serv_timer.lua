--[[
ModuleName :
Path : lualib/common/module/serv_timer.lua
Author : jinlei
CreateTime : 2019-06-21 15:21:44
Description :
--]]
local skynet = require "skynet"

__timerMap = {}
setmetatable(__timerMap, {__mode = "v"})

__timerId = 0
local function genTimerId()
	__timerId = __timerId + 1
	return __timerId
end

local function newTimer(start, interval, count, func)
	local timer = {
		start = math.ceil(start * 100),
		interval = math.ceil(interval * 100),
		count = count,
		func = func,
	}
	if timer.start < 1 then
		timer.start = 1
	end
	if timer.interval < 1 then
		timer.interval = 1
	end
end

function AddTimer(start, interval, count, func)
	if count == 0 then
		return
	end

	local timerId = genTimerId()
	local timer = newTimer(start, interval, count, func)
	__timerMap[timerId] = timer

	local function triggerFunc()
		local func = timer.func
		if not func then
			return
		end

		func()

		local count = timer.count
		if count > 0 then
			count = count - 1
			timer.count = count
		end

		if count == 0 then
			return
		end

		skynet.timeout(timer.interval, triggerFunc)
	end

	skynet.timeout(timer.start, triggerFunc)
end

function RemoveTimer(timerId)
	local timer = __timerMap__[timerId]
	if not timer then
		return
	end
	__timerMap[timerId] = nil
	timer.func = nil
end

