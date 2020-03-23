local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register
local utils = require "common.utils"
local logger = require "common.logger"
dofile("common/base/preload.lua")

MAIN = GImport("lualib/main/main.lua")

skynet.start(function()
	xpcall(MAIN.Main, function(err)
		local err = debug.traceback(err)
		print(err)
		os.exit()
	end)

	utils.DispatchLuaByModule(MAIN)
	skynet.register ".main"
end)
