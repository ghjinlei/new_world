--[[
ModuleName :
Path : extend.lua
Author : jinlei
CreateTime : 2019-05-21 11:48:30
Description :
--]]
local string = string

function string.split(str, sep, num)
	assert(not num or num > 0)
	sep = sep or " "
	local list = {}
	local count = 0
	for substr in string.gmatch(str, "[^" .. sep .. "]+") do
		table.insert(list, substr)
		count = count + 1
		if num and count >= num then
			break
		end
	end
	return list
end

