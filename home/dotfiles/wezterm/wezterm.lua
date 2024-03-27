-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "catppuccin-frappe"
config.enable_tab_bar = false

-- WezTerm bundles JetBrains mono by default (based af)
-- https://wezfurlong.org/wezterm/config/fonts.html
-- config.font = wezterm.font 'Fira Code'
-- -- You can specify some parameters to influence the font selection;
-- -- for example, this selects a Bold, Italic font variant.
-- config.font =
--   wezterm.font('JetBrains Mono', { weight = 'Bold', italic = true })

local keymaps = {
	{ key = "a", string = "ä" },
	{ key = "u", string = "ü" },
	{ key = "o", string = "ö" },
	{ key = "A", string = "Ä" },
	{ key = "U", string = "Ü" },
	{ key = "O", string = "Ö" },
	{ key = "s", string = "ß" },
	{ key = "S", string = "ẞ" },
}

for i, value in ipairs(keymaps) do
	keymaps[i] = {
		key = value.key,
		mods = "OPT",
		action = wezterm.action.SendString(value.string),
	}
end
config.keys = keymaps

-- and finally, return the configuration to wezterm
return config
