local wezterm = require "wezterm"
local mux = wezterm.mux
local config = {}

if wezterm.config_builder then
  config = wezterm.config_builder()
end

-- behavior --------------------------------------------------------------------

config.automatically_reload_config = true
config.window_close_confirmation = "NeverPrompt"

-- window ----------------------------------------------------------------------

wezterm.on("gui-startup", function(cmd)
  local tab, pane, window = mux.spawn_window(cmd or {
    -- start window in upper-left
    position = { x = 0, y = 0, },
  })
end)

config.initial_cols = 90
config.initial_rows = 50
config.enable_scroll_bar = false
config.window_padding = {
  left = 0,
  right = 0,
  top = 0,
  bottom = 0,
}

-- color -----------------------------------------------------------------------

config.font = wezterm.font_with_fallback({
  "PragmataPro Mono Liga",
  "Menlo",
})
config.font_size = 14.0

config.color_scheme = "Eighties (base16)"
-- config.color_scheme = "Melange_Dark"
-- config.color_scheme = "Melange_Light"
-- config.color_scheme = "Monokai (base16)"
-- config.color_scheme = "Palenight (Gogh)"
-- config.color_scheme = "Tomorrow Night Eighties"
-- config.color_scheme = "WarmNeon"
-- config.color_scheme = "Whimsy"

-- keys ------------------------------------------------------------------------

config.keys = {
  {
    key = "Escape",
    mods = "CTRL",
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
