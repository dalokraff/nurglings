return {
	run = function()
		fassert(rawget(_G, "new_mod"), "`nurglings` mod must be lower than Vermintide Mod Framework in your launcher's load order.")

		new_mod("nurglings", {
			mod_script       = "scripts/mods/nurglings/nurglings",
			mod_data         = "scripts/mods/nurglings/nurglings_data",
			mod_localization = "scripts/mods/nurglings/nurglings_localization",
		})
	end,
	packages = {
		"resource_packages/nurglings/nurglings",
	},
}
