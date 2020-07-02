--[[
ModuleName :
Path : time.lua
Author : jinlei
CreateTime : 2020-07-02 17:24:22
Description :
--]]

GetTime = os.time

function GetTimeMillis()
	local sec, usec = misc.gettimeofday()
	return sec + usec / 1e6
end

--将"2005-06-01 00:00:00"格式的日期转换为time table形式
function Date2Table(dateTime)
	if type(dateTime) ~= "string" or
		not string.match(dateTime, "^%d+%-%d+%-%d+ %d+:%d+:%d+$") then
		return
	end

	local matchTable = {}

	for item in string.gmatch(dateTime, "%d+") do
		table.insert(matchTable, item)
	end

	local timeTable = {}
	timeTable.year = matchTable[1]
	timeTable.month = matchTable[2]
	timeTable.day = matchTable[3]
	timeTable.hour = matchTable[4]
	timeTable.min = matchTable[5]
	timeTable.sec = matchTable[6]
	return timeTable
end

--将"00:00:00"格式的日期转化为time table形式
function DayTime2Table(dayTime)
	if type(dayTime) ~= "string" or not string.match(dayTime, "%d+:%d+:%d+$") then
		return
	end
	local matchTable = {}

	for item in string.gmatch(dayTime, "%d+") do
		table.insert(matchTable, item)
	end

	local timeTable = {}
	timeTable.hour = matchTable[1]
	timeTable.min = matchTable[2]
	timeTable.sec = matchTable[3]
	return timeTable
end

--将"2006-06-01 10:00:00"这样的时间转换为秒
function Date2Sec(dateTime)
	return os.time(Date2Table(dateTime))
end

--将"10:00:00"这样的时间转化为秒
function DayTime2Sec(dayTime)
	local timeTable = DayTime2Table(dayTime)
	return timeTable.hour * 3600 + timeTable.min * 60 + timeTable.sec
end

--将秒数转成字符串 "2009-01-03 22:10:53"
function Sec2DateTime(sec)
	return os.date("%Y-%m-%d %H:%M:%S", sec or os.time())
end
