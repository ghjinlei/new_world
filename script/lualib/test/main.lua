--[[
ModuleName :
Path : main.lua
Author : jinlei
CreateTime : 2020-03-27 17:21:00
Description :
--]]

local lrc4 = require "lrc4"

local c_rc4 = lrc4.new("0123456789abcdef")

local packedMsg = "abcdefg"
print("##############test1##################")
packet, err = c_rc4:pack(packedMsg)
print("packet:", packet)
local byteList = {}
for i = 1, #packet do
	local char = string.sub(packet, i, i)
	table.insert(byteList, string.byte(char))
end
print(table.concat(byteList, ","))

c_rc4:reset("0123456789abcdef")
packet = string.sub(packet, 3)
local msg, err = c_rc4:unpack(packet)
print("msg, err:", msg, err)
