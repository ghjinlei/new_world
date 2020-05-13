--[[
ModuleName :
Path : base.lua
Author : jinlei
CreateTime : 2020-04-21 11:40:11
Description :
--]]

clsSceneEntity = clsObject:Inherit()

function clsSceneEntity:onInit(OCI)

end

function clsSceneEntity:onRelease()

end

function clsSceneEntity:AfterEnterScene()

end

function clsSceneEntity:Update()

end

function clsSceneEntity:SetThinkTimer(interval)
	if self._thinkTimer then
		self:RemoveTimer(self._thinkTimer)
		self._thinkTimer = nil
	end

	if interval >= 0 then
		self._startTime = TIME.GetTimeNow10MS()
		self._thinkTimer = self:CallFre(interval, function()
			local curTime = TIME.GetTimeNow10MS()
			local deltaTime = curTime - self._startTime
			self:Update(deltaTime)
			self._startTime = curTime
		end)
	end
end

function clsSceneEntity:onReachPoint(moveData)
	local curPos = self:GetPosition()
	local dstPos = moveData.path[#moveData.path]
	local displacement = POINT.Sub(dstPos, curPos)
	local rotation = MATH.GenRotationFromVector(displacement, self:GetRotation())
	local direct, distance = VECTOR.Normalize(displacement)
	local speed = self:GetSpeed()
	moveData.totalTime = distance / speed
end

-- 无视阻挡直线移动过去
function clsSceneEntity:DirectMoveTo(dstPosition, acceptableRadius, bGround)
	local dstPos = {dstPosition[1], dstPosition[2], dstPosition[3]}
	if bGround then
		local protoId = self:GetScene():GetProtoId()
		dstPos[2] = PHYSICS.GetGroundHeight(protoId, dstPos[1], dstPos[2], dstPos[3])
	end
	acceptableRadius = acceptableRadius or 0.1
	local startPos = self:GetPosition()
	if POINT.GetDistanceSquareXZ(startPos, dstPos) <= acceptableRadius * acceptableRadius then
		self:DispatchEvent(AI_CONFIG.EVENT_REACH_POSITION)
		return true
	end

	local moveData = {
		path = {dstPos, startPos},
		radius = acceptableRadius,
		elapsedTime = 0,
	}
	self:SetMoveData(moveData)
	self:SetMovementMode(mMOVEMENT_MODE_SRV_NAVWALKING)

	self:onReachPoint(moveData)
	return true
end
