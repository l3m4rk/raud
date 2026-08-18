-- raud Hyrpland configuration

local terminal = "ghostty"
local launcher = "wofi --show drun"
local mainMod = "SUPER"

-- Monitor
hl.monitor({
    output = "",
    mode = "preffered",
    position = "auto",
    scale = "auto",
})

-- Environment
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

-- Autostart
hl.on("hyprland.start", function()
    hl.exec_cmd("waybar")
    hl.exec_cmd("mako")
    hl.exec_cmd("systemctl --user start hyprpolkitagent.service")
end)

-- General configuration
hl.config({
    general = {
        gaps_in = 4,
        gaps_out = 8,
        border_size = 2,
        layout = "dwindle",
    },

    decoration = {
        rounding = 8,
    },

    animations = {
        enabled = true,
    },

    input = {
        kb_layout = "us",
        follow_mouse = 1,

        touchpad = {
            natural_scroll = true,
        },
    },

    misc = {
        disable_hyprland_logo = true,
        force_default_wallpaper = 0,
    },
})

-- Applications
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + D", hl.dsp.exec_cmd(launcher))

-- Window management
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

-- Workspaces
for i = 1, 5 do
    hl.bind(
        mainMod .. " + " .. i,
        hl.dsp.focus({ workspace = i })
    )

    hl.bind(
        mainMod .. " + SHIFT + " .. i,
        hl.dsp.window.move({ workspace = i })
    )
end