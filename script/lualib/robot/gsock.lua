--[[
ModuleName :
Path : gsock.lua
Author : jinlei
CreateTime : 2019-05-24 14:31:23
Description :
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"
local lrc4 = require "lrc4"
local sproto_helper = require "common.sproto_helper"

local c_rc4 = lrc4.new("YGv93ebZywa96XdN")

connFd = false
recvBuffer = ""

local function conn_read_loop()
	while connFd do
		local data = socket.read(connFd)
		if not data then
			break
		end

		recvBuffer = recvBuffer .. data
	end
end

function Connect(host, port)
	connFd = socket.open(host, port)
	skynet.fork(conn_read_loop)
end

function Disconnect()
	socket.close(connFd)
end

function Send(msg)
	local packet = c_rc4:pack(msg)
	socket.write(connFd, packet)
end

local _sessionId = 0
local function genSessionId()
	_sessionId = (_sessionId + 1) % 65536
	return _sessionId
end

function SendMsg(protoName, args, callback)
	if socket.invalid(connFd) then
		connFd = nil
		return
	end

	local sessionId
	if callback then
		sessionId = genSessionId()
		sproto_helper.reg_sessionhandler(sessionId, callback)
	end
	local packedMsg = sproto_helper.pack_msg(protoName, args, sessionId)
	local packet = c_rc4:pack(packedMsg)
	socket.write(connFd, packet)
end

local PROTO_LEN_SZ = 2

function Tick()
	if not connFd then
		return
	end

	local handled = 0
	local totalLen = #recvBuffer
	if totalLen == 0 then
		return
	end

	while handled + PROTO_LEN_SZ < totalLen do
		local msg, err = lrc4.xor_unpack(recvBuffer, 100, handled)
		if not msg then
			skynet.error("unpack msg err:" .. err)
			break
		end
		sproto_helper.dispatch_and_handle(nil, msg)
		handled = handled + PROTO_LEN_SZ + #msg;
	end

	if handled == 0 then
		return
	end

	recvBuffer = string.sub(recvBuffer, handled + 1)
end

