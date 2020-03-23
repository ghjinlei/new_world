--[[
ModuleName :
Path : gsock.lua
Author : jinlei
CreateTime : 2019-05-24 14:31:23
Description :
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"
local sproto_helper = require "common.sproto_helper"

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
	local packedMsg = sproto_helper.PackMsg(protoName, args, sessionId)
	package = string.pack(">s2", packedMsg)
	socket.write(conn, package)
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
		local msg = convStr2Num()
		handled = handled + PROTO_LEN_SZ + #msg
		if msg ~= "" then
			sproto_helper.
		end
	end
end

