--
-- modules\action\dispatcher.lua
--
local _, store = ...
store.modules = store.modules or {}
store.modules.action = store.modules.action or {}

local A = store.modules.action
local current_profile = nil
local TIME_STEP = 0.1
local total_elapsed = 0
local action_update_frame = nil


function A.init()
    local name = UnitName("player")

    local class_spec = store.config.SECRET.NAME_CLASS_SPEC[name]
    if not class_spec then return end

    local profile = store.modules.action.profiles[class_spec]
    if not profile then return end

    current_profile = profile

    if not action_update_frame then
        action_update_frame = store.core.create_event_frame("action")
    end

    store.modules.action.common.init()
    current_profile.init()
end


function A.start()
    if not current_profile or not action_update_frame then return end

    action_update_frame:SetScript("OnUpdate", function(self, elapsed)
        total_elapsed = total_elapsed + elapsed

        if total_elapsed >= TIME_STEP then
            store.modules.action.common.update()
            current_profile.update()

            total_elapsed = total_elapsed - TIME_STEP
        end
    end)
end


function A.stop()
    if not action_update_frame then return end
    action_update_frame:SetScript("OnUpdate", nil)
end
