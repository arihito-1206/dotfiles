-- Pull in the wezterm API
local wezterm = require 'wezterm'

-- This will hold the configuration.
local config = wezterm.config_builder()
config.automatically_reload_config = true

-- Color Scheme
-- config.color_scheme = 'nordfox'
--config.color_scheme = 'Nudge (terminal.sexy)'
config.color_scheme = 'Navy and Ivory (terminal.sexy)'
--config.color_scheme = 'iceberg-dark'

-- Font
config.font = wezterm.font(
 "MesloLGS NF",
 { 
   stretch = 'Normal',
   weight = 'Bold',
   bold = false,
   italic = false,
  }
)
config.font_size = 17.0
config.use_ime = true

-- Window
config.window_background_opacity = 0.85
config.macos_window_background_blur = 10
config.window_decorations = "RESIZE"

-- Tab
config.hide_tab_bar_if_only_one_tab = true
config.window_frame = {
   inactive_titlebar_bg = "none",
   active_titlebar_bg = "none",
 }
config.show_new_tab_button_in_tab_bar = false
config.show_close_tab_button_in_tabs = false
config.window_background_gradient = {
   colors = { "#021B21" },
 }
local SOLID_LEFT_ARROW = wezterm.nerdfonts.ple_lower_right_triangle
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.ple_upper_left_triangle
wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
   local background = "#5c6d74"
   local foreground = "#FFFFFF"
   local edge_background = "none"

   if tab.is_active then
     background = "#ae8b2d"
     foreground = "#FFFFFF"
   end
   local edge_foreground = background

   local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. "   "

   return {
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_LEFT_ARROW },
    { Background = { Color = background } },
    { Foreground = { Color = foreground } },
    { Text = title },
    { Background = { Color = edge_background } },
    { Foreground = { Color = edge_foreground } },
    { Text = SOLID_RIGHT_ARROW },   }
end)

-- Cursor
config.default_cursor_style = "SteadyBar"

-- Key Binding
config.leader = { key = "k", mods = "CTRL", timeout_milliseconds = 2000 }
config.keys = require("keybinds").keys
config.key_tables = require("keybinds").key_tables

-- and finally, return the configuration to wezterm
return config
