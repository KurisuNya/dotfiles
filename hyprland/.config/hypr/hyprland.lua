package.path = package.path .. ";./?.lua;./?/init.lua"
local smw = require("plugins.split-monitor-workspaces")

hl.monitor({
  output = "",
  mode = "highrr",
})
hl.monitor({
  output = "eDP-1",
  bitdepth = 10,
  icc = "/home/kurisunya/.config/hypr/edid.icc",
})

hl.config({
  general = {
    border_size = 1,
    gaps_in = 1,
    gaps_out = 2,
    col = {
      active_border = "#bb9af7ff",
      inactive_border = "#595959aa",
    },
    layout = "master",
    resize_on_border = true,
  },

  decoration = {
    rounding = 3,
    dim_special = 0.3,
    blur = { enabled = false },
    shadow = { enabled = false },
  },

  input = {
    follow_mouse = 0,
    touchpad = {
      natural_scroll = true,
      scroll_factor = 1.5,
    },
  },

  master = {
    new_status = "master",
    new_on_top = true,
  },

  misc = {
    disable_hyprland_logo = true,
    disable_splash_rendering = true,
    animate_manual_resizes = true,
    animate_mouse_windowdragging = true,
  },
})

hl.animation({ leaf = "windows", enabled = true, speed = 4, bezier = "default", style = "popin 80%" })
hl.animation({ leaf = "fade", enabled = true, speed = 4, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 2, bezier = "default", style = "slide" })

-- XDF config
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("XDG_CACHE_HOME", "/tmp")
--- QT config
hl.env("QT_AUTO_SCREEN_SCALE_FACTOR", "1")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORMTHEME_QT6", "qt6ct")
--- ime config
hl.env("INPUT_METHOD", "fcitx")
hl.env("QT_IM_MODULE", "fcitx")
hl.env("SDL_IM_MODULE", "fcitx")
hl.env("GLFW_IM_MODULE", "fcitx")
hl.env("XMODIFIERS", "@im=fcitx")
--- cursor theme
hl.env("HYPRCURSOR_THEME", "Ano")
hl.env("XCURSOR_THEME", "Ano")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("XCURSOR_SIZE", "24")
--- default terminal
hl.env("TERMINAL", "kitty")
--- default browser
hl.env("BROWSER", "google-chrome-stable")
hl.env("CHROME_EXECUTABLE", "google-chrome-stable")

hl.on("hyprland.start", function()
  hl.exec_cmd("systemctl --user start hyprland-session.target")
  hl.exec_cmd(
    "systemctl --user start xsettingsd.service "
      .. "&& echo 'Xft.dpi: 192' | xrdb -merge "
      .. "&& xprop -root -format _XWAYLAND_GLOBAL_OUTPUT_SCALE 32c -set _XWAYLAND_GLOBAL_OUTPUT_SCALE 2"
  )
  hl.exec_cmd("systemctl --user start hyprpolkitagent")
  hl.exec_cmd("fcitx5 -d")
  hl.exec_cmd("udiskie &")
  hl.exec_cmd("bat cache --build &>/dev/null")
  hl.exec_cmd("dms run")
end)

hl.on("hyprland.shutdown", function()
  os.execute("systemctl --user stop hyprland-session.target && sleep 0.1")
end)

-- useful software
hl.bind("SUPER + C", hl.dsp.exec_cmd("kitty"))
hl.bind("SUPER + W", hl.dsp.exec_cmd("google-chrome-stable"))
hl.bind("SUPER + X", hl.dsp.exec_cmd("kitty nvim"))
hl.bind("SUPER + S", hl.dsp.exec_cmd("dms ipc call spotlight toggle"))
hl.bind("SUPER + V", hl.dsp.exec_cmd("dms ipc call clipboard toggle"))
hl.bind("SUPER + D", hl.dsp.exec_cmd("dms ipc call notifications toggle"))
hl.bind("SUPER + L", hl.dsp.exec_cmd("dms ipc call lock lock"))
hl.bind("SUPER + I", hl.dsp.exec_cmd("dms ipc call settings toggle"))
-- basic action
hl.bind("SUPER + A", hl.dsp.window.fullscreen_state({ internal = 2, client = 0, action = "toggle" }))
hl.bind("SUPER + Q", hl.dsp.window.close())
hl.bind("SUPER + Z", hl.dsp.window.float())
-- mouse action
hl.bind("SUPER + mouse:272", hl.dsp.window.drag(), { mouse = true })
-- window action
hl.bind("SUPER + return", hl.dsp.layout("swapwithmaster"))
hl.bind("SUPER + K", hl.dsp.layout("cycleprev"))
hl.bind("SUPER + J", hl.dsp.layout("cyclenext"))
hl.bind("SUPER + left", hl.dsp.layout("cycleprev"))
hl.bind("SUPER + right", hl.dsp.layout("cyclenext"))
hl.bind("SUPER + up", hl.dsp.layout("cycleprev"))
hl.bind("SUPER + down", hl.dsp.layout("cyclenext"))
-- goto number
smw.setup({ workspace_count = 5 })
hl.bind("SUPER + 1", smw.workspace("1"))
hl.bind("SUPER + 2", smw.workspace("2"))
hl.bind("SUPER + 3", smw.workspace("3"))
hl.bind("SUPER + 4", smw.workspace("4"))
hl.bind("SUPER + 5", smw.workspace("5"))
hl.bind("SUPER + 0", hl.dsp.workspace.toggle_special("special01"))
hl.bind("SUPER + 9", hl.dsp.workspace.toggle_special("special02"))
hl.bind("SUPER + 8", hl.dsp.workspace.toggle_special("special03"))
-- move to number
hl.bind("SUPER + CTRL + 1", smw.move_to_workspace("1"))
hl.bind("SUPER + CTRL + 2", smw.move_to_workspace("2"))
hl.bind("SUPER + CTRL + 3", smw.move_to_workspace("3"))
hl.bind("SUPER + CTRL + 4", smw.move_to_workspace("4"))
hl.bind("SUPER + CTRL + 5", smw.move_to_workspace("5"))
hl.bind("SUPER + CTRL + 0", hl.dsp.window.move({ workspace = "special:special01" }))
hl.bind("SUPER + CTRL + 9", hl.dsp.window.move({ workspace = "special:special02" }))
hl.bind("SUPER + CTRL + 8", hl.dsp.window.move({ workspace = "special:special03" }))
-- show workspace grid
hl.bind("SUPER + tab", hl.dsp.exec_cmd("dms ipc call hypr toggleOverview"))
-- audio action
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("dms ipc call audio mute"))
hl.bind("XF86AudioMicMute", hl.dsp.exec_cmd("dms ipc call audio micmute"))
hl.bind("CTRL + F1", hl.dsp.exec_cmd("dms ipc call audio mute"), { repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("dms ipc call audio decrement 2"), { repeating = true })
hl.bind("CTRL + F2", hl.dsp.exec_cmd("dms ipc call audio decrement 2"), { repeating = true })
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("dms ipc call audio increment 2"), { repeating = true })
hl.bind("CTRL + F3", hl.dsp.exec_cmd("dms ipc call audio increment 2"), { repeating = true })
-- brightness action
hl.bind("XF86MonBrightnessUp", hl.dsp.exec_cmd("dms ipc call brightness increment 5 ''"), { repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("dms ipc call brightness decrement 5 ''"), { repeating = true })
-- screenshot
hl.bind("print", hl.dsp.exec_cmd("screenshot copy output"))
hl.bind("SUPER + SHIFT + S", hl.dsp.exec_cmd("screenshot copysave area $HOME/Screenshots"))
-- music
hl.bind("XF86AudioPlay", hl.dsp.exec_cmd("dms ipc call mpris playPause"))
hl.bind("XF86AudioPrev", hl.dsp.exec_cmd("dms ipc call mpris previous"))
hl.bind("XF86AudioNext", hl.dsp.exec_cmd("dms ipc call mpris next"))
hl.bind("CTRL + F4", hl.dsp.exec_cmd("bash $HOME/.local/share/scripts/user/toggle-waylyrics"))
hl.bind("CTRL + F5", hl.dsp.exec_cmd("dms ipc call mpris previous"))
hl.bind("CTRL + F6", hl.dsp.exec_cmd("dms ipc call mpris next"))
hl.bind("CTRL + F7", hl.dsp.exec_cmd("dms ipc call mpris playPause"))
-- calculator
hl.bind("XF86Calculator", hl.dsp.exec_cmd("kitty python"))
-- color picker
hl.bind("XF86Favorites", hl.dsp.exec_cmd("bash $HOME/.local/share/scripts/user/pick-color"))

-- window rules
-- float
hl.window_rule({ match = { float = true }, border_size = 0 })
-- editor
hl.window_rule({ match = { class = "(.*)(kitty)(.*)$" }, opacity = 0.95 })
-- waylyrics
hl.window_rule({
  match = { class = "(.*)(waylyrics)(.*)$" },
  float = true,
  no_focus = true,
  pin = true,
  size = { 1000, 140 },
  move = { 220, 750 },
})
