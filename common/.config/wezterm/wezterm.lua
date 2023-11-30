-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This table will hold the configuration.
local config = {}

-- In newer versions of wezterm, use the config_builder which will
-- help provide clearer error messages
if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- This is where you actually apply your config choices

-- For example, changing the color scheme:
config.color_scheme = 'Solarized Light (Gogh)'
-- config.color_scheme = 'Solarized (light) (terminal.sexy)'

config.font =
  wezterm.font("Terminus (TTF)")

config.font_size = 15.0


-- config.default_prog = { 'fish' }

config.window_close_confirmation = "NeverPrompt"

-- config.enable_kitty_graphics=false

config.hide_tab_bar_if_only_one_tab = true

config.scrollback_lines = 10000

config.keys = {
  { key = 'Space', mods = 'CTRL', action = wezterm.action.ActivateCopyMode, },
}

config.visual_bell = {
  fade_out_duration_ms = 200,
}

config.audible_bell = "Disabled"

config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- and finally, return the configuration to wezterm
return config
