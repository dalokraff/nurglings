local stagger_types = require("scripts/utils/stagger_types")
local daemon_data = {
	wield_inventory_on_spawn = true, --took this from the Gor breed file, may be uneeded


	detection_radius = 10,
	walk_speed = 2.5,
	leave_walk_distance = 1,
	enter_walk_distance = 0.1,
	has_inventory = true,
	ai_toughness = 1,
	animation_sync_rpc = "rpc_sync_anim_state_7",
	scale_death_push = 1,
	is_always_spawnable = true,
	death_reaction = "ai_default",
	dialogue_source_name = "skaven_slave",
	attack_general_sound_event = "Play_slave_rat_attack_husk_vce",
	slot_template = "skaven_horde",
	aoe_height = 1.2,
	bone_lod_level = 1,
	has_running_attack = true,
	stagger_resistance = 1,
	patrol_detection_radius = 10,
	flingable = true,
	wwise_voice_switch_group = "clan_rat_vce",
	panic_close_detection_radius_sq = 9,
	radius = 1.75,
	use_backstab_vo = true,
	hit_mass_count = 1,
	patrol_active_perception = "perception_regular",
	perception_previous_attacker_stickyness_value = -12.5,
	race = "skaven",
	ai_strength = 1,
	poison_resistance = 70,
	armor_category = 1,
	backstab_player_sound_event = "Play_clan_rat_attack_player_back_vce",
	death_sound_event = "Play_slave_rat_die_vce",
	smart_targeting_width = 0.1,
	behavior = "slave_rat",--this selects which AI/Behaviour tree to use cmy custom one is daemon_bloodletter
	attack_player_sound_event = "Play_slave_rat_attack_player_vce",
	target_selection = "pick_closest_target_with_spillover",
	run_speed = 4.25,
	exchange_order = 5,
	stagger_threshold_light = 0,
	hit_reaction = "ai_default",
	patrol_passive_target_selection = "patrol_passive_target_selection",
	smart_targeting_outer_width = 0.5,
	unit_variation_setting_name = "skaven_slave",
	hit_effect_template = "HitEffectsSkavenSlave",
	smart_targeting_height_multiplier = 3,
	passive_walk_speed = 2,
	horde_behavior = "horde_rat",
	unit_template = "ai_unit_clan_rat",
	smart_object_template = "default_clan_rat",
	stagger_duration_mod = 1,
	perception = "perception_regular",
	player_locomotion_constrain_radius = 0.7,
	weapon_reach = 2,
	horde_target_selection = "horde_pick_closest_target_with_spillover",
	patrol_passive_perception = "perception_regular",
	vortexable = true,
	base_unit = "units/bloodletter/dae_bloodletter_body",--custom unit
	threat_value = 1,



	--some values used when i was just overwriting the critter_rat breed
	-- detection_radius = 10,
	-- target_selection = "pick_closest_target",
	-- run_speed = 4,--1.75
	-- exchange_order = 1,
	-- flingable = false,
	-- has_inventory = true, --true
	-- perception = "perception_regular",
	-- not_bot_target = true,
	-- animation_sync_rpc = "rpc_sync_anim_state_1",
	-- aoe_radius = 0.1,
	-- poison_resistance = 70,
	-- debug_spawn_category = "Misc",
	-- aoe_height = 0.1,
	-- cannot_far_path = true,
	-- walk_speed = 1,
	-- hit_reaction = "ai_default",
	-- bone_lod_level = 1,
	-- hit_effect_template = "HitEffectsCritterRat",
	-- radius = 1,
	-- unit_template = "ai_unit_clan_rat",--"ai_unit_critter",
	-- slot_template = "skaven_horde", --taken from slave rat
	
	-- perception_previous_attacker_stickyness_value = 0,
	-- race = "critter",
	-- no_autoaim = true,
	-- death_reaction = "ai_default",
	-- armor_category = 1,
	-- weapon_reach = 2,
	-- vortexable = false,
	-- disable_local_hit_reactions = true,
	-- behavior = "slave_rat",
	
	-- threat_value = 1,
	-- ignore_activate_unit = true,
	-- stagger_resistance = 1,
	-- stagger_threshold_light = 0,
	-- stagger_duration_mod = 1,


	diff_stagger_resist = BreedTweaks.diff_stagger_resist.slave_rat,
	stagger_duration = BreedTweaks.stagger_duration.slave_rat,
	stagger_duration_difficulty_mod = BreedTweaks.stagger_duration_difficulty_mod.default,
	hit_mass_counts = BreedTweaks.hit_mass_counts.slave_rat,
	stagger_duration_difficulty_mod = BreedTweaks.stagger_duration_difficulty_mod.default,
   
	--defines the custom inventory
	default_inventory_template = {
		"daemon_bloodletter",
	},

	size_variation_range = {
		1.2,
		1.25
	},
	animation_merge_options = {
		idle_animation_merge_options = {},
		move_animation_merge_options = {}
	},
	hitzone_multiplier_types = {},
	
	--hit zones must reference either actual actors attached too or mesh nodes on the unit
	hit_zones = {
		full = {
			prio = 1,
			actors = {}
		},
		neck = {
			prio = 1,
			actors = {
				"c_head"
			}
		},
		torso = {
			prio = 1,
			actors = {
				"body",
				-- "c_hips",
				-- "c_spine",
				-- "c_spine1",
				-- "c_spine2"
			},
			push_actors = {
				"spine_0",
				"spine_1",
				"spine_2",
			}
		}
	},


	max_health = {
		1,
		1,
		1,
		1,
		1,
		1,
		1,
		1
	},
	num_push_anims = {
		push_backward = 4
	},
	debug_color = {
		255,
		40,
		90,
		170
	},
	allowed_layers = {
		planks = 1.5,
		bot_ratling_gun_fire = 5,
		doors = 1.5,
		destructible_wall = 0,
		bot_poison_wind = 5,
		temporary_wall = 0,
		fire_grenade = 5
	}
}


Breeds.daemon_bloodletter = table.create_copy(Breeds.daemon_bloodletter, daemon_data)
local AttackIntensityPerDifficulty = {
	normal = {
		easy = {
			normal = 2
		},
		normal = {
			normal = 2
		},
		hard = {
			normal = 2
		},
		harder = {
			normal = 2
		},
		hardest = {
			normal = 2
		},
		cataclysm = {
			normal = 2
		},
		cataclysm_2 = {
			normal = 2
		},
		cataclysm_3 = {
			normal = 2
		}
	},
	running = {
		easy = {
			running = 2.5
		},
		normal = {
			running = 2.5
		},
		hard = {
			running = 2.5
		},
		harder = {
			running = 2.5
		},
		hardest = {
			running = 2.5
		},
		cataclysm = {
			running = 2.5
		},
		cataclysm_2 = {
			running = 2.5
		},
		cataclysm_3 = {
			running = 2.5
		}
	}
}
BreedActions.daemon_bloodletter = {
	idle = {
		alerted_anims = {
			"alerted"
		}
	},
	alerted = {
		cooldown = -1,
		do_wall_check = true,
		action_weight = 1,
		start_anims_name = {
			bwd = "alerted_bwd",
			fwd = "alerted_fwd",
			left = "alerted_left",
			right = "alerted_right"
		},
		start_anims_data = {
			alerted_fwd = {},
			alerted_bwd = {
				dir = -1,
				rad = math.pi
			},
			alerted_left = {
				dir = 1,
				rad = math.pi / 2
			},
			alerted_right = {
				dir = -1,
				rad = math.pi / 2
			}
		}
	},
	follow = {
		cooldown = -1,
		action_weight = 1,
		start_anims_name = {
			bwd = "move_fwd",
			fwd = "move_fwd",
			left = "move_fwd",
			right = "move_fwd"
		},
		start_anims_data = {
			move_start_fwd = {},
			move_start_bwd = {
				dir = -1,
				rad = math.pi
			},
			move_start_left = {
				dir = 1,
				rad = math.pi / 2
			},
			move_start_right = {
				dir = -1,
				rad = math.pi / 2
			}
		},
		considerations = UtilityConsiderations.clan_rat_follow
	},
	climb = {},
	climb = {},
	running_attack = {
		damage = 3,
		player_push_speed = 3,
		attack_intensity_type = "running",
		action_weight = 10,
		moving_attack = true,
		damage_type = "cutting",
		difficulty_attack_intensity = AttackIntensityPerDifficulty,
		default_attack = {
			anims = {
				"attack_move",
				"attack_move_1",
				"attack_move_2"
			}
		},
		difficulty_damage = BreedTweaks.difficulty_damage.skaven_horde_attack,
		considerations = UtilityConsiderations.clan_rat_running_attack,
		fatigue_type = BreedTweaks.fatigue_types.horde.running_attack,
		diminishing_damage = {},
		difficulty_diminishing_damage = BreedTweaks.diminishing_damage_and_cooldown.horde,
		attack_finished_duration = BreedTweaks.attack_finished_duration.skaven_horde,
		dodge_window_start = BreedTweaks.dodge_windows.running_attack,
		dodge_window_duration = BreedTweaks.dodge_window_durations.running_attack
	},
	normal_attack = {
		damage_type = "cutting",
		damage = 3,
		player_push_speed = 3,
		attack_intensity_type = "normal",
		action_weight = 1,
		move_anim = "move_fwd",
		difficulty_attack_intensity = AttackIntensityPerDifficulty,
		default_attack = {
			anims = {
				"attack_pounce",
				"attack_pounce_2",
				"attack_pounce_3",
				"attack_pounce_4"
			},
			damage_box_range = {
				flat = 2,
				up = 1.7,
				down = -0.75
			}
		},
		high_attack = {
			z_threshold = 1.5,
			anims = {
				"attack_reach_up",
				"attack_reach_up_2",
				"attack_reach_up_3",
				"attack_reach_up_4"
			},
			damage_box_range = {
				flat = 1.5,
				up = 3.8,
				down = 0
			}
		},
		mid_attack = {
			z_threshold = -0.6,
			flat_threshold = 1.5,
			anims = {
				"attack_pounce_down",
				"attack_pounce_down_2",
				"attack_pounce_down_3"
			},
			damage_box_range = {
				flat = 2,
				up = 1.7,
				down = -2
			}
		},
		low_attack = {
			z_threshold = -0.6,
			anims = {
				"attack_reach_down",
				"attack_reach_down_2",
				"attack_reach_down_3"
			},
			damage_box_range = {
				flat = 1,
				up = 1.7,
				down = -3
			}
		},
		knocked_down_attack = {
			z_threshold = 0.6,
			anims = {
				"attack_pounce_down",
				"attack_pounce_down_2",
				"attack_pounce_down_3"
			},
			damage_box_range = {
				flat = 1,
				up = 1.7,
				down = -3
			}
		},
		target_type_exceptions = {
			poison_well = {
				anims = "poison_well",
				damage_box_range = {
					flat = 2,
					up = 1.7,
					down = -0.75
				}
			}
		},
		difficulty_damage = BreedTweaks.difficulty_damage.skaven_horde_attack,
		considerations = UtilityConsiderations.clan_rat_attack,
		fatigue_type = BreedTweaks.fatigue_types.horde.normal_attack,
		diminishing_damage = {},
		difficulty_diminishing_damage = BreedTweaks.diminishing_damage_and_cooldown.horde,
		dodge_window_start = BreedTweaks.dodge_windows.normal_attack,
		dodge_window_duration = BreedTweaks.dodge_window_durations.normal_attack,
		attack_directions = {
			attack_pounce_down_3 = "left",
			attack_move_2 = "left",
			attack_reach_down_2 = "left",
			attack_pounce_2 = "left",
			attack_reach_up_3 = "right",
			attack_move_1 = "right",
			attack_reach_up_2 = "left",
			attack_pounce_down = "left",
			attack_move = "left",
			attack_reach_down = "left",
			attack_run = "left",
			attack_pounce_down_2 = "right",
			attack_reach_up_4 = "left",
			attack_reach_up = "left",
			attack_reach_down_3 = "right",
			attack_pounce_4 = "right",
			attack_pounce_3 = "right",
			attack_pounce = "right"
		},
		attack_finished_duration = BreedTweaks.attack_finished_duration.skaven_horde
	},
	combat_shout = {
		cooldown = -1,
		shout_anim = "shout",
		action_weight = 1,
		considerations = UtilityConsiderations.clan_rat_shout
	},
	smash_door = {
		unblockable = true,
		name = "smash_door",
		damage = 1,
		damage_type = "cutting",
		move_anim = "move_fwd",
		attack_anim = "attack_pounce"
	},
	interest_point_choose = {
		max_range = 10,
		name = "interest_point_choose",
		min_range = 4
	},
	utility_action = {
		fail_cooldown_blackboard_identifier = "attack_cooldown_at",
		name = "utility_action",
		fail_cooldown_name = "utility_fail_cooldown"
	},
	blocked = {
		blocked_anims = {
			"blocked",
			"blocked_2",
			"blocked_3"
		},
		difficulty_duration = BreedTweaks.blocked_duration.skaven_horde
	},
	stagger = {
		scale_animation_speeds = true,
		imation_speeds = true,
		custom_enter_function = function (unit, blackboard, t, action)
			if blackboard.stagger_type == stagger_types.heavy then
				blackboard.stagger_immune_time = t + 1.25
				blackboard.heavy_stagger_immune_time = t + 0.5
			elseif blackboard.stagger_type == stagger_types.explosion then
				blackboard.stagger_immune_time = t + 2.5
				blackboard.heavy_stagger_immune_time = t + 2
			end

			local stagger_anims = action.stagger_anims[blackboard.stagger_type]

			return stagger_anims, "idle"
		end,
		stagger_anims = {
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				},
				dwn = {
					"stagger_fwd_exp"
				}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				},
				dwn = {
					"stagger_fwd_exp"
				}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				},
				dwn = {
					"stagger_fwd_exp"
				}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_left_stab"
				},
				right = {
					"stagger_light_right",
				}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				},
				dwn = {
					"stagger_fwd_exp"
				}
			},
			{
				fwd = {},
				bwd = {},
				left = {},
				right = {}
			},
			{
				fwd = {
					"stagger_light_fwd",
				},
				bwd = {
					"stagger_light_bwd",
				},
				left = {
					"stagger_light_left",
				},
				right = {
					"stagger_light_right",
				},
				dwn = {
					"stagger_fwd_exp"
				}
			}
		}
	},
	look_for_players = {
		anim_event = "idle",
		despawn_radius = 30,
		anim_length = 4,
		look_time = 2
	},
	idle = {}
}

return
