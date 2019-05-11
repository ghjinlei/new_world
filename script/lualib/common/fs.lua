--[[
ModuleName :
Path : lualib/common/fs.lua
Author : jinlei
CreateTime : 2019-05-10 16:19:16
Description :
--]]

local lfs = require "lfs"

function IsFileExist(path)
	local result = lfs.attributes(path)
	if result and result.mode == "file" then
		return true
	end
	return false
end

function GetFileModifyTime(path)
	local result = lfs.attributes(path)
	return result and result.modification
end

function GetFileSize(path)
	local result = lfs.attributes(path)
	if not result or result.mode ~= "file" then
		return 0
	end
	return result.size
end

function IsDir(path)
	local result = lfs.attributes(path)
	if result and result.mode == "directory" then
		return true
	end
	return false
end

function Dirname(path)
	if path == "." or path == "/" then
		return path 
	end
	local dirname, cnt = string.gsub(path, "(.*)/(.*)$", "%1")
	if cnt == 1 then
		return dirname
	end
	return "."
end

function Mkdir(path, mode)
	local subpathList = string.split(path, "/")
	path = nil
	for _, subpath in ipairs(subpathList) do
		if subpath ~= "." and subpath ~= "") then
			path = path and string.format("%s/%s", path, subpath) or subpath
			if not IsDir(path) then
				lfs.mkdir(path, mode)
			end
		end
	end
end



function ReadFile(path)
	local f = io.open(path, "r")
	assert(f, string.format("%s not exists", path))
	local str = f:read("*a")
	f:close()
	return str
end

