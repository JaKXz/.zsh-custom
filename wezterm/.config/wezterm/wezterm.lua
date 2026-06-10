local wezterm = require("wezterm")
local config = wezterm.config_builder()

local function first_existing_path(paths)
  for _, path in ipairs(paths) do
    local file = io.open(path, "r")
    if file then
      file:close()
      return path
    end
  end

  return nil
end

local zellij = first_existing_path({
  "/opt/homebrew/bin/zellij",
  "/usr/local/bin/zellij",
  "/usr/bin/zellij",
}) or "zellij"

-- The Alacritty config imports font-size.toml, but that file isn't present in
-- this repo, so font_size is intentionally left unset here.
config.term = "xterm-256color"
config.default_prog = { zellij }

config.window_padding = {
  left = 16,
  right = 16,
  top = 14,
  bottom = 14,
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98

config.enable_tab_bar = false

config.font = wezterm.font("JetBrainsMono Nerd Font Mono")

config.colors = {
  foreground = "#a9b1d6",
  background = "#1a1b26",
  ansi = {
    "#32344a",
    "#f7768e",
    "#9ece6a",
    "#e0af68",
    "#7aa2f7",
    "#ad8ee6",
    "#449dab",
    "#787c99",
  },
  brights = {
    "#444b6a",
    "#ff7a93",
    "#b9f27c",
    "#ff9e64",
    "#7da6ff",
    "#bb9af7",
    "#0db9d7",
    "#acb0d0",
  },
  selection_bg = "#7aa2f7",
}

config.keys = {
  {
    key = "F11",
    action = wezterm.action.ToggleFullScreen,
  },
}

return config
