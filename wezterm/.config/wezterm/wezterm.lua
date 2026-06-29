local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

config.color_scheme = "Tokyo Night"
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false
config.show_new_tab_button_in_tab_bar = false

config.window_padding = {
  left = 16,
  right = 16,
  top = 14,
  bottom = 14,
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

config.line_height = 1.1

config.keys = {
  {
    key = "d",
    mods = "CMD",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "d",
    mods = "CMD|SHIFT",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "w",
    mods = "CMD",
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = "[",
    mods = "CMD",
    action = act.ActivatePaneDirection("Prev"),
  },
  {
    key = "]",
    mods = "CMD",
    action = act.ActivatePaneDirection("Next"),
  },
}

return config
