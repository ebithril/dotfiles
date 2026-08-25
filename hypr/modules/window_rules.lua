-- Ignore application maximize requests.
hl.window_rule({
	name = "suppress-maximize-events",
	match = { class = ".*" },
	suppress_event = "maximize",
})

-- Existing XWayland compatibility workaround.
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Journal launcher.
hl.window_rule({
	name = "journal-launcher",
	match = { class = "journal-launcher" },
	float = true,
	center = true,
	stay_focused = true,
})
