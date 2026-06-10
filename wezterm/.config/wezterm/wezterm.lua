local wezterm = require("wezterm")
local act = wezterm.action
local config = wezterm.config_builder()

-- The Alacritty config imports font-size.toml, but that file isn't present in
-- this repo, so font_size is intentionally left unset here.
config.term = "xterm-256color"
config.color_scheme = 'Tokyo Night'
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = true
config.show_new_tab_button_in_tab_bar = false
config.status_update_interval = 250
config.leader = {
  key = "Space",
  mods = "CTRL|SHIFT",
  timeout_milliseconds = 1500,
}

config.window_padding = {
  left = 16,
  right = 16,
  top = 14,
  bottom = 14,
}
config.window_decorations = "RESIZE"
config.window_background_opacity = 0.98

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

local palette = {
  bg = "#1a1b26",
  fg = "#a9b1d6",
  muted = "#32344a",
  blue = "#7aa2f7",
  green = "#9ece6a",
  yellow = "#e0af68",
  purple = "#bb9af7",
}

local function append_segment(segments, bg, fg, text)
  table.insert(segments, { Background = { Color = bg } })
  table.insert(segments, { Foreground = { Color = fg } })
  table.insert(segments, { Text = " " .. text .. " " })
end

wezterm.on("update-status", function(window, pane)
  local left = {}
  local right = {}
  local key_table = window:active_key_table()
  local leader = window:leader_is_active()

  if key_table == "resize_pane" then
    append_segment(left, palette.yellow, palette.bg, "RESIZE")
    append_segment(left, palette.muted, palette.fg, "h/j/k/l resize")
    append_segment(left, palette.muted, palette.fg, "Esc exit")
  elseif key_table == "tab_mode" then
    append_segment(left, palette.purple, palette.bg, "TABS")
    append_segment(left, palette.muted, palette.fg, "n/p next-prev")
    append_segment(left, palette.muted, palette.fg, "c new")
    append_segment(left, palette.muted, palette.fg, "x close")
    append_segment(left, palette.muted, palette.fg, "1-9 jump")
    append_segment(left, palette.muted, palette.fg, "Esc exit")
  elseif leader then
    append_segment(left, palette.blue, palette.bg, "COMMAND")
    append_segment(left, palette.muted, palette.fg, "v split-right")
    append_segment(left, palette.muted, palette.fg, "s split-down")
    append_segment(left, palette.muted, palette.fg, "h/j/k/l move")
    append_segment(left, palette.muted, palette.fg, "r resize")
    append_segment(left, palette.muted, palette.fg, "t tabs")
    append_segment(left, palette.muted, palette.fg, "z zoom")
    append_segment(left, palette.muted, palette.fg, "x close")
  else
    append_segment(left, palette.green, palette.bg, "NORMAL")
    append_segment(left, palette.muted, palette.fg, "Ctrl+Shift+Space command mode")
    append_segment(left, palette.muted, palette.fg, "Cmd+? all keys")
  end

  append_segment(right, palette.muted, palette.fg, pane:get_title())
  append_segment(right, palette.muted, palette.fg, wezterm.strftime("%a %H:%M"))

  window:set_left_status(wezterm.format(left))
  window:set_right_status(wezterm.format(right))
end)

local show_key_assignments = act.ShowLauncherArgs {
  title = "Keyboard shortcuts",
  flags = "FUZZY|KEY_ASSIGNMENTS",
}

config.keys = {
  {
    key = "F11",
    action = act.ToggleFullScreen,
  },
  {
    key = "/",
    mods = "CMD|SHIFT",
    action = show_key_assignments,
  },
  {
    key = "v",
    mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  {
    key = "s",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },
  {
    key = "h",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Left"),
  },
  {
    key = "j",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Down"),
  },
  {
    key = "k",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Up"),
  },
  {
    key = "l",
    mods = "LEADER",
    action = act.ActivatePaneDirection("Right"),
  },
  {
    key = "z",
    mods = "LEADER",
    action = act.TogglePaneZoomState,
  },
  {
    key = "x",
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = true },
  },
  {
    key = "c",
    mods = "LEADER",
    action = act.SpawnTab("CurrentPaneDomain"),
  },
  {
    key = "n",
    mods = "LEADER",
    action = act.ActivateTabRelative(1),
  },
  {
    key = "p",
    mods = "LEADER",
    action = act.ActivateTabRelative(-1),
  },
  {
    key = "r",
    mods = "LEADER",
    action = act.ActivateKeyTable {
      name = "resize_pane",
      one_shot = false,
    },
  },
  {
    key = "t",
    mods = "LEADER",
    action = act.ActivateKeyTable {
      name = "tab_mode",
      one_shot = false,
    },
  },
}

config.key_tables = {
  resize_pane = {
    { key = "h",          action = act.AdjustPaneSize { "Left", 1 } },
    { key = "j",          action = act.AdjustPaneSize { "Down", 1 } },
    { key = "k",          action = act.AdjustPaneSize { "Up", 1 } },
    { key = "l",          action = act.AdjustPaneSize { "Right", 1 } },
    { key = "LeftArrow",  action = act.AdjustPaneSize { "Left", 1 } },
    { key = "DownArrow",  action = act.AdjustPaneSize { "Down", 1 } },
    { key = "UpArrow",    action = act.AdjustPaneSize { "Up", 1 } },
    { key = "RightArrow", action = act.AdjustPaneSize { "Right", 1 } },
    { key = "Escape",     action = "PopKeyTable" },
  },
  tab_mode = {
    { key = "n",      action = act.ActivateTabRelative(1) },
    { key = "p",      action = act.ActivateTabRelative(-1) },
    { key = "h",      action = act.ActivateTabRelative(-1) },
    { key = "l",      action = act.ActivateTabRelative(1) },
    { key = "c",      action = act.SpawnTab("CurrentPaneDomain") },
    { key = "x",      action = act.CloseCurrentTab { confirm = true } },
    { key = "1",      action = act.ActivateTab(0) },
    { key = "2",      action = act.ActivateTab(1) },
    { key = "3",      action = act.ActivateTab(2) },
    { key = "4",      action = act.ActivateTab(3) },
    { key = "5",      action = act.ActivateTab(4) },
    { key = "6",      action = act.ActivateTab(5) },
    { key = "7",      action = act.ActivateTab(6) },
    { key = "8",      action = act.ActivateTab(7) },
    { key = "9",      action = act.ActivateTab(8) },
    { key = "Escape", action = "PopKeyTable" },
  },
}

return config
