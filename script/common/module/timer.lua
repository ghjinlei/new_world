--[[
ModuleName : TIMER
Path : module/timer
Author : louiejin
CreateTime : 2019-08-16 23:39:14
Description :
--]]

local AddTimer
local RemoveTimer
if GIsClient() then
	AddTimer = CLI_TIMER.AddTimer
	RemoveTimer = CLI_TIMER.RemoveTimer
else
	AddTimer = SERV_TIMER.AddTimer
	RemoveTimer = SERV_TIMER.RemoveTimer
end

function TableRemoveTimer(tbl, timerId)
	RemoveTimer(timerId)
	if not tbl.__timers then return end
	tbl.__timers[timerId] = nil
end

function TableRemoveAllTimers(tbl)
    local timerIdMap = tbl.__timers
    if not tbl.__timers then return end
    for timerId, _ in pairs(timerIdMap) do
        RemoveTimer(timerId)
    end
    tbl.__timers = nil
end

-- 关联clsObject
clsObject.RemoveTimer = TableRemoveTimer
clsObject.RemoveAllTimers = TableRemoveAllTimers

local addTimerFuncMap = {}
function addTimerFuncMap.CallAfter(delay, callback)
    return AddTimer(delay, 0, 1, callback)
end

function addTimerFuncMap.CallAfterFre(delay, interval, count, callback)
    return AddTimer(delay, interval, count, callback)
end

function addTimerFuncMap.CallFre(interval, callback)
    return AddTimer(interval, interval, - 1, callback)
end

local function timeToDelay(time)
	return time - TIME.GetTimeMillis()
end

function addTimerFuncMap.CallAt(time, callback)
    return AddTimer(timeToDelay(time), 0, 1, callback)
end

function addTimerFuncMap.CallAtFre(time, interval, count, callback)
	return AddTimer(timeToDelay(time), interval, count, callback)
end

local function tableAddTimerId(tbl, timerId)
	if not tbl.__timers then
	    tbl.__timers = {}
	end
	tbl.__timers = {}
	return timerId
end

function __init__(module, updated)
	--[[
		TIMER.TableCallAfter(tbl, delay, callback)
		TIMER.TableCallAfterFre(tbl, delay, interval, count, callback)
		TIMER.TableCallFre(tbl, interval, callback, key)
		TIMER.TableCallAt(tbl, time, callback)
		TIMER.TableCallAtFre(tbl, time, interval, count, callback)

		对应的删除函数：
			TIMER.TableRemoveTimer(tbl, timerKey)
			TIMER.TableRemoveAllTimers(tbl)
    --]]
    for funcName, func in pairs(addTimerFuncMap) do
        module["Table" .. funcName] = function(tbl, ...)
            return tableAddTimerId(tbl, func(...))
        end
    end

	--[[
		clsObject:CallAfter(delay, callback)
		clsObject:CallAfterFre(delay, interval, count, callback)
		clsObject:CallFre(interval, callback, key)
		clsObject:CallAt(time, callback)
		clsObject:CallAtFre(time, interval, count, callback)

		对应的删除函数：
			clsObject:RemoveTimer(timerKey)
			clsObject:TableRemoveAllTimers()
	--]]
    for funcName, func in pairs(addTimerFuncMap) do
        clsObject[funcName] = function(obj, ...)
            return tableAddTimerId(obj, func(...))
        end
    end
end
