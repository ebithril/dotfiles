-- Hyprland configuration entry point.

local programs = {
	mod = "ALT",
	terminal = "kitty",
	file_manager = "dolphin",
	launcher = "wofi --show drun",
	journal = os.getenv("HOME") .. "/Code/rust/interstitial-journaling/target/release/interstitial-journaling",
}

require("modules.settings")
require("modules.autostart")
require("modules.bindings")(programs)
require("modules.window_rules")
