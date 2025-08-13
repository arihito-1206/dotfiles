local wezterm = require("wezterm")
local act = wezterm.action

return {
    keys = {
        -- Pane
        { key = "|", mods = "LEADER", action = act.SplitHorizontal({ domain = "CurrentPaneDomain" }) },
        { key = "h", mods = "LEADER", action = act.ActivatePaneDirection("Left") },
        { key = "l", mods = "LEADER", action = act.ActivatePaneDirection("Right") },
        { key = "k", mods = "LEADER", action = act.ActivatePaneDirection("Up") },
        { key = "j", mods = "LEADER", action = act.ActivatePaneDirection("Down") },
    }
}
