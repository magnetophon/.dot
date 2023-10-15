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
-- config.color_scheme = 'Solarized Light (Gogh)'
config.color_scheme = 'Solarized (light) (terminal.sexy)'

config.font =
  wezterm.font("Terminus", {weight="Regular", stretch="Normal", style="Normal"})

config.font_size = 16.0

config.window_close_confirmation = "NeverPrompt"

-- config.enable_kitty_graphics=false

config.hide_tab_bar_if_only_one_tab = true

config.scrollback_lines = 10000

config.keys = {
  { key = 'Space', mods = 'CTRL', action = wezterm.action.ActivateCopyMode, },
}
-- and finally, return the configuration to wezterm
return config
