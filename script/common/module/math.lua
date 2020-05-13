--[[
ModuleName :
Path : common/module/math.lua
Author : jinlei
CreateTime : 2020-04-21 15:10:44
Description :
--]]

function GenRotationFromXYZ(x, y, z, defaultRotation)
	if x == 0 and y == 0 and z == 0 then
		return defaultRotation
	end

	if z == 0 then
		return x > 0 and 90 or 270
	end

	local tan = x / z
	local radians = math.atan(tan)
	local angle = 180 * radians / math.pi
	if z < 0 then
		angle = angle + 180
	end
	if angle < 0 then
		angle = angle + 360
	end
	return angle
end

function GenRotationFromPoint(startPoint, dstPoint, defaultRotation)
	local x = pointEnd[1] - pointBegin[1]
	local y = pointEnd[2] - pointBegin[2]
	local z = pointEnd[3] - pointBegin[3]
	return GenRotationFromPoint(x, y, z, defaultRotation)
end

function GenRotationFromVector(vector, defaultRotation)
	return GenRotationFromPoint(vector[1], vector[2], vector[3], defaultRotation)
end
