local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register
local skynet_helper = require "common.utils.skynet_helper"
local logger = require "common.utils.logger"
dofile("script/lualib/common/base/preload.lua")

MAIN = GImport("lualib/main/main.lua")
--TEST = GImport("lualib/test/main.lua")

skynet.start(function()
	xpcall(MAIN.Main, function(err)
		local err = debug.traceback(err)
		print(err)
		os.exit()
	end)

	skynet_helper.dispatch_lua_by_module(MAIN)
	skynet.register ".main"
end)
