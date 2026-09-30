-----------------
---- SOURCES ----
-----------------

require("colors")
local home = os.getenv("HOME")
local ok, palette = pcall(dofile, home .. "/.config/hypr/colors.lua")
if not ok or type(palette) ~= "table" then palette = {} end

------------------
---- MONITORS ----
------------------

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
-- local browser     = "helium-browser"
local browser     = "firefox"
local fileManager = "thunar"
local menu        = "rofi -show drun"

-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
    hl.exec_cmd("systemctl --user start hyprpolkitagent")
    hl.exec_cmd("awww-daemon")
    hl.exec_cmd("hypridle")
    hl.exec_cmd("sleep 1 && ~/.local/bin/system-info")
end)

-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

hl.env("XCURSOR_THEME", "Bibata-Modern-Classic")
hl.env("XCURSOR_SIZE", "20")
hl.env("HYPRCURSOR_SIZE", "20")

-----------------------
---- LOOK AND FEEL ----
-----------------------

hl.config({
    general = {
        gaps_in     = 3,
        gaps_out    = 6,
        border_size = 1,

        col = {
            active_border   = palette.accent_bright,
            inactive_border = "rgba(00000000)",
        },


        layout           = "dwindle",
        resize_on_border = false,
        allow_tearing    = false,
    },

    decoration = {
        rounding       = 3,
        rounding_power = 2,
        active_opacity = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled = false,
        },

        blur = {
            enabled  = true,
            size     = 3,
            passes   = 3,
            vibrancy = 0.5,
            new_optimizations = true,
        },
    },

    animations = {
        enabled = true,
    },

    misc = {
        force_default_wallpaper = 0,
        disable_hyprland_logo   = true,
    },
})

--------------------
---- ANIMATIONS ----
--------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy",           { type = "spring", mass = 1, stiffness = 450, dampening = 40 })

hl.animation({ leaf = "global",        enabled = true,  speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true,  speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true,  speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 4.1,  spring = "easy",         style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.49, bezier = "linear",       style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true,  speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true,  speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true,  speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 7,    bezier = "quick" })

------------------
---- LAYOUTS ----
------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
        column_width = 0.5,
        direction = "right",
    },
})

hl.workspace_rule({ workspace = 5, layout = "scrolling" })

---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout    = "us",
        follow_mouse = 1,
        sensitivity  = 0,
        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
  fingers = 3,
  direction = "horizontal",
  action = "workspace",
})

hl.gesture({
  fingers = 4,
  direction = "down",
  action = "close",
})

--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------

hl.window_rule({
    name = "suppress-maximize",
    match = { class = ".*" },
    suppress_event = "maximize",
})

hl.window_rule({
    name = "opacity-brave",
    match = { class = "^(brave-browser)$" },
    opacity = "0.95 0.95 override",
})

hl.window_rule({
    name = "opacity-thunar",
    match = { class = "^(thunar)$" },
    opacity = "0.84 0.84",
})

hl.window_rule({
    name = "opacity-helium",
    match = { class = "^(helium)$" },
    opacity = "0.95 0.95 override",
})

hl.window_rule({
    name = "opacity-firefox",
    match = { class = "^(firefox)$" },
    opacity = "0.95 0.95",
})

hl.window_rule({
    name = "opacity-zen",
    match = { class = "^(zen)$" },
    opacity = "0.95 0.95",
})

---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

-- Workspaces 1-10

for i = 1, 10 do
    local k = (i == 10) and "0" or tostring(i)
    local key = i % 10
    
    hl.bind(mainMod .. " + " .. k,         hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + " .. k,         hl.dsp.exec_cmd("~/.config/scripts/workspace.sh"))
    
    hl.bind(mainMod .. " + SHIFT + " .. k, hl.dsp.window.move({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. k, hl.dsp.exec_cmd("~/.config/scripts/workspace.sh"))
end

-- Focus/Move with HJKL
local dirs = { H = "left", L = "right", K = "up", J = "down" }
for key, dir in pairs(dirs) do
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ direction = dir }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ direction = dir }))
end

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + SHIFT + TAB", hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + R", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + period", hl.dsp.layout("move +col"))
hl.bind(mainMod .. " + comma", hl.dsp.layout("move -col"))
hl.bind(mainMod .. " + SHIFT + period", hl.dsp.layout("swapcol r"))
hl.bind(mainMod .. " + SHIFT + comma", hl.dsp.layout("swapcol l"))

-- Multimedia / OSD Scripts
local osd = "~/.config/scripts/sys-osd.sh "
hl.bind("F2", hl.dsp.exec_cmd(osd .. "bright_down"), { locked = true, repeating = true })
hl.bind("F3", hl.dsp.exec_cmd(osd .. "bright_up"),   { locked = true, repeating = true })
hl.bind("F6", hl.dsp.exec_cmd(osd .. "vol_mute"),    { locked = true, repeating = true })
hl.bind("F7", hl.dsp.exec_cmd(osd .. "vol_down"),    { locked = true, repeating = true })
hl.bind("F8", hl.dsp.exec_cmd(osd .. "vol_up"),      { locked = true, repeating = true })
hl.bind("F9", hl.dsp.exec_cmd(osd .. "prev"),        { locked = true })
hl.bind("F10", hl.dsp.exec_cmd(osd .. "play_pause"), { locked = true })
hl.bind("F11", hl.dsp.exec_cmd(osd .. "next"),       { locked = true })

-- Custom Scripts
hl.bind(mainMod .. " + W",      hl.dsp.exec_cmd("~/.local/bin/walls"))
hl.bind(mainMod .. " + P",      hl.dsp.exec_cmd("~/.local/bin/palette"))
hl.bind(mainMod .. " + N",      hl.dsp.exec_cmd("~/.local/bin/night-mode"))
hl.bind(mainMod .. " + I",      hl.dsp.exec_cmd("~/.local/bin/system-info"))
hl.bind(mainMod .. " + C",      hl.dsp.exec_cmd("~/.local/bin/color-scheme"))

-- Basic Binds
hl.bind(" + PRINT", hl.dsp.exec_cmd('grim ~/Pictures/screenshot_$(date +%s).png  && notify-send "screenshot" "saved to Pictures"'))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd('grim -g "$(slurp)" ~/Pictures/screenshot_$(date +%s).png && notify-send "screenshot" "saved to Pictures"'))
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + SHIFT + Y", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + U", hl.dsp.exec_cmd("loginctl lock-session"))
hl.bind(mainMod .. " + SHIFT + I", hl.dsp.exec_cmd("hyprlock & sleep 0.5 && systemctl suspend"))
hl.bind(mainMod .. " + SHIFT + O", hl.dsp.exec_cmd("systemctl reboot"))
hl.bind(mainMod .. " + SHIFT + P", hl.dsp.exec_cmd("systemctl poweroff"))

hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("kitty -e yazi"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + G", hl.dsp.layout("pseudo"))
hl.bind(mainMod .. " + T", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
-- hl.bind(mainMod .. " + SHIFT + CONTROL + B", hl.dsp.exec_cmd("brave --incognito"))
-- hl.bind(mainMod .. " + SHIFT + CONTROL + B", hl.dsp.exec_cmd("helium-browser --incognito"))
hl.bind(mainMod .. " + SHIFT + CONTROL + B", hl.dsp.exec_cmd("firefox --private-window"))
-- hl.bind(mainMod .. " + SHIFT + CONTROL + B", hl.dsp.exec_cmd("zen-browser --private-window"))
hl.bind(mainMod .. " + SHIFT + B", hl.dsp.exec_cmd("killall waybar || waybar"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("kitty -e impala"))
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("ani-cli --rofi"))

--------------
---- MISC ----
--------------

