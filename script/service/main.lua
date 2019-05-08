local skynet = require "skynet"
require "skynet.manager"	-- import skynet.register
local config_system = require "config_system"
local utils = require "common.utils"

local gate
local agentmgr
local scenemgr
local database
local authList = {}

local function main()
	gate = skynet.newservice("gate", skynet.self())
	agentmgr = skynet.newservice("agentmgr", skynet.self(), gate)
	scenemgr = skynet.newservice("scenemgr", skynet.self())
	database = skynet.newservice("database", skynet.self())

	for i = 1, config_system.auth.auth_count do
		local auth = skynet.newservice("auth", gate, agentmgr)
		table.insert(authList, auth)
	end
	skynet.call(gate, "lua", "SetAuthList", authList)

	skynet.call(agnetmgr, "lua", "init")
	skynet.call(scenemgr, "lua", "init")
	skynet.call(gate, "lua", "open")
end

local function shutdown()
	-- TODO
end

local CMD = {}
function CMD.Shutdown()
	shutdown()
end

skynet.start(function()
	xpcall(main, function(err)
		print(debug.traceback(err))
		os.exit(1)
	end)

	utils.DispatchLua(CMD)
	skynet.register "MAIN"
end)
