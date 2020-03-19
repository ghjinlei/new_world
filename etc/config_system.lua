--[[
ModuleName :
Path : config_system.lua
Author : jinlei
CreateTime : 2018-11-11 01:38:05
Description :
--]]

local config = {}

config.server = {}
config.server.host_id = 1001
config.server.host_name = "1001"
config.server.debug_console_port = 9001

config.gate = {}
config.gate.listen_addr = "0.0.0.0:6001"

config.dbserver = {}
config.dbserver.db_name = tostring(config.server.host_id)

config.auth = {}
config.auth.auth_count = 1

config.agentmgr = {}
config.agentmgr.max_agent_count = 100
config.agentmgr.agent_per_database = 10
config.agentmgr.max_enter_per_batch = 10

config.log = {}
config.log.level = 1
config.log.level_for_console = 1
config.log.dir = "./log"
config.log.cache_count = 1
config.log.time_format = "%Y%m%d %H:%M:%S"

return config

