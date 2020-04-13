--[[
ModuleName :
Path : ../lualib/agent/main.lua
Author : jinlei
CreateTime : 2020-03-27 16:33:17
Description :
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"
local logger = require "common.logger"
local config_system = require "config_system"
local config_agent = config_system.agent or {}

gate, agentmgr, database = false, false, false

local theAgent = false          --当前clsAgent对象

local clsAgent = clsObject:Inherit()
function clsAgent:onInit(fd, clientData)
	self.handler = nil

	self.fd = fd
	self.key = clientData.key
	self.userInfo = clientData.userInfo
	self.userId = nil
	self.saveData = nil
	self.saveDataDirty = nil
	self.lastBeatTime = skynet.time()
end

function clsAgent:SendBinMsg(msg)
	if self.fd then
		local packet, err = lrc4.xor_pack(msg, 100)
		if packet then
			socket.write(self.fd, packet)
		else
			logger.errorf("send_bin_msg error:%s", tostring(err))
		end
	end
end

function clsAgent:SendMsg(protoName, args)
	self:SendBinMsg(sproto_helper.pack_msg(protoName, args))
end

function clsAgent:startCheckHeartBeat()
	self:stopCheckHeartBeat()
	local waitHeartBeatTime = config_agent.wait_heart_beat_time
	if waitHeartBeatTime <= 0 then
		return
	end

	self.heartBeatTimer = self:CallFre(waitHeartBeatTime, function()
		if skynet.time() - self.lastBeatTime > waitHeartBeatTime then
			self:stopCheckHeartBeat()
			self:handleFailed("heartBeatTimer timeout")
		end
	end)
end

function clsAgent:stopCheckHeartBeat()
	if self.heartBeatTimer then
		self:RemoveTimer(self.heartBeatTimer)
		self.heartBeatTimer = nil
	end
end

function clsAgent:closeFd(reason)
	if self.fd then
		skynet.send(gate, "lua", "kick", skynet.self(), self.fd)
		self.fd = nil
	end
end

function clsAgent:handleFailed(msg)
	skynet.send(agentmgr, "lua", "OnAgentDisconnect", self.key, skynet.self(), self.fd, false)
	self:closeFd(msg)
	self:Release()
end

function clsAgent:OnDisconnect()

end

function clsAgent:onRelease()
	if theAgent then
		theAgent = nil
	end
end


local SOCKET = {}
local function handleDisconnect(fd)
	if not theAgent then
		return false
	end
	if theAgent.fd ~= fd then
		return false
	end
	return true
end

function SOCKET.close(fd)
	logger.debugf("SOCKET.close:fd=%d", fd)
	handleDisconnect(fd)
end

function SOCKET.error(fd, msg)
	logger.debugf("SOCKET.error:fd=%d,msg=%s", fd, msg)
	handleDisconnect(fd)
end

function SOCKET.warning(fd, sz)
	logger.debugf("SOCKET.warning:fd=%d,sz=%s", fd, sz)
end

local CMD = {}
function CMD.socket(cmd, ...)
	return SOCKET[cmd](...)
end

function CMD.start(fd, clientData, newClient)
	skynet.call(gate, "forward_agent", skynet.self(), fd)
	if newClient then
		-- 新登录玩家
		theAgent = clsAgent:New(fd, clientData)
		if not agent_state.LoadingAccount.CheckEnter(theAgent) then
			return
		end
		if not agent_state.LoadingAccount.Enter(theAgent) then
			return
		end

		-- 在加载数据过程中,客户端断开连接
		if not theAgent or theAgent.fd ~= fd then
			return
		end

		if not agent_state.ChoosingUser.CheckEnter(theAgent) then
			return
		end
		agent_state.ChoosingUser.Enter(theAgent)
	else
		if not theAgent then
			theAgent = clsAgent:New(fd, clientData)
			theAgent:handleFailed("no theAgent")
			return
		end

		if not theAgent.handler then
			theAgent:handleFailed("no theAgent.handler")
			return
		end

		if theAgent.key ~= clientData.key then
			theAgent:handleFailed("theAgent.key not match")
			return
		end

		if theAgent.fd then -- 踢掉原来的客户端
			local reason = "账号重复登录,您已下线"
			theAgent:SendMsg("OnKicked", {reason = reason})
			theAgent:closeFd(reason)
		end

		theAgent.fd = fd
		theAgent.userInfo = clientData.userInfo

		if not theAgent.handler.OnSwitchFd(theAgent) then
			theAgent.handleFailed("theAgent.handler.OnSwitchFd failed")
			return
		end
	end

	logger.debugf("agent.CMD.start success,fd=%d,key=%s", fd, tostring(clientData.key))
end

function GetCmdHandler(cmd)
	return CMD[cmd]
end

skynet.register_protocol {
	name = "client",
	id = skynet.PTYPE_CLIENT,
	unpack = function(msg, sz)
		return sproto_helper.dispatch(msg, sz)
	end,
	dispatch = function(fd, _, ok, type_, ...)
		assert(type_ == "REQUEST" and ok and theAgent and fd == theAgent.fd)	-- You can use fd to reply message
		skynet.ignoreret()	-- session is fd, don't call skynet.ret
		skynet.trace()

		local ok, result = sproto_helper.handle_request(theAgent, ...)
		if not ok then
			return
		end
		if theAgent then
			theAgent:SendBinMsg(result)
		end
	end
}

function SystemStartup(module)
	-- TODO:
end
