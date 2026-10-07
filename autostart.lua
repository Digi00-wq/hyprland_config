hl.on("hyprland.start", function()
	-- UI & Statusleiste
	hl.exec_cmd("waybar")

	-- Wallpaper (awww)
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("awww img ~/Pictures/Wallpapers/bunnies-road.png")

	-- Benachrichtigungen (Mako)
	hl.exec_cmd("mako")

	-- Clipboard History (Cliphist)
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")

	-- Portals & Authentifizierung
	hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")

	-- Monitor-Fokus auf den Hauptbildschirm setzen
	-- (Alternativ zum hyprctl-Befehl könntest du hier künftig auch die native Lua-API
	-- hl.dispatch("focusmonitor", "DP-2") testen, der String funktioniert aber genauso)
	hl.exec_cmd("hyprctl dispatch focusmonitor DP-2")

	-- Hintergrundprogramme
	hl.exec_cmd("elephant")
	hl.exec_cmd("todoist s")

	-- Apps mit direkter Zuweisung auf Workspaces (silent)
	hl.exec_cmd("[workspace 1 silent] kitty --class neovim-init -e nvim")
	hl.exec_cmd("[workspace 2 silent] kitty")
	hl.exec_cmd("[workspace 3 silent] firefox")
	hl.exec_cmd("[workspace 4 silent] spotify")
	hl.exec_cmd("[workspace 6 silent] kitty")
	hl.exec_cmd("liquidctl -n 1 set lcd screen static /home/digi/Pictures/fibrator.jpeg")
	hl.exec_cmd(
		"[workspace 6 silent] firefox --new-window https://app.todoist.com/app/project/weekend-todos-6hQJqwqJqM5Vm7F7"
	)
end)
