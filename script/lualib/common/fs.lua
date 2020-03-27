--[[
ModuleName :
Path : lualib/common/fs.lua
Author : jinlei
CreateTime : 2019-05-10 16:19:16
Description :
--]]

local lfs = require "lfs"

local fs = {}
function fs.get_file_modify_time(path)
	local result = lfs.attributes(path)
	return result and result.modification
end

function fs.get_file_size(path)
	local result = lfs.attributes(path)
	if not result or result.mode ~= "file" then
		return 0
	end
	return result.size
end

function fs.isfile(path)
	local result = lfs.attributes(path)
	if result and result.mode == "file" then
		return true
	end
	return false
end

function fs.isdir(path)
	local result = lfs.attributes(path)
	if result and result.mode == "directory" then
		return true
	end
	return false
end

function fs.dirname(path)
	if path == "." or path == "/" then
		return path
	end
	local dirname, cnt = string.gsub(path, "(.*)/(.*)$", "%1")
	if cnt == 1 then
		return dirname
	end
	return "."
end

function fs.mkdir(path, mode)
	local subpath_list = string.split(path, "/")
	path = nil
	for _, subpath in ipairs(subpath_list) do
		if subpath ~= "." and subpath ~= "" then
			path = path and string.format("%s/%s", path, subpath) or subpath
			if not fs.isdir(path) then
				lfs.mkdir(path, mode)
			end
		end
	end
end

function fs.readfile(path)
	local f = io.open(path, "r")
	assert(f, string.format("%s not exists", path))
	local str = f:read("*a")
	f:close()
	return str
end

function fs.writefile(path, data)
	local f = io.open(path, "w+")
	f:write(data)
	f:close()
end

return fs

