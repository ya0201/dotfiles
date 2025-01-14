-- Pull in the wezterm API
local wezterm = require 'wezterm'
local mux = wezterm.mux

-- This will hold the configuration.
local config = wezterm.config_builder()

-- This is where you actually apply your config choices
-- refs
--   https://blog.grasys.io/post/yusukeh/terminal-wezterm/
--   https://wezfurlong.org/wezterm/colorschemes/i/index.html#iceberg-dark
--   https://wezfurlong.org/wezterm/hyperlinks.html#implicit-hyperlinks
--   https://wezfurlong.org/wezterm/config/lua/gui-events/gui-startup.html
--   https://github.com/wez/wezterm/issues/284#issuecomment-1399590543
config.scrollback_lines = 100000
config.audible_bell = "Disabled"
config.exit_behavior = 'CloseOnCleanExit'
config.hyperlink_rules = wezterm.default_hyperlink_rules()
config.initial_cols = 100
config.initial_rows = 30
config.font_size = 16
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true
wezterm.on('gui-startup', function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {})
  window:gui_window():toggle_fullscreen()
end)

-- For example, changing the color scheme:
-- config.color_scheme = 'AdventureTime'
config.color_scheme = 'iceberg-dark'

-- and finally, return the configuration to wezterm
return config
