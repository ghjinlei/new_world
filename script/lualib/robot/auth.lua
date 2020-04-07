--[[
ModuleName :
Path : ../lualib/robot/auth.lua
Author : jinlei
CreateTime : 2020-03-23 16:28:18
Description :
--]]

local skynet = require "skynet"

local authData = {
	openId = nil,
	userId = nil,
}

function SetOpenId(openId)
	authData.openId = openId
end

function SetUserId(userId)
	authData.userId = userId
end

local function getLoginData()
	local data = {
		operator      = 0,
		channel       = 0,
		platform      = 0,
		openId        = authData.openId,
		appId         = "appId_robot",
		os            = "ios",
		imei          = "imei_robot",
		idfa          = "idfa_robot",
	}
	return data
end

function Login()
	local loginData = getLoginData()
	GSOCK.SendMsg("AUTH_HandShake", loginData, function(args)
		skynet.error("AUTH_HandShake callback!")
		GSOCK.SendMsg("AUTH_Auth", {}, function(args)
			skynet.error("AUTH_Auth callback!")
			if args.code == 0 then
				skynet.error("login success!")
			end
		end)
	end)
end

local msgHandlers = {}

function __init__(module, updated)
	local sproto_helper = require "common.sproto_helper"
	sproto_helper.reg_msghandlers(msgHandlers)
end

