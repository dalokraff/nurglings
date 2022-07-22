--this file sets up a custom selector but is currently unused
local mod = get_mod("nurglings")
require("scripts/entity_system/systems/behaviour/nodes/bt_node")

local unit_alive = Unit.alive
local Profiler = Profiler

local function nop()
	return
end

BTSelector_daemon_bloodletter = class(BTSelector_daemon_bloodletter, BTNode)
BTSelector_daemon_bloodletter.name = "BTSelector_daemon_bloodletter"

BTSelector_daemon_bloodletter.init = function (self, ...)
	BTSelector_daemon_bloodletter.super.init(self, ...)

	self._children = {}
end

BTSelector_daemon_bloodletter.leave = function (self, unit, blackboard, t, reason)
	self:set_running_child(unit, blackboard, t, nil, reason)
end

BTSelector_daemon_bloodletter.run = function (self, unit, blackboard, t, dt)
	local child_running = self:current_running_child(blackboard)
	local children = self._children
	local node_spawn = children[1]
	local condition_result = blackboard.spawn

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_spawn, "aborted")

		local result, evaluate = node_spawn:run(unit, blackboard, t, dt)

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_spawn == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_in_vortex = children[2]
	local condition_result = blackboard.in_vortex

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_in_vortex, "aborted")

		local result, evaluate = node_in_vortex:run(unit, blackboard, t, dt)

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_in_vortex == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_under_door = children[3]
	local condition_result = BTConditions.at_smartobject(blackboard) and BTConditions.at_door_smartobject(blackboard)

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_under_door, "aborted")

		local result, evaluate = node_under_door:run(unit, blackboard, t, dt)

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_under_door == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_hesitate = children[4]
	local alerted = unit_alive(blackboard.target_unit) and blackboard.is_alerted and (not blackboard.confirmed_player_sighting or blackboard.hesitating)
	local is_taunted = unit_alive(blackboard.taunt_unit)
	local taunt_hesitate = is_taunted and not blackboard.taunt_hesitate_finished and not blackboard.no_taunt_hesitate
	local condition_result = alerted or taunt_hesitate

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_hesitate, "aborted")

		local result, evaluate = node_hesitate:run(unit, blackboard, t, dt)

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_hesitate == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	-- local node_flee_sequence = children[4]
	-- local condition_result = unit_alive(blackboard.target_unit) or blackboard.is_fleeing

	-- if condition_result then
	-- 	self:set_running_child(unit, blackboard, t, node_flee_sequence, "aborted")

	-- 	local result, evaluate = node_flee_sequence:run(unit, blackboard, t, dt)

	-- 	if result ~= "running" then
	-- 		self:set_running_child(unit, blackboard, t, nil, result)
	-- 	end

	-- 	if result ~= "failed" then
	-- 		return result, evaluate
	-- 	end
	-- elseif node_flee_sequence == child_running then
	-- 	self:set_running_child(unit, blackboard, t, nil, "failed")
	-- end

	local node_in_combat = children[5]
	local condition_result = unit_alive(blackboard.target_unit) --and blackboard.confirmed_player_sighting
	mod:echo(condition_result)
	if condition_result then
		mod:echo('in')
		self:set_running_child(unit, blackboard, t, node_in_combat, "aborted")
		mod:echo('otherside')
		local result, evaluate = node_in_combat:run(unit, blackboard, t, dt)
		mod:echo(tostring(result).."		"..tostring(evaluate))
		
		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_in_combat == child_running then
		mod:echo('fail')
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_stagger = children[6]
	local condition_result = nil

	if blackboard.stagger then
		condition_result = not blackboard.stagger_prohibited
	end

	if condition_result then
		self:set_running_child(unit, blackboard, t, node_stagger, "aborted")

		local result, evaluate = node_stagger:run(unit, blackboard, t, dt)

		if result ~= "running" then
			self:set_running_child(unit, blackboard, t, nil, result)
		end

		if result ~= "failed" then
			return result, evaluate
		end
	elseif node_stagger == child_running then
		self:set_running_child(unit, blackboard, t, nil, "failed")
	end

	local node_idle = children[7]

	self:set_running_child(unit, blackboard, t, node_idle, "aborted")

	local result, evaluate = node_idle:run(unit, blackboard, t, dt)

	if result ~= "running" then
		self:set_running_child(unit, blackboard, t, nil, result)
	end

	if result ~= "failed" then
		return result, evaluate
	end
end

BTSelector_daemon_bloodletter.add_child = function (self, node)
	self._children[#self._children + 1] = node
end

return
