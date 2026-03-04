--
-- modules\follow.lua
--
local _, store = ...
store.modules = store.modules or {}
store.modules.follow = {}

local F = store.modules.follow
local follow_frame = nil
local TIME_STEP = 0.1
local total_elapsed = 0


function F.init()
    if follow_frame then return end
    follow_frame = store.core.create_event_frame("follow")
end


local function follow()
    if not store.state.is_follow then return end
    FollowUnit("Mieko")
    local unit_name = store.config.SECRET.MAIN_CHAR_NAME
    if UnitExists(unit_name) then
        if not UnitIsDeadOrGhost(unit_name) then
            if not UnitIsDeadOrGhost("player") then
                if not store.state.is_casting and not store.state.is_eatdrink then
                    --FollowUnit(unit_name)
                    return
                end
            end
        end
    end
    -- Stop follow can work only from AutoIt, we can't stop follow from scripts.
end


function F.start()
    if not follow_frame then return end

    follow_frame:SetScript("OnUpdate", function(self, elapsed)
        total_elapsed = total_elapsed + elapsed

        if total_elapsed >= TIME_STEP then
            follow()
            total_elapsed = total_elapsed - TIME_STEP
        end
    end)
end


store.modules.follow = F
