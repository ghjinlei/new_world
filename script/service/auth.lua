--[[
ModuleName :
Path : auth.lua
Author : jinlei
CreateTime : 2018-11-11 01:33:27
Description :
--]]

local skynet = require "skynet"

local gate = false
local clientMap = { }

-- 客户端
local clsClient = { }
function clsClient.New(fd, address)
	local o = {
		fd = fd,
		address = address,
		userInfo = nil,
	}
	setmetatable(o, {__index = clsClient})
	return o
end

function clsClient:HandShake(args)

end

function clsClient:Auth(args)

end

function clsClient:Close()
	local fd = self.fd
	clientMap[fd] = nil
	skynet.send(gate, "lua", "close_fd", fd)
end

skynet.start(function()

end)

