--
-- main.lua
--
local addon_name, store = ...
store.core = store.core or {}


local function init()
    local frame = store.core.create_frame("InWorld")
    frame:set_color(0, 0, 255)

    store.modules.bindings.init()
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
