-- =============================================================================
-- Host: laptop (Lenovo IdeaPad Slim 3 14IAH8, Intel Alder Lake-P iGPU)
-- =============================================================================
hl.env("LIBVA_DRIVER_NAME", "iHD")
hl.env("XDG_SESSION_TYPE", "wayland")

-- Monitor configuration
-- Use `hyprctl monitors` to see available monitors
hl.monitor({
    output   = "eDP-1",
    mode     = "preferred",
    position = "auto",
    scale    = 1,
})

-- Idle / lock — laptop only for now (battery-powered, has a lid).
-- Dim at 2.5min, lock at 5min, suspend at 10min. See hypridle.conf.
hl.on("hyprland.start", function()
    hl.exec_cmd("hypridle")
end)
