--[[
ModuleName :
Path : gsock.lua
Author : jinlei
CreateTime : 2019-05-24 14:31:23
Description :
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"

local conn
function Connect(host, port)
	conn = socket.open(host, port)
end

function Disconnect()
	socket.close(conn)
end

function Send(msg)
	skynet.error("send_1:" .. msg)
	socket.write(conn, msg)
	skynet.error("send_2:" .. msg)
end

