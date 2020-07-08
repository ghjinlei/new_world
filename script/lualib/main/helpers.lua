local skynet = require "skynet"

local servicename_pre = "snlua "
local servicename_start = #servicename_pre + 1
local function get_servicename(fullname)
	local pos = string.find(fullname, " ", servicename_start)
	if not pos then
		return string.sub(fullname, servicename_start)
	end
	return string.sub(fullname, servicename_start, pos - 1)
end

local nohotfix_servicenames = {
	["debug_console"] = true
}
function hotfix()
	logger.info("[HOTFIX] begin<<<<<<<<<<<<<<<<<<<<<<<<<<")

	--清理缓存;
	local codecache = require "skynet.codecache"
	codecache.clear()

	local services = skynet.call(".launcher", "lua", "LIST")
	for addr, fullname in pairs(services) do
		local name = get_servicename(fullname)
		if not nohotfix_servicenames[name] then
			logger.infof("[HOTFIX] sending hotfix command to [%s][%s]",tostring(addr), tostring(fullname) )
			skynet.send(addr, "hotfix")
		end
	end
	logger.info("[HOTFIX] >>>>>>>>>>>>>>>>>>>>>>>>>>>>>>end")
end
