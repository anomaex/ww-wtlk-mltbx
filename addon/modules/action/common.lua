--
-- modules\action\common.lua
--
local _, store = ...
store.modules = store.modules or {}
store.modules.action = store.modules.action or {}
store.modules.action.common = {}

local C = store.modules.action.common
local cast_frame = nil
local colors = store.config.COLORS


function C.init()
    if cast_frame then return end
    cast_frame = store.core.create_frame("action_cast_or_eatdrink", 15)
    cast_frame:set_color(colors.STATE_NON_CAST)

    local follow_mac_body =  "/wwwtlkmltbx [mod:ctrl] follow_stop; [mod:alt] follow_start; follow_pause"
    local follow_mac_name = store.core.create_macro("follow", follow_mac_body, true)
    if follow_mac_name then
        store.core.assign_macro_to_bar_slot(follow_mac_name, 61)
    end

    local quit_mac_body = "/wwwtlkmltbx [mod:alt] quit"
    -- Add here logic for find eat or drink in inventory and put on ActionBar for hotkey
end


local function check_cast()
    local name = UnitCastingInfo("player")

    if not name then
        name = UnitChannelInfo("player")
    end

    if name then
        store.state.is_casting = true
    else
        store.state.is_casting = false
    end
end


local function check_eat_drink()
    local flag = UnitBuff("player", "Food")

    if not flag then
        flag = UnitBuff("player", "Drink")
    end

    store.state.is_eatdrink = flag
end


function C.update()
    check_cast()
    check_eat_drink()

    if cast_frame then
        if store.state.is_casting or store.state.is_eatdrink then
            cast_frame:set_color(colors.STATE_CAST)
        elseif not store.state.is_casting and not store.state.is_eatdrink then
            cast_frame:set_color(colors.STATE_NON_CAST)
        end
    end
end

