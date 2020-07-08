local skynet = require "skynet"
local fs = require "common.utils.fs"
local logger = require "common.utils.logger"
local config_hotfix = require("config_system").hotfix

local function get_servicename()
	local str = skynet.call(".launcher", "lua", "NAME")
	str = string.strip(str)
	return string.split(str, " ")[2]
end

local version = false                 -- 启服版本号
local patched_sub_version = false     -- 当前patch号

local function try_reimport_by_patch()
	local version_nums = string.split(version, ".")
	local parent_version = table.concat(version_nums, ".", 1, 3)   -- 大版本号 eg. 1.0.0

	while true do
		local next_sub_version = patched_sub_version + 1
		local patch_dir = string.format("hotfix/%s/%d", parent_version, next_sub_version)
		if not fs.isdir(patch_dir) then
			break
		end

		local filelist_path = string.format("%s/filelist.txt", patch_dir)
		if fs.isfile(filelist_path) then
			local filelist_txt = fs.readfile(filelist_path)
			local filepath_list = string.split(filelist_txt, "\n")
			for _, relapath in iparis(filepath_list) do
				local filepath = string.format("%s/%s", __LUA_SERACH_PATH__, relapath)
				if __import_module_map__[relapath] then
					if fs.isfile(filepath) then
						local lua_str = fs.readfile(filepath)
						reimport(filepath, lua_str)
						logger.infof("hotfix: load module patch,path=%s", relapath)
					end
				end
			end
			log("hotfix: load module patch finish,version=%s,patch_version=%d", parent_version, next_sub_version)
		end

		local servicename = get_servicename()
		local manual_file_path = string.format("%s/manual/%s_patch.lua", patch_dir, servicename)
		if fs.isfile(manual_file_path) then
			xpcall(function()
				local manual_txt = fs.readfile(manual_file_path)
				local func = loadfile(manual_txt, "bt", _G)
				func()
				log("hotfix: load manual patch finish,version=%s,patch_version=%d,servicename=%s", parent_version, next_sub_version, servicename)
			end, __G_TRACE_BACK__)
		end

		patched_sub_version = next_sub_version
	end
end

local function get_file_modify_time(relapath)
	return fs.get_file_modify_time(string.format("%s/%s", __LUA_SERACH_PATH__, relapath))
end

function try_reimport_all_modules()
	for relapath, module in pairs(__import_module_map__) do
		xpcall(function()
			if get_file_modify_time(relapath) > module.__import_time__ then
				reimport(relapath)
				logger.infof("hotfix: update success,file=%s", relapath)
			end
		end, __G_TRACE_BACK__)
	end
end

local hotfix = {}

function init()
	version = string.strip(fs.readfile("etc/version.txt"))
	patched_sub_version = tostring(string.split(version, ".")[4])

	skynet.register_protocol {
		name = "hotfix",
		id = 100,
		unpack = skynet.unpack,
		pack = skynet.pack,
	}

	skynet.dispatch("hotfix", function()
		if config_hotfix.mode == "all" then
			try_reimport_all_modules()
		elseif config_hotfix.mode == "patch" then
			try_reimport_by_patch()
		end
	end)

	try_reimport_by_patch()
end

return hotfix
