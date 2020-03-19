--没有初始化logger,为了与robot公用;
local skynet = require "skynet"
local sprotoloader = require "sprotoloader"
local sprotoparser = require "sprotoparser"

local sproto_conf_c2s = require "sproto/proto_conf_c2s"
local sproto_conf_s2c = require "sproto/proto_conf_s2c"

skynet.start(function()
	sprotoloader.save(sprotoparser.parse( sproto_conf_c2s), 1)
	sprotoloader.save(sprotoparser.parse( sproto_conf_s2c ), 2)

	skynet.error("protoloader.lua finish")
	-- don't call skynet.exit() , because sproto.core may unload and the global slot become invalid
end)
