--[[
ModuleName :
Path : main.lua
Author : jinlei
CreateTime : 2019-05-22 16:30:43
Description :
--]]
local skynet = require "skynet"
local socket = require "skynet.socket"
dofile("common/base/preload.lua")

local robotIdx = 0
local robotList = {}
local function addRobot(num)
	for i = 1, num do
		robotIdx = robotIdx + 1
		local openId = "robot_" .. tostring(robotIdx)
		local robotAddr = skynet.newservice("robot", openId)
		local robot = {OpenId = openId, Addr = robotAddr}
		table.insert(robotList, robot)
	end
end

local selectRobotList = {}
local function selectRobot(idx1, idx2)
	selectRobotList = {}
	idx1 = idx1 < 1 and 1 or idx1
	idx2 = idx2 > #robotList and #robotList or idx2
	for idx = idx1, idx2 do
		local robot = robotList[idx]
		table.insert(selectRobotList, robot)
	end
end

local CMD = {}
function CMD.add(args, cmdline)
	local num = args[1] and tonumber(args[1]) or 1
	addRobot(num)
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
        add        :eg      add              : add a robot
                    eg      add 10           : add 10 robots
        sel        :eg      sel              : select all robot
                    eg      sel 1 100        : select robot nameidx in range [1, 100]"
        c          :eg      c
        login      :eg      login            : login
        info       :eg      info             : info
        send       :eg      send xxx        : send
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

