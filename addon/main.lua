--
-- main.lua
--
local _, store = ...


local function init()
    local in_game_frame = store.core.create_frame("InWorld")
    in_game_frame:set_color(0, 0, 255)

    store.core.set_bindings(store.config.binding_profile)

    store.core.remove_all_macros()

    store.modules.action.start()
end


local function start()

end


local function main()
    local main_event_frame = CreateFrame("Frame")
    main_event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    main_event_frame:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            init()
            start()
        end
    end)
end


main()
