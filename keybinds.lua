local mainMod = "SUPER"
local terminal = "kitty"
local fileManager = "dolphin"

-- Basis-Anwendungen & Fenstersteuerung
hl.bind(mainMod .. " + BACKSPACE", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + W", hl.dsp.window.close())
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + SHIFT + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }))
-- App-Launcher & Scripte
hl.bind("SUPER + Space", hl.dsp.exec_cmd("walker"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("flatpak run app.zen_browser.zen"))
hl.bind(mainMod .. " + SHIFT + M", hl.dsp.exec_cmd("spotify"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("pavucontrol"))

-- Waybar neu laden
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("pkill waybar && waybar"))

-- Layout (Dwindle)
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. "+ period", hl.dsp.exec_cmd("rofi -show emoji -emoji-mode insert"))

hl.bind(
	"SUPER + Escape",
	hl.dsp.exec_cmd(
		[[bash -c 'res=$(echo -e "Lock\nSuspend\nLogout\nReboot\nShutdown" | walker --dmenu); case "$res" in "Lock") loginctl lock-session && sleep 1 && hyprctl dispatch "hl.dsp.dpms(\"off\")";; "Suspend") hyprlock;; "Logout") hyprctl dispatch "hl.dsp.exit()";; "Reboot") systemctl reboot;; "Shutdown") systemctl poweroff;; esac']]
	)
)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Workspaces: Wechseln (1-0), Verschieben (SHIFT), und Still Verschieben (SHIFT + ALT)
for i = 1, 10 do
	local key = i % 10 -- 10 mappt auf die Taste 0

	-- Wechseln
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))

	-- Verschieben (mit Fokus-Wechsel)
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i, follow = true }))

	-- Verschieben (ohne Fokus-Wechsel / silent)
	hl.bind(mainMod .. " + ALT + " .. key, hl.dsp.window.move({ workspace = i, follow = false }))
end

-- Special Workspace (Scratchpad)
hl.bind(mainMod .. " + S", hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Audio & Helligkeit (bindel = locked/repeating, bindl = locked)
-- Volume (2% Schritte)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 2%+"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 2%-"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioMicMute",
	hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
	{ locked = true, repeating = true }
)

-- Brightness (5% Schritte)
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { locked = true, repeating = true })

-- Playerctl
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

-- Screenshots
-- Mit Swappy bearbeiten
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("hyprshot -m region --raw | swappy -f -"))
-- Direkt ins Clipboard & in den Pictures-Ordner
hl.bind("Print", hl.dsp.exec_cmd("hyprshot -m region output --clipboard-only output -o ~/Pictures"))

-- Copy / Paste (Universal Shortcuts)
hl.bind("SUPER + C", function()
	hl.dispatch("sendshortcut", "CTRL,Insert,")
end, { description = "Universal copy" })
hl.bind("SUPER + V", function()
	hl.dispatch("sendshortcut", "SHIFT,Insert,")
end, { description = "Universal paste" })
hl.bind("SUPER + X", function()
	hl.dispatch("sendshortcut", "CTRL,X,")
end, { description = "Universal cut" })

-- TAB between windows
-- In Lua können wir einer Taste einfach eine Funktion zuweisen, die nacheinander mehrere Befehle ausführt
hl.bind("ALT + Return", hl.dsp.window.cycle_next())

hl.bind("ALT + SHIFT + TAB", function()
	hl.dispatch("cyclenext", "prev")
	hl.dispatch("bringactivetotop")
end)
