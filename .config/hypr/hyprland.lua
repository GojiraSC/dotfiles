---@diagnostic disable: undefined-global
------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "DP-1",
    mode     = "2560x1440@165",
    position = "3440x0",
    scale    = "1",
    bitdepth = 10,
    cm       = "hdr",
})

hl.monitor({
   output    = "DP-2",
   mode      = "3440x1440@144",
   position  = "0x0",
   scale     = "1",
   bitdepth  = 10,
   cm        = "hdr",
   sdrbrightness = 2.0,
   sdrsaturation = 1.20,
})


---------------------
---- MY PROGRAMS ----
---------------------

-- Set programs that you use
local terminal    = "kitty"
local fileManager = "kitty -e yazi"
local menu        = "~/.config/rofi/launchers/type-6/launcher.sh"


-------------------
---- AUTOSTART ----
-------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notifications daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
hl.on("hyprland.start", function()
   hl.exec_cmd("waybar & librewolf")
   hl.exec_cmd("awww-daemon")
   hl.exec_cmd("sleep 2 && awww img -o DP-1 $HOME/Pictures/Wallpapers/wallhaven-rrxrl1.png")
   hl.exec_cmd("sleep 2 && awww img -o DP-2 $HOME/Pictures/Wallpapers/wallhaven-1jj8l3.jpg")
   hl.exec_cmd("hyprctl setcursor Bibata-Modern-Ice 24")
   hl.exec_cmd("systemctl --user start hyprpolkitagent")
   hl.exec_cmd("mako")
   hl.exec_cmd("wl-paste --type text --watch cliphist store")
   hl.exec_cmd("wl-paste --type image --watch cliphist store")
end)


-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_PATH", "/usr/share/icons:~/.local/share/icons")


-----------------------
----- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in    = 5,
        gaps_out   = 20,
        border_size = 2,
        col = {
            active_border   = { colors = {"rgba(7c8f8fff)"}, angle = 45 },
            inactive_border = "rgba(3c3836aa)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding       = 1,
        rounding_power = 2,
        active_opacity   = 1.0,
        inactive_opacity = 1.0,
        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },
        blur = {
            enabled  = true,
            size     = 3,
            passes   = 1,
            vibrancy = 0.1696,
        },
    },
})

-- Default curves and animations, see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
-- Curves
hl.curve("ease",     { type = "bezier", points = { {0.25, 0.1}, {0.25, 1.0} } })
hl.curve("overshot", { type = "bezier", points = { {0.13, 0.99}, {0.29, 1.05} } })
hl.curve("gnomed",   { type = "bezier", points = { {0, 0.85}, {0.3, 1} } })

-- Animations
hl.animation({ leaf = "windows",     enabled = true, speed = 5, bezier = "overshot", style = "gnomed" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 5, bezier = "ease",     style = "slide bottom" })
hl.animation({ leaf = "windowsMove", enabled = true, speed = 5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layers",      enabled = true, speed = 5, bezier = "ease",     style = "gnomed" })
hl.animation({ leaf = "fade",        enabled = true, speed = 3, bezier = "ease" })
hl.animation({ leaf = "border",      enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 5, bezier = "overshot", style = "slide" })

-- Ref https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/
-- "Smart gaps" / "No gaps when only"
-- uncomment all if you wish to use that.
-- hl.workspace_rule({ workspace = "w[tv1]", gaps_out = 0, gaps_in = 0 })
-- hl.workspace_rule({ workspace = "f[1]",   gaps_out = 0, gaps_in = 0 })
-- hl.window_rule({
--     name  = "no-gaps-wtv1",
--     match = { float = false, workspace = "w[tv1]" },
--     border_size = 0,
--     rounding    = 0,
-- })
-- hl.window_rule({
--     name  = "no-gaps-f1",
--     match = { float = false, workspace = "f[1]" },
--     border_size = 0,
--     rounding    = 0,
-- })

-- See https://wiki.hypr.land/Configuring/Layouts/Dwindle-Layout/ for more
hl.config({
    dwindle = {
        preserve_split = true, -- You probably want this
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "master",
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Scrolling-Layout/ for more
hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})

----------------
----  MISC  ----
----------------

hl.config({
    misc = {
        force_default_wallpaper = 0,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        numlock_by_default = true,
        follow_mouse       = 1,
        mouse_refocus      = false,
        sensitivity        = 0,

        repeat_delay = 110,
        repeat_rate  = 115,

        touchpad = {
            natural_scroll = false,
        },
    },
})

-- Gestures
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })

-- Per-device config
hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER" -- Sets "Windows" key as main modifier

-- Example binds, see https://wiki.hypr.land/Configuring/Basics/Binds/ for more
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))    -- dwindle only
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + N", hl.dsp.exec_cmd("librewolf"))                  -- Main Browser
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("qutebrowser"))        -- Backup Browser
hl.bind(mainMod .. " + L", hl.dsp.exec_cmd("libreoffice"))                -- Word,Excel,PowerPoint Processor
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty nvim"))                 -- Terminal-based Editor
hl.bind(mainMod .. " + K", hl.dsp.exec_cmd("kicad"))
hl.bind(mainMod .. " + H", hl.dsp.exec_cmd("qview"))                      -- Image Viewer
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd("obs"))
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("equibop"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("steam"))
hl.bind(mainMod .. " + Z", hl.dsp.exec_cmd("zoom"))
hl.bind(mainMod .. " + U", hl.dsp.exec_cmd("usenti"))
hl.bind(mainMod .. " + comma", hl.dsp.exec_cmd("visualboyadvance-m"))     -- GBA Emulator
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.exec_cmd("mgba-qt"))        -- Backup GBA Emulator
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("dolphin-emu"))           -- GC+WII Emulator
hl.bind(mainMod .. " + slash", hl.dsp.exec_cmd("snes9x-gtk"))             -- SNES Emulator
hl.bind(mainMod .. " + BackSpace", hl.dsp.exec_cmd("ares"))               -- N64 Emulator
hl.bind(mainMod .. " + apostrophe", hl.dsp.exec_cmd("fceux"))             -- NES Emulator
hl.bind(mainMod .. " + semicolon", hl.dsp.exec_cmd("desmume"))            -- DS Emulator
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("dbeaver"))
hl.bind(mainMod .. " + backslash", hl.dsp.exec_cmd("slack"))
hl.bind(mainMod .. " + bracketleft", hl.dsp.exec_cmd("flips"))
hl.bind(mainMod .. " + bracketright", hl.dsp.exec_cmd("/home/gojira_96/.local/bin/resolve-launch"))      -- Davinci Resolve
hl.bind(mainMod .. " + R",            hl.dsp.exec_cmd("/usr/lib/rstudio/rstudio"))
hl.bind(mainMod .. " + Minus", hl.dsp.exec_cmd("pavucontrol"))            -- Volume Management


local ALT = "ALT"
hl.bind(ALT .. " + V",         hl.dsp.exec_cmd("kitty cava"))           -- Audio Visualizer
hl.bind(ALT .. " + BackSpace", hl.dsp.exec_cmd("kitty btop"))           -- Terminal-based Resource Management
hl.bind(ALT .. " + Pause",     hl.dsp.exec_cmd("kitty cmatrix"))
hl.bind(ALT .. " + Insert",    hl.dsp.exec_cmd("kitty peaclock"))        -- Clock
hl.bind(ALT .. " + Page_Up",   hl.dsp.exec_cmd("kitty pipes-rs"))
hl.bind(ALT .. " + E",         hl.dsp.exec_cmd("kitty vim"))            -- Backup Editor
hl.bind(ALT .. " + C",         hl.dsp.exec_cmd("kitty calcurse"))       -- Calendar
hl.bind(ALT .. " + L",         hl.dsp.exec_cmd("kitty lazygit"))
hl.bind(ALT .. " + T",         hl.dsp.exec_cmd("kitty tmux"))
hl.bind(ALT .. " + equal",     hl.dsp.exec_cmd("kitty calc"))           -- Calculator
hl.bind(ALT .. " + P", hl.dsp.exec_cmd("kitty ncspot"))                 -- TUI Spotify
hl.bind(ALT .. " + R", hl.dsp.exec_cmd("kitty rmpc"))                   -- TUI Music Player
hl.bind(ALT .. " + Minus", hl.dsp.exec_cmd("mpv --player-operation-mode=pseudo-gui"))     -- mp4 player


-- Neovim env
local home = os.getenv("HOME")
local path = os.getenv("PATH")
hl.env("PATH", home .. "/.local/share/bob/nvim-bin:" .. home .. "/.cargo/bin:" .. path)

-- QT Stuff
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")


-- Select area → annotate in Swappy → save
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd('bash -c \'grim -g "$(slurp)" - | swappy -f - -o "$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"\''))

-- Fullscreen → save straight away
hl.bind(ALT .. " + P", hl.dsp.exec_cmd('bash -c \'grim "$HOME/Pictures/Screenshots/screenshot-$(date +%Y-%m-%d_%H-%M-%S).png"\''))

-- Select area → copy to clipboard (no file)
hl.bind(mainMod .. " + C", hl.dsp.exec_cmd('bash -c \'grim -g "$(slurp)" - | wl-copy\''))

-- Power and Printer Controls
hl.bind(mainMod .. " + End", hl.dsp.exec_cmd("wlogout -b 4 --margin 200 -T 550 -B 550"))
hl.bind(mainMod .. " + Page_Up", hl.dsp.exec_cmd("system-config-printer"))

-- Window togglefloating + resize + center
hl.bind(mainMod .. " + SHIFT + space", function()
    hl.dispatch(hl.dsp.window.float({ action = "toggle" }))
    hl.dispatch(hl.dsp.window.resize({ x = 1200, y = 1100, exact = true }))
    hl.dispatch(hl.dsp.window.center())
end)

-- Move focus with mainMod + arrow keys
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Switch workspaces with mainMod + [0-9]
-- Move active window to a workspace with mainMod + SHIFT + [0-9]
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i}))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Swapping Windows Around
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.swap({ direction = "left" }))
hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.swap({ direction = "right" }))
hl.bind(mainMod .. " + SHIFT + up",    hl.dsp.window.swap({ direction = "up" }))
hl.bind(mainMod .. " + SHIFT + down",  hl.dsp.window.swap({ direction = "down" }))
hl.bind("ALT + Tab", hl.dsp.window.cycle_next())

-- Example special workspace (scratchpad)
hl.bind(mainMod .. " + ALT + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize windows with mainMod + LMB/RMB and dragging
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Requires playerctl
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

-- Example window rules that are useful

-- Suppress maximize events
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix XWayland dragging issues
hl.window_rule({
    name     = "fix-xwayland-drags",
    match    = { class = "^$", title = "^$", xwayland = true, float = true, fullscreen = false, pin = false },
    no_focus = true,
})

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})

-- nmtui float
hl.window_rule({
    name  = "nmtui-float",
    match = { class = "floating" },
    float = true,
    size  = "800 600",
    center = true,
})
