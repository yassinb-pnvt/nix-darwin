-- WezTerm configuration for transparency and tmux support
local wezterm = require 'wezterm'

return {
  -- Enable transparency
  window_background_opacity = 0.8,
  text_background_opacity = 1.0,
  
  -- Window appearance
  window_decorations = "RESIZE",
  window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
  },
  
  -- Font configuration
  font = wezterm.font_with_fallback({
    "JetBrains Mono",
    "Fira Code",
    "Monaco",
  }),
  font_size = 12.0,
  
  -- Color scheme (you can use catppuccin or other themes)
  color_scheme = "Catppuccin Mocha",
  
  -- Terminal settings
  default_prog = { "/etc/profiles/per-user/yassin.bousaadi/bin/fish", "--login", "--interactive" },
  term = "xterm-256color",
  
  -- Enable truecolor
  enable_wayland = false,
  
  -- Tab bar
  enable_tab_bar = true,
  hide_tab_bar_if_only_one_tab = true,
  
  -- Key bindings
  keys = {
    -- Copy mode
    {
      key = 'x',
      mods = 'CTRL|SHIFT',
      action = wezterm.action { CopyTo = 'Clipboard' },
    },
    {
      key = 'v',
      mods = 'CTRL|SHIFT',
      action = wezterm.action { PasteFrom = 'Clipboard' },
    },
  },
  
  -- Window settings
  initial_cols = 120,
  initial_rows = 30,
  
  -- Performance
  front_end = "WebGpu",
  webgpu_power_preference = "HighPerformance",
}

