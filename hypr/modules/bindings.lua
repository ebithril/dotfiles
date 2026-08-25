return function(programs)
	local mod = programs.mod

	-- Applications
	hl.bind(mod .. " + Return", hl.dsp.exec_cmd(programs.terminal), { description = "Open terminal" })
	hl.bind(mod .. " + E", hl.dsp.exec_cmd(programs.file_manager), { description = "Open file manager" })
	hl.bind(mod .. " + SPACE", hl.dsp.exec_cmd(programs.launcher), { description = "Open launcher" })

	-- Window management
	hl.bind(mod .. " + SHIFT + Q", hl.dsp.window.close(), { description = "Close window" })
	hl.bind(mod .. " + V", hl.dsp.window.float(), { description = "Toggle floating" })
	hl.bind(mod .. " + P", hl.dsp.window.pseudo(), { description = "Toggle pseudotile" })
	hl.bind(mod .. " + M", hl.dsp.exec_cmd("hyprshutdown"), { description = "Exit Hyprland" })

	-- Focus
	hl.bind(mod .. " + Left", hl.dsp.focus({ direction = "l" }))
	hl.bind(mod .. " + Right", hl.dsp.focus({ direction = "r" }))
	hl.bind(mod .. " + Up", hl.dsp.focus({ direction = "u" }))
	hl.bind(mod .. " + Down", hl.dsp.focus({ direction = "d" }))

	-- Workspaces
	local workspaces = {
		["1"] = 1,
		["2"] = 2,
		["3"] = 3,
		["4"] = 4,
		["5"] = 5,
		["6"] = 6,
		["7"] = 7,
		["8"] = 8,
		["9"] = 9,
		["0"] = 10,
	}

	for key, workspace in pairs(workspaces) do
		hl.bind(mod .. " + " .. key, hl.dsp.focus({ workspace = workspace }))
		hl.bind(mod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = workspace }))
	end

	hl.bind(mod .. " + D", hl.dsp.workspace.toggle_special("scratch"), { description = "Toggle scratchpad" })
	hl.bind(mod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
	hl.bind(mod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

	-- Mouse window management
	hl.bind(mod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
	hl.bind(mod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

	-- Volume and brightness
	hl.bind(
		"XF86AudioRaiseVolume",
		hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
		{ repeating = true, locked = true }
	)
	hl.bind(
		"XF86AudioLowerVolume",
		hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
		{ repeating = true, locked = true }
	)
	hl.bind(
		"XF86AudioMute",
		hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
		{ repeating = true, locked = true }
	)
	hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("pulseaudio-ctl mute-input"), { repeating = true, locked = true })
	hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"), { repeating = true, locked = true })
	hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"), { repeating = true, locked = true })

	-- Media
	hl.bind("XF86AudioNext", hl.dsp.exec_cmd("playerctl next"), { locked = true })
	hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
	hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
	hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("playerctl previous"), { locked = true })

	-- Personal binds
	hl.bind(
		mod .. " + SHIFT + S",
		hl.dsp.exec_cmd("hyprshot -m region --clipboard-only"),
		{ description = "Screenshot region" }
	)
	hl.bind(mod .. " + A", hl.dsp.exec_cmd(programs.journal), { description = "Open journal" })

	-- Restore this once the new Quickshell exists:
	-- hl.bind(
	--     mod .. " + SHIFT + T",
	--     hl.dsp.global("quickshell:theme"),
	--     { description = "Switch theme" }
	-- )
end
