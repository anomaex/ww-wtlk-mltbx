--
-- main.lua
--
local _, store = ...

local ingame_frame = nil
local is_fully_loaded = false


local function init()
    store.core.set_bindings(store.config.binding_profile)
    store.core.remove_all_macros()
    store.core.visible_action_bars(true); -- if action bar is disabled, then enable all

    store.modules.action.init()
    store.modules.follow.init()
end


local function start()
    store.modules.action.start()
    store.modules.follow.start()
end


local function main()
    if is_fully_loaded then return end
    if ingame_frame then return end

    ingame_frame = store.core.create_frame("inworld")
    ingame_frame:set_color(store.config.COLORS.BLUE)

    ingame_frame:RegisterEvent("PLAYER_ENTERING_WORLD")

    ingame_frame:SetScript("OnEvent", function(_, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            init()
            start()
        end
    end)

    is_fully_loaded = true
end


main()
