hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.monitor({ output = "eDP-1", mode = "2880x1920", position = "0x0", scale = 2 })
hl.monitor({ output = "HDMI-A-1", mode = "3840x2160", position = "1440x0", scale = 1 })

hl.config({
	general = {
		layout = "dwindle",
		gaps_in = 0,
		gaps_out = 0,
		border_size = 1,
	},
	decoration = {
		rounding = 0,
		blur = { enabled = false },
		shadow = { enabled = false },
	},
	animations = { enabled = false },
	input = {
		kb_layout = "se",
		follow_mouse = 1,
		sensitivity = 0,
		touchpad = { natural_scroll = true },
	},
	dwindle = { preserve_split = true },
})
