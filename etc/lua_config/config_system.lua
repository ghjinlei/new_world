--[[
ModuleName :
Path : config_system.lua
Author : jinlei
CreateTime : 2018-11-11 01:38:05
Description :
--]]

local config = {}

config.server = {}
config.server.host_id = 101
config.server.host_name = "new world"
config.server.debug_console_port = 51019

config.gate = {}
config.gate.listen_addr = "0.0.0.0:51010"

config.dbserver = {}
config.dbserver.db_name = tostring(config.server.host_id)

config.auth = {}
config.auth.auth_count = 1

return config

