
local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register
local config_system = require "config_system"
local lunix = require "lunix"
local fs = require "common.fs"
local utils = require "common.utils"
local logger = require "common.logger"
dofile("script/lualib/common/base/preload.lua")

local debug_console
local gate
local agentmgr
local scenemgr
local database
local authList = {}

function writeVariables()
	if not fs.IsDir("var") then
		fs.Mkdir("var")
	end
	fs.WriteFile("var/pid", lunix.getpid())
	local runningList = {}
	table.insert(runningList, "host_id " .. config_system.server.host_id)
	table.insert(runningList, "listen_addr " ..  config_system.gate.listen_addr)
	table.insert(runningList, "debug_console_port " .. config_system.server.debug_console_port)
	fs.WriteFile("var/running", table.concat(runningList, "\n"))
end

local function main()
	writeVariables()

	debug_console = skynet.uniqueservice("debug_console", config_system.server.debug_console_port)

	gate = skynet.newservice("gate", skynet.self())
--	agentmgr = skynet.newservice("agentmgr", skynet.self(), gate)
--	scenemgr = skynet.newservice("scenemgr", skynet.self())
--	database = skynet.newservice("database", skynet.self())
--
--	for i = 1, config_system.auth.auth_count do
--		local auth = skynet.newservice("auth", gate, agentmgr)
--		table.insert(authList, auth)
--	end
--	skynet.call(gate, "lua", "SetAuthList", authList)
--
--	skynet.call(agnetmgr, "lua", "init")
--	skynet.call(scenemgr, "lua", "init")
	skynet.call(gate, "lua", "open")
end

local function shutdown()
	skynet.call(gate, "lua", "close")

	logger.shutdown()

	skynet.timeout(100, function()
		os.exit()
	end)
end

local CMD = {}
function CMD.Shutdown()
	logger.info("start shutdown ......")
	shutdown()
end

skynet.start(function()
	print("init service start :main ......")
	xpcall(main, function(err)
		print(debug.traceback(err))
		os.exit(1)
	end)

	utils.DispatchLua(CMD)
	skynet.register "MAIN"
	print("init service finish :main")
end)
