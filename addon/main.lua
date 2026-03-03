--
-- main.lua
--
local _, store = ...

local is_fully_loaded = false


local function init()
    local in_game_frame = store.core.create_frame("InWorld")
    in_game_frame:set_color(0, 0, 255)

    store.core.set_bindings(store.config.binding_profile)

    store.core.remove_all_macros()

    store.modules.action.init()
end


local function start()
    store.modules.action.start()
end


local function main()
    if is_fully_loaded then return end

    local main_event_frame = store.core.create_event_frame("main")

    main_event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    
    main_event_frame:SetScript("OnEvent", function(_, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            init()
            start()
        end
    end)

    is_fully_loaded = true
end


main()
