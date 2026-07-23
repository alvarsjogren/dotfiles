-- =============================================================================
-- Hyprland config (Lua — requires Hyprland >= 0.55)
-- =============================================================================
-- Ported from the legacy hyprland.conf (hyprlang), which is deprecated upstream
-- and slated for removal. hyprland.conf is kept in the repo as a rollback: it is
-- only read when no hyprland.lua exists, so deleting this file restores it.
--
-- API reference: /usr/share/hypr/stubs/hl.meta.lua  (point lua-ls at it for
-- completion + type checking), and https://wiki.hypr.land/Configuring/Start/

-- =============================================================================
-- Host-specific config (GPU env vars, monitor layout)
-- =============================================================================
-- host.lua is a local symlink -> hosts/laptop.lua or hosts/pc.lua,
-- created once per machine. Not tracked by git (see .gitignore).
require("host")


-- =============================================================================
-- Autostart
-- =============================================================================
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
    hl.exec_cmd("nm-applet --indicator")
    hl.exec_cmd([[sh -c 'awww-daemon --no-cache & sleep 1; awww img ~/Pictures/wallpapers/wallhaven-polllj.jpg --transition-type fade']])
end)


-- =============================================================================
-- Environment variables
-- =============================================================================
hl.env("XCURSOR_SIZE", "24")
hl.env("XCURSOR_THEME", "Bibata-Modern-Ice")
hl.env("QT_QPA_PLATFORMTHEME", "qt5ct")
hl.env("GTK_THEME", "Adwaita:dark")
-- Run Firefox as a native Wayland client so it gets real touchpad swipe
-- gesture events (needed for two-finger back/forward navigation)
hl.env("MOZ_ENABLE_WAYLAND", "1")


-- =============================================================================
-- Input / General / Decoration / Layout / Misc
-- =============================================================================
hl.config({
    input = {
        kb_layout  = "se",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity  = 0,

        touchpad = {
            natural_scroll = true,
        },
    },

    general = {
        gaps_in     = 5,
        gaps_out    = 10,
        border_size = 2,

        col = {
            active_border   = { colors = { "rgba(dfac70ee)", "rgba(384778ee)" }, angle = 45 },
            inactive_border = "rgba(222441aa)",
        },

        layout = "dwindle",
    },

    decoration = {
        rounding = 10,

        blur = {
            enabled = true,
            size    = 3,
            passes  = 1,
        },

        shadow = {
            enabled      = true,
            range        = 8,
            render_power = 3,
            color        = "rgba(02050eee)",
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    misc = {
        middle_click_paste       = false,
        disable_hyprland_logo    = true,
        disable_splash_rendering = true,
        background_color         = 0x040A1A,
    },
})


-- =============================================================================
-- Animations
-- =============================================================================
hl.curve("myBezier",    { type = "bezier", points = { { 0.05, 0.9 }, { 0.1,  1.05 } } })
hl.curve("smoothSlide", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1.0  } } })

hl.animation({ leaf = "windows",     enabled = true, speed = 7,  bezier = "myBezier" })
hl.animation({ leaf = "windowsOut",  enabled = true, speed = 7,  bezier = "default",     style = "popin 80%" })
hl.animation({ leaf = "border",      enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "borderangle", enabled = true, speed = 8,  bezier = "default" })
hl.animation({ leaf = "fade",        enabled = true, speed = 7,  bezier = "default" })
hl.animation({ leaf = "workspaces",  enabled = true, speed = 4,  bezier = "smoothSlide", style = "slide" })


-- =============================================================================
-- Gestures
-- =============================================================================
-- 3-finger horizontal swipe to change workspace
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


-- =============================================================================
-- Keybindings
-- =============================================================================
local mainMod = "SUPER"

-- Applications
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("kitty"))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + E", hl.dsp.exit())
-- Lock is on SHIFT + L: plain SUPER + L collides with the vim-style
-- "focus right" bind below, which is also SUPER + l.
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("hyprlock"))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd("nemo"))
hl.bind(mainMod .. " + Y", hl.dsp.exec_cmd("kitty --class yazi -e yazi"))
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("wofi --show drun"))

-- Window management
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + S", hl.dsp.layout("togglesplit"))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen())

-- Move focus
hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))

-- Move focus with vim keys
hl.bind(mainMod .. " + h", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + l", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + k", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + j", hl.dsp.focus({ direction = "down" }))

-- Workspaces (SUPER + 1..0) / move active window to workspace (+ SHIFT)
for i = 1, 10 do
    local key = i % 10 -- 10 maps to key 0
    hl.bind(mainMod .. " + " .. key,             hl.dsp.focus({ workspace = i }))
    hl.bind(mainMod .. " + SHIFT + " .. key,     hl.dsp.window.move({ workspace = i }))
end

-- Scroll through workspaces
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- Move/resize with mouse
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Screenshots
hl.bind("Print",         hl.dsp.exec_cmd([[grim -g "$(slurp)" - | wl-copy]]))
hl.bind("SHIFT + Print", hl.dsp.exec_cmd("grim - | wl-copy"))

-- Audio
-- locked   = also fires while the lockscreen is up
-- repeating = holding the key keeps stepping the volume
hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { locked = true, repeating = true })
-- no repeat on mute — holding it would just flap the toggle
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"), { locked = true })

-- Brightness
hl.bind("XF86MonBrightnessUp",   hl.dsp.exec_cmd("brightnessctl set +5%"), { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown", hl.dsp.exec_cmd("brightnessctl set 5%-"), { locked = true, repeating = true })
