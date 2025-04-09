local wezterm = require 'wezterm'
local config = wezterm.config_builder()
config.font = wezterm.font_with_fallback { 'Iosevka', 'FiraCode', 'Noto Color Emoji', 'Noto Emoji', 'Font Awesome 6 Free Solid', 'Font Awesome 6 Free' }
config.font_size = 14
config.enable_tab_bar = false
config.window_padding = { left = 0, right = 0, top = 0, bottom = 4 }
config.scrollback_lines = 50000
--config.default_prog = { 'fish' }
config.color_scheme = 'Catppuccin Macchiato'
config.enable_wayland = pcall(function()
	_ = os.getenv('NIRI_SOCKET')
end)
config.xcursor_theme = 'Adwaita'
config.xcursor_size = 32
return config
