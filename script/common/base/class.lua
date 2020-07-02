--[[
ModuleName :
Path : class.lua
Author : jinlei
CreateTime : 2019-06-21 16:11:43
Description :
--]]
-- 获取一个class的父类
function Super(cls)
	return cls.__SuperClass
end

function GetClass(obj)
	local mt = getmetatable(obj)
	if mt then
		return mt.__class
	end
end

local readOnlyMetaTable = {
	__newindex = function()
		assert(false, "readonly")
	end
}
local function setClassMetatable(cls)
	cls.__class_mt = {__index = cls, __class = cls}
	setmetatable(cls.__class_mt, readOnlyMetaTable)
end

local function inheritWithCopy(baseCls, cls)
	cls = cls or {}

	if not baseCls.__SubClass then
		baseCls.__SubClass = {}
		setmetatable(baseCls.__SubClass, {__mode = "v"})
	end
	table.insert(baseCls.__SubClass, cls)

	for k, v in pairs(baseCls) do
		if not cls[k] and type(v) == "function" then
			cls[k] = v
		end
	end

	cls.__SuperClass = baseCls

	local mt = getmetatable(cls) or {}
	mt.__call = function(...)
		return cls:New(...)
	end
	setmetatable(cls, mt)
	setClassMetatable(cls)

	return cls
end

clsObject = {
	__ClassName = "clsObject",

	Inherit = inheritWithCopy,
}
setClassMetatable(clsObject)

function clsObject:ToString()
	local oId = self:GetOId()
	local className = self:GetClassName()
	return string.format("objectid:%d,classname:%s", oId, className)
end

function clsObject:GetClassName()
	return self.__ClassName
end

function clsObject:attachToClass(obj)
	setmetatable(obj, self.__class_mt)
	return obj
end

__GObjectId__ = __GObjectId__ or 10000
local function genObjectId()
	__GObjectId__ = __GObjectId__ + 1
	return __GObjectId__
end

__GObjectMap__ = __GObjectMap__ or {}
setmetatable(__GObjectMap__, {__mode = "v"})

local function onInit()
end

function clsObject:New(...)
	local obj = {
		_objectId = genObjectId()
	}

	self:attachToClass(obj)
	__GObjectMap__[obj._objectId] = obj

	obj:__init__(...)

	return obj
end

function clsObject:onInit(...)
end

function clsObject:Release()
	if self.__released then
		return
	end

	if TIMER then
		TIMER.RemoveAllTimers(self)
	end
	if EVENT then
		EVENT.RemoveAllEvents(self)
	end

	self.__released = true
end

function clsObject:onRelease()
end

