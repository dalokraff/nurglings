local mod = get_mod("nurglings")
mod:dofile("scripts/mods/nurglings/hooks")
mod:dofile("scripts/mods/nurglings/attachment_nodes")
mod:dofile("scripts/mods/nurglings/bloodletter/daemon_bloodletter")
mod:dofile("scripts/settings/breeds")
mod:dofile("scripts/mods/nurglings/bloodletter/daemon_bloodletter_selector")
mod:dofile("scripts/mods/nurglings/bloodletter/daemon_bloodletter_behavior")
mod:dofile("scripts/mods/nurglings/bloodletter/daemon_bloodletter_inventory")

-- Your mod code goes here.
-- https://vmf-docs.verminti.de


local unit_path = "units/bloodletter/dae_bloodletter_body"
local unit_path2 = "resource_packages/breeds/daemon_bloodletter"
local num_inv = #NetworkLookup.inventory_packages
local num_husk = #NetworkLookup.husks


NetworkLookup.inventory_packages[num_inv+1] = unit_path
NetworkLookup.inventory_packages[unit_path] = num_inv+1

NetworkLookup.inventory_packages[num_inv+2] = unit_path2
NetworkLookup.inventory_packages[unit_path2] = num_inv+2

NetworkLookup.husks[num_husk+1] = unit_path
NetworkLookup.husks[unit_path] = num_husk+1

--this fucntion must run after the breed file and custom breed file to setup the network lookup breed table
local function create_lookups(lookup, hashtable)
	local i = #lookup

	for key, _ in pairs(hashtable) do
		i = i + 1
		lookup[i] = key
	end

	return lookup
end
NetworkLookup.breeds = create_lookups({}, Breeds)

--a name needs to be provided for the custom breed otherwise a crash iirc
Breeds.daemon_bloodletter.name = "critter_rat"


local function spawn_package_to_player (package_name)
	local player = Managers.player:local_player()
	local world = Managers.world:world("level_world")
  
	if world and player and player.player_unit then
	  local player_unit = player.player_unit
  
	  local position = Unit.local_position(player_unit, 0) + Vector3(0, 0, 0)
	  local rotation = Unit.local_rotation(player_unit, 0)
	  local unit = Managers.state.unit_spawner:spawn_local_unit(package_name, position, rotation)
  
	  mod:chat_broadcast(#NetworkLookup.inventory_packages + 1)
	  return unit
	end
  
	return nil
end

-- local unit = spawn_package_to_player("units/beings/enemies/skaven_clan_rat/chr_skaven_slave")
-- local var = Unit.animation_find_variable(unit, "stagger_scale")
-- mod:echo(var)

mod.units = {}
mod.last_spawned = {}

mod:command("spawn_nurglings", "", function()
    local unit = spawn_package_to_player("units/nurgling_swarm/dae_nurgling_swarm_01FBX__nurglingswarm01")
    mod.units[1] = unit
end)

mod:command("nurglings_run", "", function()
    Unit.animation_event(mod.units[1], "run_fwd")
end)
mod:command("nurglings_left", "", function()
    Unit.animation_event(mod.units[1], "turn_90_left")
end)
mod:command("nurglings_right", "", function()
    Unit.animation_event(mod.units[1], "turn_90_right")
end)


mod:command("remove_demons", "", function()
    local world = Managers.world:world("level_world")
    for k,v in pairs(mod.units) do 
        if Unit.alive(v) then
            World.destroy_unit(world, v)
        end
    end
end)

mod:command("spawn_bloodletter", "", function()
    local world = Managers.world:world("level_world")
    local unit_base = spawn_package_to_player("units/bloodletter/dae_bloodletter_body")
    local unit_head = spawn_package_to_player("units/bloodletter/dae_bloodletter_head_01FBX__humanoid06f")
    local unit_sword = spawn_package_to_player("units/bloodletter/dae_bloodletter_sword_2h_01FBX__BIND_POSE")
    mod.units[unit_base] = unit_base
    mod.units[unit_head] = unit_head
    mod.units[unit_sword] = unit_sword
    mod.last_spawned[1] = unit_base
    AttachmentUtils.link(world, unit_base, unit_head, AttachmentNodeLinking.bloodletter)
    AttachmentUtils.link(world, unit_base, unit_sword, AttachmentNodeLinking.bloodletter_sword)
    Unit.animation_event(unit_base, "idle")
    Unit.node(unit_base, "head_0")
    Unit.actor(unit_base, "c_head")
    mod:echo(Unit.mover(unit_base))
    mod:echo(Unit.animation_find_variable(unit_base, "move_speed"))

    MoverHelper.set_active_mover(unit_base, MoverHelper.create_mover_state(), "mover")

    local level_settings = LevelHelper:current_level_settings()
	local flow_event = level_settings.on_spawn_flow_event
    mod:echo(flow_event)
end)

mod:command("bloodletter_left", "", function()
    Unit.animation_event(mod.last_spawned[1], "stagger_light_left")
end)
mod:command("bloodletter_right", "", function()
    Unit.animation_event(mod.last_spawned[1], "stagger_light_right")
end)
mod:command("bloodletter_fwd", "", function()
    Unit.animation_event(mod.last_spawned[1], "stagger_light_fwd")
end)
mod:command("bloodletter_bwd", "", function()
    Unit.animation_event(mod.last_spawned[1], "stagger_light_bwd")
end)
mod:command("bloodletter_move_fwd", "", function()
    Unit.animation_event(mod.last_spawned[1], "move_fwd")
end)




--this enables the breed with creature spawner settings
local spawn_mod = get_mod("CreatureSpawner")

local add_spawn_catagory = {
    daemon_bloodletter = {
        "misc",
    }
}
table.merge(spawn_mod.unit_categories, table)
breed_name = 'daemon_bloodletter'
table.insert(spawn_mod["all_units"], breed_name)

--use this to actually enable the custom BTSelector for possible use
for bt_name, bt_node in pairs(BreedBehaviors) do
    bt_node[1] = "BTSelector_" .. bt_name
    bt_node.name = bt_name .. "_GENERATED"
end

