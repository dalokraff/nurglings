local mod = get_mod("nurglings")

local pacakge_tisch = {}
pacakge_tisch["units/nurgling_swarm/dae_nurgling_swarm_01FBX__nurglingswarm01"] = "units/nurgling_swarm/dae_nurgling_swarm_01FBX__nurglingswarm01"
pacakge_tisch["units/bloodletter/dae_bloodletter_body"] = "units/bloodletter/dae_bloodletter_body"
pacakge_tisch["units/bloodletter/dae_bloodletter_head_01FBX__humanoid06f"] = "units/bloodletter/dae_bloodletter_head_01FBX__humanoid06f"
pacakge_tisch["units/bloodletter/dae_bloodletter_sword_2h_01FBX__BIND_POSE"] = "units/bloodletter/dae_bloodletter_sword_2h_01FBX__BIND_POSE"
pacakge_tisch["resource_packages/breeds/daemon_bloodletter"] = "resource_packages/breeds/daemon_bloodletter"

mod:hook(PackageManager, "load",
         function(func, self, package_name, reference_name, callback,
                  asynchronous, prioritize)
    if package_name ~= pacakge_tisch[package_name] and package_name ~= pacakge_tisch[package_name.."_3p"] then
        func(self, package_name, reference_name, callback, asynchronous,
             prioritize)
    end
	
end)

mod:hook(PackageManager, "unload",
         function(func, self, package_name, reference_name)
    if package_name ~= pacakge_tisch[package_name] and package_name ~= pacakge_tisch[package_name.."_3p"] then
        func(self, package_name, reference_name)
    end
	
end)

mod:hook(PackageManager, "has_loaded",
         function(func, self, package, reference_name)
    if package == pacakge_tisch[package] or package == pacakge_tisch[package.."_3p"] then
        return true
    end
	
    return func(self, package, reference_name)
end)


-- this hook is mostly used to prevent crashing from missing animation events
-- if the event is not found and an attack or move event it should use "test_tack" and "move_fwd"
--otherwise it defaults to "idle"
mod:hook(Unit, "animation_event", function(func, self, event)
    local unit_name = Unit.get_data(self, "unit_name")
    -- if unit_name =="units/bloodletter/dae_bloodletter_body" then
    --     mod:echo(event)
    -- end
    
    if not Unit.has_animation_event(self,event) then
       
        local new_event = string.gsub(event,"_%d","")

        if string.find(new_event, "att") then
            new_event = "test_tack"
        end

        if string.find(new_event, "move") then
            new_event = "move_fwd"
        end

        mod:echo(tostring(event).."  :  "..tostring(new_event))
        if not Unit.has_animation_event(self,new_event) then
            event = "idle"
        else
            event = new_event 
        end

    end
    return func(self, event)
end)


-- mod:hook(Unit, 'node', function(func, self, node)
--     if Unit.get_data(self, "unit_name") == "units/bloodletter/dae_bloodletter_body" then
--         mod:echo('node')
--         mod:echo(node)
--     end
--     -- if Unit.has_node(self, node) then
--     --     return func(self, node)
--     -- end
--     -- local new_node = Unit.get_data(self, 'node_replace')
--     return func(self, node)
-- end)

-- mod:hook(Unit, 'actor', function(func, self, node)
--     if Unit.get_data(self, "unit_name") == "units/bloodletter/dae_bloodletter_body" then
--         mod:echo('actor')
--         mod:echo(node)
--     end
--     return func(self, node)
-- end)



-- mod:hook(Unit, "animation_event", function(func, self, event)
--     local unit_name = Unit.get_data(self, "unit_name")
--     if unit_name =="units/bloodletter/dae_bloodletter_body" then
--         mod:echo(event)
--     end
--     return func(self, event)
-- end)

-- mod:hook(AIInventoryExtension,'_setup_configuration', function (func, self, unit, start_n, inventory_configuration, item_extension_init_data)
--     local items = inventory_configuration.items
-- 	local items_n = inventory_configuration.items_n
-- 	local inventory_item_units = self.inventory_item_units
-- 	local inventory_item_units_by_category = self.inventory_item_units_by_category
-- 	local inventory_item_definitions = self.inventory_item_definitions
-- 	local unit_spawner = Managers.state.unit_spawner
-- 	local index = start_n

--     mod:echo(inventory_configuration.items[1])
--     for k,v in pairs (inventory_configuration.items[1]) do 
--         mod:echo(tostring(k).."     "..tostring(v))
--     end
-- 	for i = 1, items_n, 1 do
-- 		index = index + 1
-- 		local item_category = items[i]
-- 		local item_category_n = item_category.count
-- 		local item_category_name = item_category.name
        
--     end
--     return func(self, unit, start_n, inventory_configuration, item_extension_init_data)
-- end)

-- mod:hook(BTClanRatFollowAction, 'enter', function (func, self, unit, blackboard, t)
--     local navigation_extension = blackboard.navigation_extension
-- 	local destination = navigation_extension:destination()

--     mod:echo(destination)
    
--     return func(self, unit, blackboard, t)
-- end)

-- mod:hook(BTConditions, 'confirmed_player_sighting', function (func, blackboard)
--     -- mod:echo(Unit.get_data(blackboard.target_unit,"unit_name"))
    
--     return func(blackboard)
-- end)

-- local function swap(t, i, j)
-- 	local temp = t[i]
-- 	t[i] = t[j]
-- 	t[j] = temp
-- end

-- local function randomize_actions(unit, actions, blackboard, t, node_children)
-- 	local num_actions = #actions
-- 	local total_utility_score = 0

-- 	for i = 1, num_actions, 1 do
-- 		local action = actions[i]
-- 		local action_name = action.name
-- 		local node = node_children[action_name]
-- 		local score = 0

-- 		if node:condition(blackboard) then
-- 			score = Utility.get_action_utility(action, action_name, blackboard, t)
-- 		end

-- 		actions[i].utility_score = score
-- 		total_utility_score = total_utility_score + score
--         mod:echo(score)
-- 	end

-- 	for i = 1, num_actions, 1 do
--         local picked_index = nil
-- 		local random_utility_score = math.random() * total_utility_score

-- 		for j = i, num_actions, 1 do
-- 			local action_utility_score = actions[j].utility_score

-- 			if random_utility_score < action_utility_score then
-- 				picked_index = j

-- 				break
-- 			end

-- 			random_utility_score = random_utility_score - action_utility_score
-- 		end
        
-- 		if not picked_index then
-- 			num_actions = i - 1

-- 			return num_actions
-- 		end

-- 		total_utility_score = total_utility_score - actions[picked_index].utility_score

-- 		if picked_index ~= i then
-- 			swap(actions, picked_index, i)
-- 		end
-- 	end

-- 	return num_actions
-- end
-- mod:hook(BTUtilityNode, 'run', function (func, self, unit, blackboard, t, dt)
--     -- local actions = self._action_list
--     -- mod:echo('actions   '..tostring(#actions))
--     -- mod:echo(actions)
--     -- local num_actions = randomize_actions(unit, actions, blackboard, t, self._children)
--     -- mod:echo('num_actions   '..tostring(num_actions))
--     -- for name, child in pairs(self._children) do
--     --     -- for k,v in pairs(child._tree_node) do 
--     --     --     mod:echo(k)
--     --     --     mod:echo(v)
--     --     -- end
-- 	-- 	self._action_list = self._action_list or {}
-- 	-- 	self._action_list[#self._action_list + 1] = child._tree_node.action_data
-- 	-- end
 


--     return func(self, unit, blackboard, t, dt)
-- end)

-- mod:hook(Utility,'get_action_utility', function (func, breed_action, action_name, blackboard, from_draw_ai_behavior)
--     local considerations = breed_action.considerations
--     for name, consideration in pairs(considerations) do
--         mod:echo(tostring(name).."      "..tostring(consideration))
--     end
--     return func(breed_action, action_name, blackboard, from_draw_ai_behavior)
-- end)


-- mod:hook(AISlotSystem2,'ai_unit_have_slot',function (func, self, ai_unit)
--     mod:echo('lll')
--     return func(self, ai_unit)
-- end)

