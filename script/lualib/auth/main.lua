--[[
ModuleName :
Path : lualib/auth/main.lua
Author : jinlei
CreateTime : 2020-03-21 00:10:00
Description :
--]]
local skynet = require "skynet"
local skynet_queue = require "skynet.queue"
local socket = require "skynet.socket"
local lrc4 = require "lrc4"
local logger = require "common.logger"
local config = require "config_system"
local sproto_helper = require "common.sproto_helper"

gate, agentmgr = false, false

local clientMap = { }

local function genSalt()
	local a = math.random(1 << 31)
	local b = math.random(1 << 31)
	return string.format("%08x%08x", a, b)
end

-- 客户端
local clsClient = { }
function clsClient.New(fd, address)
	local o = {
		fd = fd,
		address = address,
		accountId = nil,
		salt = genSalt(),
		userInfo = nil,
		mq = skynet_queue(),
		c_rc4 = lrc4.new("YGv93ebZywa96XdN"),
	}
	setmetatable(o, {__index = clsClient})
	return o
end

function clsClient:HandShake(args)
	logger.infof("hand_shake,operator=%s,channel=%s,platform=%s,openid=%s,appid=%s,os=%s,imei=%s,idfa=%s", 
		tostring(args.operator), tostring(args.channel), tostring(args.platform), tostring(args.openId), tostring(args.appId), tostring(os), tostring(imei), tostring(idfa))
	self.userInfo = args
	return {code = 0, salt = self.salt, patch = config.client_patch}
end

function clsClient:Auth(args)
	logger.infof("auth,data=%s", tostring(args.data))

	--TODO: 处理登录超时
	--TODO: 认证合法性
	--TODO: 检查是否封号

	-- 校验成功
	self.mq = nil
	self.c_rc4 = nil
	self.accountId = tostring(self.userInfo.openId)
	skynet.send(agentmgr, "lua", "HandClient", self)
	self.finish = true
	return {code = 0}
end

function clsClient:closeFd(reason)
	clientMap[self.fd] = nil
	skynet.send(gate, "lua", "close_fd", skynet.self(), self.fd, reason)
end

function clsClient:SendBinMsg(msg)
	if self.fd then
		local packet, err = lrc4.xor_pack(msg, 100)
		if packet then
			socket.write(self.fd, packet)
		else
			logger.errorf("send_bin_msg error:%s", tostring(err))
		end
	end
end

function clsClient:HandleClientMsg(msg)
	self.mq(function()
		if self.finish then --认证结束
			self:closeFd("dumplicated client login packet")
			return
		end

		local ok, result = sproto_helper.dispatch_and_handle(self, msg)
		if not ok then
			self:Release()
			logger.errorf("handle_client_msg error:%s", tostring(result))
			return
		end

		if result then
			self:SendBinMsg(result)
		end

		if self.finish then
			clientMap[self.fd] = nil
		end
	end)
end

local SOCKET = {}
function SOCKET.data(fd, msg)
	local client = clientMap[fd]
	if not client then
		logger.warningf("SOCKET.data:fd=%d,client is missing", fd)
		return
	end
	local rawMsg, err = client.c_rc4:unpack(msg)
	logger.debugf("SOCKET.data:fd=%d,raw_msg=%s,raw_msg_len=%d", fd, tostring(rawMsg), #rawMsg)
	client:HandleClientMsg(rawMsg)
end

function SOCKET.open(fd, address)
	logger.debugf("SOCKET.open:fd=%d,address=%s", fd, address)
	assert(not clientMap[fd])
	local client = clsClient.New(fd, address)
	clientMap[fd] = client
end

local function handleSocketClose(fd)
	local client = clientMap[fd]
	if not client then
		return
	end
	clientMap[fd] = nil
end

function SOCKET.close(fd)
	logger.debugf("SOCKET.close:fd=%d", fd)
	handleSocketClose(fd)
end

function SOCKET.error(fd, msg)
	logger.debugf("SOCKET.error:fd=%d,msg=%s", fd, msg)
	handleSocketClose(fd)
end

function SOCKET.warning(fd, sz)
	logger.debugf("SOCKET.warning:fd=%d,sz=%s", fd, sz)
end

local CMD = {}
function CMD.socket(cmd, ...)
	return SOCKET[cmd](...)
end

function GetCmdHandler(cmd)
	return CMD[cmd]
end

function SystemStartup(module)
	sproto_helper.reg_msghandler("AUTH_HandShake", clsClient.HandShake)
	sproto_helper.reg_msghandler("AUTH_Auth", clsClient.Auth)
end
