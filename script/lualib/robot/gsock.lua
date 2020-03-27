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

local c_rc4 = lrc4.new("pZ109jj2R9DmszDy")

local conn
function Connect(host, port)
	conn = socket.open(host, port)
end

function Disconnect()
	socket.close(conn)
end

function Send(msg)
	skynet.error("send_1:" .. msg)
	data = string.pack(">s2", msg)
	socket.write(conn, data)
	skynet.error("send_2:" .. msg)
end

local _sessionId = 0
local function genSessionId()
	_sessionId = (_sessionId + 1) % 65536
	return _sessionId
end

local _sessionCbMap = {}

function SendMsg(protoName, args, callback)
	if socket.invalid(conn) then
		conn = nil
		return
	end

	local sessionId
	if callback then
		sessionId = genSessionId()
		_sessionCbMap[sessionId] = callback
	end
	local packedMsg = sproto_helper.pack_msg(protoName, args, sessionId)
	local packet = c_rc4:pack_with_len(packedMsg)
	socket.write(conn, packet)
end

local function responseCb(sessionId, args)
	local cb = _sessionCbMap[sessionId]
	if cb then
		xpcall(cb, __G_TRACE_BACK__, args)
	else
		skynet.errorf("responseCb_faild,msg=callback missing")
	end
end

local PROTO_LEN_SZ = 2
local _recvBuffer = ""

function Tick()
	if not conn then
		return
	end

	local handled = 0
	local totalLen = #_recvBuffer
	if totalLen == 0 then
		return
	end

	while handled + PROTO_LEN_SZ < totalLen do
		local msg, err, newHanled = c_rc4:unpack_with_len(_recvBuffer, nil, handled)
		if not msg then
			break
		end
		handled = newHanled
	end

	if handled == 0 then
		return
	end

	_recvBuffer = string.sub(_recvBuffer, handled + 1)
end

