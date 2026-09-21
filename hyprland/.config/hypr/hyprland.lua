------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "eDP-1",
    mode     = "1920x1200@60",
    position = "auto",
    scale    = 1,
})


-------------------
---- AUTOSTART ----
-------------------

hl.on("hyprland.start", function () 
--  hl.exec_cmd("$scriptPath/bg-battery-check.sh")
--  hl.exec_cmd("$scriptPath/resetxdgportal.sh") --reset XDPH for screenshare
  hl.exec_cmd("/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 &") -- authentication dialogue for GUI apps
  hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH
  hl.exec_cmd("dbus-update-activation-environment --systemd --all") -- for XDPH
  hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP") -- for XDPH
  hl.exec_cmd("waybar") -- launch the system bar
  hl.exec_cmd("blueman-applet") -- systray app for Bluetooth
  hl.exec_cmd("udiskie --no-automount --smart-tray") -- front-end that allows to manage removable media
  hl.exec_cmd("udiskie --smart-tray") -- front-end that allows to manage removable media
  hl.exec_cmd("= nm-applet --indicator") -- systray app for Network/Wifi
  hl.exec_cmd("dunst") -- start notification demon
  hl.exec_cmd("wl-paste --type text --watch cliphist store") -- clipboard store text data
  hl.exec_cmd("wl-paste --type image --watch cliphist store") -- clipboard store image data
  hl.exec_cmd("awww-daemon") -- start wallpaper daemon
end)


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- Refer to https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 5,

        border_size = 2,

        col = {
            --active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
            active_border   = { colors = {"rgba(fbb829ff)"} },
            inactive_border = "rgba(2e303eaa)",
        },

        -- Set to true to enable resizing windows by clicking and dragging on borders and gaps
        resize_on_border = false,

        -- Please see https://wiki.hypr.land/Configuring/Advanced-and-Cool/Tearing/ before you turn this on
        allow_tearing = false,

        layout = "master",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 5,

        -- Change transparency of focused and unfocused windows
        active_opacity   = 1.0,
        inactive_opacity = 0.9,

        shadow = {
            enabled      = false,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
            size      = 3,
            passes    = 1,
            vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})

-- See https://wiki.hypr.land/Configuring/Layouts/Master-Layout/ for more
hl.config({
    master = {
        new_status = "slave",
        mfact = 0.65,
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
        force_default_wallpaper = 1,    -- Set to 0 or 1 to disable the anime mascot wallpapers
        disable_hyprland_logo   = true, -- If true disables the random hyprland logo / anime girl background. :(
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "be",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,

        sensitivity = 0.2, -- -1.0 - 1.0, 0 means no modification.

        touchpad = {
            natural_scroll = true,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

-- Example per-device config
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Devices/ for more
-- hl.device({
--     name        = "epic-mouse-v1",
--     sensitivity = -0.5,
-- })


--------------------------------
---- WINDOWS AND WORKSPACES ----
--------------------------------


require("animations")
require("keybindings")
require("windowrules")
