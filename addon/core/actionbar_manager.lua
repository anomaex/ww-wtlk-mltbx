--
-- core\actionbar_manager.lua
--
local _, store = ...
store.core = store.core or {}


-- slot_id
-- 1 - 12, main bar, Main Action Bar
-- 25 - 36, right bar, MULTIACTIONBAR3
-- 37 - 48, second right bar, MULTIACTIONBAR4
-- 49 - 60, bottom right bar, MULTIACTIONBAR2
-- 61 - 72, bottom left bar, MULTIACTIONBAR1
function store.core.assign_macro_to_bar_slot(name, slot_id)
    if InCombatLockdown() then
        print("ERROR: Can't assign buttons in battle.")
        return
    end

    local macro_index = GetMacroIndexByName(name)
    if macro_index == 0 then
        print("ERROR: Macro '" .. name .. "' does not exist.")
        return
    end

    ClearCursor()
    PickupMacro(name)
    PlaceAction(slot_id)
    ClearCursor()
end
