--[[
ModuleName :
Path : main.lua
Author : jinlei
CreateTime : 2019-05-22 16:30:43
Description :
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"
dofile("script/lualib/common/base/preload.lua")

local robotMap = {}
local function addRobot(robotIdx1, robotIdx2)
	robotIdx2 = robotIdx2 or robotIdx1
	for robotIdx = robotIdx1, robotIdx2 do
		local openId = "robot_" .. tostring(robotIdx)
		local robotAddr = skynet.newservice("robot", openId)
		local robot = {OpenId = openId, Addr = robotAddr}
		robotMap[robotIdx] = robot
	end
end

local selectRobotList = {}
local function selectRobot(robotIdx1, robotIdx2)
	selectRobotList = {}
	robotIdx1 = robotIdx1 < 1 and 1 or robotIdx1
	robotIdx2 = robotIdx2 or robotIdx1
	for robotIdx = robotIdx1, robotIdx2 do
		local robot = robotMap[robotIdx]
		if robot then
			table.insert(selectRobotList, robot)
		end
	end
end

local CMD = {}
function CMD.add(args, cmdline)
	local robotIdx1 = tonumber(args[1])
	local robotIdx2 = tonumber(args[2])
	addRobot(robotIdx1, robotIdx2)
end

function CMD.sel(args, cmdline)
	local robotIdx1 = tonumber(args[1])
	local robotIdx2 = tonumber(args[2])
	selectRobot(robotIdx1, robotIdx2)
end

function CMD.connect(args, cmdline)
	for _, robot in ipairs(selectRobotList) do
		local addr = robot.Addr
		skynet.send(addr, "lua", "Connect")
	end
end

function CMD.login(args, cmdline)
	for _, robot in ipairs(selectRobotList) do
		local openId = robot.OpenId
		local addr = robot.Addr
		skynet.send(addr, "lua", "Login", openId)
	end
end

function CMD.info(args, cmdline)

end

function CMD.send(args, cmdline)
	local msg = args[1]
	for _, robot in ipairs(selectRobotList) do
		local addr = robot.Addr
		skynet.send(addr, "lua", "Send", msg)
	end
end

function CMD.disconnect(args, cmdline)
	for _, robot in ipairs(selectRobotList) do
		local addr = robot.Addr
		skynet.send(addr, "lua", "Disconnect")
	end
end

function CMD.help()
	skynet.error([[
usage(avaliable commands):
        add        :eg      add 10           : add a robot idx = 10
                    eg      add 10, 100      : add robots idx from 10 to 100
        sel        :eg      sel 10           : select a robot idx = 10
                    eg      sel 10 100       : select robot idx in range [1, 100]"
        connect    :eg      connect          : connect all select robots
        login      :eg      login            : login
        info       :eg      info             : info
        send       :eg      send xxx         : send
        disconnect :eg      disconnect       : disconnect all select robots
]])
end

function mainLoop()
	local stdin = socket.stdin()
	--socket.lock(stdin)
	while true do
		local cmdline = socket.readline(stdin, "\n")
		local args = string.split(cmdline, " ")
		cmd = table.remove(args, 1)
		local func = CMD[cmd]
		if func then
			func(args, cmdline)
		end
	end
	--socket.unlock(stdin)
end

skynet.start(function()
	print("robot/main.lua start ...")
	skynet.fork(mainLoop)
	print("robot/main.lua finish")
end)

