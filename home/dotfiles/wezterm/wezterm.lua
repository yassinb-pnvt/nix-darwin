-- Pull in the wezterm API
local wezterm = require("wezterm")

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = "Catppuccin Frappe"
config.enable_tab_bar = false
config.font_size = 12.0

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
table.insert(keymaps, { key = ";", mods = "CTRL", action = wezterm.action.SendString("Harpoon4") })

config.keys = keymaps

-- TODO: doesn't work as expected :(
-- Apparently something to do with tmux? https://github.com/wez/wezterm/issues/2003
-- Anyway, I have to SHIFT+CLICK instead of CMD+CLICK (yikes)
-- The config below seems to get ignored
config.mouse_bindings = {
	-- Bind 'Up' event of CTRL-Click to open hyperlinks
	{
		event = { Up = { streak = 1, button = "Left" } },
		mods = "SUPER | SHIFT",
		action = wezterm.action.OpenLinkAtMouseCursor,
	},
	-- Disable the 'Down' event of CTRL-Click to avoid weird program behaviors
	{
		event = { Down = { streak = 1, button = "Left" } },
		mods = "SUPER | SHIFT",
		action = wezterm.action.Nop,
	},
}

config.window_decorations = "NONE | RESIZE"

-- and finally, return the configuration to wezterm
return config
