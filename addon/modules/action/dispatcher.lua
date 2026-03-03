--
-- modules\action\dispatcher.lua
--
local _, store = ...
store.modules = store.modules or {}
store.modules.action = store.modules.action or {}


local current_profile = nil


local function init()
    local name = UnitName("player")
    local class_spec = store.config.secret.name_class_spec[name]
    if class_spec then
        local profile = store.modules.action.profiles[class_spec]
        if profile then
           current_profile = profile
        end
    end
end


function store.modules.action.start()
    init()
    if current_profile then
        local TIME_STEP = 0.1
        local totalElapsed = 0

        local frame = store.core.create_event_frame()

        frame:SetScript("OnUpdate", function(self, elapsed)
            totalElapsed = totalElapsed + elapsed
            if totalElapsed >= TIME_STEP then
                current_profile.exec()
            end
        end)
    end
end
