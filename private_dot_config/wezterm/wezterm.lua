local wezterm = require 'wezterm'

-- local config = {}
-- 
-- if wezterm.config_builder then
--   config = wezterm.config_builder()
-- end

return {
font = wezterm.font_with_fallback{
  { family = 'DejaVu Sans Mono'},
  'Hack',
  'Noto Color Emoji',
  'icons-in-terminal'
},

  window_close_confirmation = 'NeverPrompt',
  default_cursor_style = 'SteadyBar',
  animation_fps = 1,
  cursor_blink_ease_in = 'Constant',
  cursor_blink_ease_out = 'Constant',
  hide_tab_bar_if_only_one_tab = true,
  bidi_enabled = true,
  use_fancy_tab_bar = false,
  -- text_blink_rate = 0,

  -- Start flavours
  colors = {
  foreground    = '#e5e9f0',
  background    = '#2e3440',
  cursor_bg     = '#e5e9f0',
  cursor_fg     = '#e5e9f0',
  cursor_border = '#e5e9f0',
  selection_bg  = '#e5e9f0',
  selection_fg  = '#2e3440',

  tab_bar = {
  background = '#2e3440',
    active_tab = {
      bg_color = '#4c566a',
      fg_color = '#e5e9f0',
    },
    inactive_tab = {
      bg_color = '#2e3440',
      fg_color = '#e5e9f0',
    },
    inactive_tab_hover = {
      bg_color = '#4c566a',
      fg_color = '#e5e9f0',
      italic = true,
    },
    new_tab = {
      bg_color = '#2e3440',
      fg_color = '#e5e9f0',
    },
    new_tab_hover = {
      bg_color = '#4c566a',
      fg_color = '#e5e9f0',
      italic = true,
    }
  },

  ansi = {
    '#2e3440',
    '#bf616a',
    '#a3be8c',
    '#ebcb8b',
    '#81a1c1',
    '#b48ead',
    '#88c0d0',
    '#e5e9f0'
  },

  brights = {
    '#4c566a',
    '#bf616a',
    '#a3be8c',
    '#ebcb8b',
    '#81a1c1',
    '#b48ead',
    '#88c0d0',
    '#8fbcbb'
  }
  }
  -- End flavours
}
