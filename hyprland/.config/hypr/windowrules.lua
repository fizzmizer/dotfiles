hl.window_rule({ match = { class = "firefox" }, workspace = "3 silent" })
hl.window_rule({ match = { class = "org.mozilla.Thunderbird" }, workspace = "2 silent" })
hl.window_rule({ match = { class = "mpv" }, float = true })
hl.window_rule({ match = { title = "Picture-in-Picture" }, float = true })
hl.window_rule({ match = { title = "Open File.*" }, size = {"monitor_w * 0.5", "monitor_h * 0.5"}, center = true })
hl.window_rule({ match = { title = "File Upload.*" }, size = {"monitor_w * 0.5", "monitor_h * 0.5"}, center = true })
hl.window_rule({ match = { title = "Enter name.*" }, size = {"monitor_w * 0.5", "monitor_h * 0.5"}, center = true })
hl.window_rule({ match = { title = "Save As.*" }, size = {"monitor_w * 0.5", "monitor_h * 0.5"}, center = true })

local suppressMaximizeRule = hl.window_rule({
    -- Ignore maximize requests from all apps. You'll probably like this.
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
-- suppressMaximizeRule:set_enabled(false)

hl.window_rule({
    -- Fix some dragging issues with XWayland
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})

-- Layer rules also return a handle.
-- local overlayLayerRule = hl.layer_rule({
--     name  = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)

-- Hyprland-run windowrule
hl.window_rule({
    name  = "move-hyprland-run",
    match = { class = "hyprland-run" },
    move  = "20 monitor_h-120",
    float = true,
})
