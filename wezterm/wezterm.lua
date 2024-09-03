local wezterm = require 'wezterm'

local config = wezterm.config_builder()

-- config.font = wezterm.font 'Hasklug Nerd Font Mono'
config.font = wezterm.font 'BlexMono Nerd Font Mono'

clor_blue = wezterm.color.parse('#191e45')
clor_blue_light = clor_blue:lighten(0.5)

config.colors = {
  -- The default text color
  foreground = '#e5ded6',
  -- The default background color
  background = '#161c23',

  -- Overrides the cell background color when the current cell is occupied by the
  -- cursor and the cursor style is set to Block
  cursor_bg = clor_blue_light,
  -- Overrides the text color when the current cell is occupied by the cursor
  cursor_fg = clor_blue,
  -- Specifies the border color of the cursor when the cursor style is set to Block,
  -- or the color of the vertical or horizontal bar when the cursor style is set to
  -- Bar or Underline.
  cursor_border = clor_blue_light,

  -- the foreground color of selected text
  selection_fg = '#161c23',
  -- the background color of selected text
  selection_bg = '#c6b8ad',

  -- The color of the scrollbar "thumb"; the portion that represents the current viewport
  scrollbar_thumb = '#222222',

  -- The color of the split lines between panes
  split = '#333',

  ansi = {
    '#13181e', -- black
    '#d32c4d', -- red
    '#57a331', -- green
    '#dc7759', -- yellow
    '#36b2d4', -- blue
    '#b759dc', -- magenta
    '#23a580', -- cyan
    '#c6b8ad', -- white
  },
  brights = {
    '#313f4e',
    '#dc597f',
    '#7fdc59',
    '#dcb659',
    '#59dcd8',
    '#dc59c0',
    '#59dcb7',
    '#e5ded6',
  },

  -- Since: 20220319-142410-0fcdea07
  -- When the IME, a dead key or a leader key are being processed and are effectively
  -- holding input pending the result of input composition, change the cursor
  -- to this color to give a visual cue about the compose state.
  compose_cursor = '#b5f',

  tab_bar = {
    active_tab = {
      bg_color = '#161c23',
      fg_color = '#e5ded6',
    },
    inactive_tab = {
      bg_color = '#0e1217',
      fg_color = '#c6b8ad',
    },
    inactive_tab_hover = {
      bg_color = '#13171e',
      fg_color = '#e5ded6',
    },
    new_tab = {
      bg_color = '#0e1217',
      fg_color = '#c6b8ad',
    },
    new_tab_hover = {
      bg_color = '#13171e',
      fg_color = '#e5ded6',
    },
  }
}

-----------------------------
-- WINDOW STYLING
-----------------------------
config.window_decorations = 'RESIZE'
config.window_frame = {
  font = wezterm.font({ family = 'BlexMono Nerd Font Mono', weight = 'Bold' }),
  font_size = 11,
  active_titlebar_bg = '#0e1217',
  inactive_titlebar_bg = '#0e1217',
}

config.inactive_pane_hsb = {
  saturation = 0.9,
  brightness = 0.7,
}

-- powerline-style status bar
wezterm.on('update-status', function(window)
  local SOLID_LEFT_ARROW = utf8.char(0xe0b2)

  local color_scheme = window:effective_config().resolved_palette
  local bg = color_scheme.background
  local fg = color_scheme.foreground

  -- pass in a list of strings
  --
  -- and so on. displays first item most to the right, and so on
  function statusline(bars, from, to)
    gradient = wezterm.color.gradient({
      orientation = "Horizontal",
      colors = { from, to },
    }, #bars)
    fmt = {}
    lastbg = 'none'
    for i=#bars,1,-1 do
      col = gradient[#bars - i + 1]
      table.insert(fmt, { Background = { Color = lastbg } })
      table.insert(fmt, { Foreground = { Color = col } })
      table.insert(fmt, { Text = SOLID_LEFT_ARROW })
      table.insert(fmt, { Background = { Color = col } })
      table.insert(fmt, { Foreground = { Color = fg } })
      table.insert(fmt, { Text = ' ' .. bars[i] .. ' ' })
      lastbg = col
    end
    return fmt
  end

  statusbg = clor_blue
  window:set_right_status(wezterm.format(statusline({
    wezterm.hostname(),
    wezterm.strftime("%a %b %-d %H:%M"),
    window:active_workspace(),
  }, statusbg:lighten(0.2), statusbg)))
end)


-----------------------------
-- KEYBOARD BINDINGS
-----------------------------
local act = wezterm.action
config.disable_default_key_bindings = true
config.leader = { key = 'w', mods = 'SUPER', timeout_milliseconds = 1000 }
config.keys = {
  -- ctrl+shift+l to open debug
  { key = 'L', mods = 'CTRL', action = act.ShowDebugOverlay },
  -- ctrl+shift+c to copy selection
  { key = 'C', mods = 'CTRL', action = act.CopyTo 'ClipboardAndPrimarySelection' },
  -- ctrl+shift+v to paste
  { key = 'V', mods = 'CTRL', action = act.PasteFrom 'Clipboard' },

  -- super+, to open config in helix
  {
    key = ',',
    mods = 'SUPER',
    action = act.SpawnCommandInNewTab {
      cwd = wezterm.home_dir,
      args = { 'hx', wezterm.config_file },
    },
  },

  -- WINDOW BINDINGS
  -- super+w n to open a tab
  {
    key = "n",
    mods = "LEADER",
    action = act.SpawnTab "CurrentPaneDomain",
  },
  -- super+w w to close tab
  {
    key = "w",
    mods = "LEADER",
    action = act.CloseCurrentTab { confirm = false },
  },
  -- super+w h to split horizontal
  {
    key = "s",
    mods = "LEADER",
    action = act.SplitHorizontal { domain = "CurrentPaneDomain" },
  },
  -- super+w v to split vertical
  {
    key = "v",
    mods = "LEADER",
    action = act.SplitVertical { domain = "CurrentPaneDomain" },
  },
  -- super+w q to close current pane
  {
    key = "q",
    mods = "LEADER",
    action = act.CloseCurrentPane { confirm = false },
  },
  -- super+w h,j,k,l to select pain in that direction
  { key = "h", mods = "LEADER", action = act.ActivatePaneDirection "Left" },
  { key = "j", mods = "LEADER", action = act.ActivatePaneDirection "Down" },
  { key = "k", mods = "LEADER", action = act.ActivatePaneDirection "Up" },
  { key = "l", mods = "LEADER", action = act.ActivatePaneDirection "Right" },

  -- super+w 1,2,...9,0 to activate that tab
  { key = "1", mods = "LEADER", action = act.ActivateTab(0)},
  { key = "2", mods = "LEADER", action = act.ActivateTab(1)},
  { key = "3", mods = "LEADER", action = act.ActivateTab(2)},
  { key = "4", mods = "LEADER", action = act.ActivateTab(3)},
  { key = "5", mods = "LEADER", action = act.ActivateTab(4)},
  { key = "6", mods = "LEADER", action = act.ActivateTab(5)},
  { key = "7", mods = "LEADER", action = act.ActivateTab(6)},
  { key = "8", mods = "LEADER", action = act.ActivateTab(7)},
  { key = "9", mods = "LEADER", action = act.ActivateTab(8)},
  { key = "0", mods = "LEADER", action = act.ActivateTab(9)},
}

-- return a new array containing the concatenation of all of its 
-- parameters. Scalar parameters are included in place, and array 
-- parameters have their values shallow-copied to the final array.
-- Note that userdata and function values are treated as scalar.
--
-- https://stackoverflow.com/a/1413919
function array_concat(...) 
    local t = {}
    for n = 1,select("#",...) do
        local arg = select(n,...)
        if type(arg)=="table" then
            for _,v in ipairs(arg) do
                t[#t+1] = v
            end
        else
            t[#t+1] = arg
        end
    end
    return t
end

return config

