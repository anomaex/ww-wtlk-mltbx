local addon_name, store = ...


local function start()
    local frame = store.utils.helper.create_frame("BotPixel", nil, nil, nil, nil, "TOPLEFT")
    store.utils.helper.set_color_to_frame(0, 0, 1, frame)
end


local function warmup()
end


local function init()
end


local function main()
    local main_event_frame = CreateFrame("Frame")
    main_event_frame:RegisterEvent("PLAYER_ENTERING_WORLD")
    main_event_frame:SetScript("OnEvent", function(self, event, ...)
        if event == "PLAYER_ENTERING_WORLD" then
            init()
            warmup()
            start()
        end
    end)
end


main()
