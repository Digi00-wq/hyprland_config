hl.config({
	misc = {
		force_default_wallpaper = -1, -- Set to 0 or 1 to disable the anime mascot wallpapers
		disable_hyprland_logo = false, -- If true disables the random hyprland logo / anime girl background. :(
		mouse_move_enables_dpms = true,
		key_press_enables_dpms = true,
	},
	master = {
		new_status = "master",
	},
	dwindle = {
		preserve_split = true, -- You probably want this
	},
	xwayland = {
		force_zero_scaling = true,
	},
})

-- Monitor DP-2 (Ungerade Workspaces)
hl.workspace_rule({ workspace = "1", monitor = "DP-2", default = true })
hl.workspace_rule({ workspace = "3", monitor = "DP-2" })
hl.workspace_rule({ workspace = "5", monitor = "DP-2" })
hl.workspace_rule({ workspace = "7", monitor = "DP-2" })
hl.workspace_rule({ workspace = "9", monitor = "DP-2" })

-- Monitor HDMI-A-3 (Gerade Workspaces)
hl.workspace_rule({ workspace = "2", monitor = "HDMI-A-3", default = true })
hl.workspace_rule({ workspace = "4", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "6", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "8", monitor = "HDMI-A-3" })
hl.workspace_rule({ workspace = "10", monitor = "HDMI-A-3" })
