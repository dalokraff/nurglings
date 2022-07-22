--this file is creating the nested tables used for ai inventories 

local bloodletter_head_1 = {
    unit_extension_template = "ai_outfit_unit",
	unit_name = "units/bloodletter/dae_bloodletter_head_01FBX__humanoid06f",
	attachment_node_linking = AttachmentNodeLinking.bloodletter,
    drop_reasons = {
        death = false,
    },
}
local bloodletter_heads = {
    bloodletter_head_1,
    count = 1,
    name = 'bloodletter_heads',
}

local bloodletter_sword_1 = {
    unit_extension_template = "ai_outfit_unit",
	unit_name = "units/bloodletter/dae_bloodletter_sword_2h_01FBX__BIND_POSE",
	attachment_node_linking = AttachmentNodeLinking.bloodletter_sword,
    drop_reasons = {
        death = true,
    },
}
local bloodletter_swords = {
    bloodletter_sword_1,
    count = 1,
    name = 'bloodletter_swords',
    
}

InventoryConfigurations['daemon_bloodletter'] = {
    enemy_hit_sound = "sword",
	anim_state_event = "idle",
	items = {
		bloodletter_heads,
        bloodletter_swords,
	},
    items_n = 2
}

assert(AIInventoryTemplates['daemon_bloodletter'] == nil, "Can't override configuration based templates")

AIInventoryTemplates['daemon_bloodletter'] = function ()
	return 'daemon_bloodletter'
end

local multiple_configurations = InventoryConfigurations['daemon_bloodletter'].multiple_configurations

if multiple_configurations then
	InventoryConfigurations['daemon_bloodletter'].config_lookup = {}

	for i = 1, #multiple_configurations, 1 do
		local config_name = multiple_configurations[i]
		InventoryConfigurations['daemon_bloodletter'].config_lookup[config_name] = i
	end
end

--have to add the new inventory to a network lookup table of course
local num_AIinv = #NetworkLookup.ai_inventory
NetworkLookup.ai_inventory[num_AIinv+1] = 'daemon_bloodletter'

NetworkLookup.ai_inventory['daemon_bloodletter'] = num_AIinv+1