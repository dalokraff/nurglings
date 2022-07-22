--currently this Behaviour tree is unused
BreedBehaviors.daemon_bloodletter = {
	"BTSelector",
	{
		"BTSpawningAction",
		condition = "spawn",
		name = "spawn"
	},
	{
		"BTInVortexAction",
		condition = "in_vortex",
		name = "in_vortex"
	},
	{
		"BTCritterRatScurryUnderDoorAction",
		name = "under_door",
		condition = "at_smart_object_and_door",
		action_data = BreedActions.daemon_bloodletter.scurry_under_door
	},
	{
		"BTHesitateAction",
		name = "hesitate",
		condition = "is_alerted",
		action_data = BreedActions.daemon_bloodletter.alerted
	},
	-- {
	-- 	"BTAlertedAction",
	-- 	name = "alerted",
	-- 	condition = "player_spotted",
	-- 	action_data = ACTIONS.alerted
	-- },
	-- {
	-- 	"BTSequence",
	-- 	{
	-- 		"BTClanRatFollowAction",
	-- 		name = "follow",
	-- 		action_data = BreedActions.daemon_bloodletter.follow
	-- 	},
	-- 	{
	-- 		"BTCritterRatDigAction",
	-- 		name = "dig"
	-- 	},
	-- 	condition = "is_fleeing",
	-- 	name = "flee_sequence"
	-- },
	{
		"BTUtilityNode",
		{
			"BTClanRatFollowAction",
			name = "follow",
			action_data = BreedActions.daemon_bloodletter.follow
		},
		name = "in_combat",
		condition = "confirmed_player_sighting",
		action_data = BreedActions.daemon_bloodletter.utility_action
	},
	{
		"BTStaggerAction",
		name = "stagger",
		condition = "stagger",
		action_data = BreedActions.daemon_bloodletter.stagger
	},
	{
		"BTIdleAction",
		name = "idle",
		action_data = BreedActions.daemon_bloodletter.idle
	},
	name = "daemon_bloodletter"
}

return