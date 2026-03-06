--
-- core\macro_manager.lua
--
local _, store = ...
store.core = store.core or {}


function store.core.remove_all_macros()
    for i = 54, 1, -1 do
        local name = GetMacroInfo(i)
        if name then
            DeleteMacro(i)
        end
    end
end


function store.core.remove_macro(id_or_name)
    local name = GetMacroInfo(id_or_name)
    if name then
        DeleteMacro(id_or_name)
    end
end


function store.core.create_macro(name, body, per_char, icon)
    local num_global, num_perchar = GetNumMacros()
    if not per_char then
        if num_global >= 36 then
            print("Not have space for create macros in global")
            return false
        end
    else
        if num_perchar >= 18 then
            print("Not have space for create macros in PerCharacter")
            return false
        end
    end
    local safe_name = tostring(name):sub(1, 16)
    store.core.remove_macro(safe_name)
    local safe_body = tostring(body):sub(1, 255)
    local icon_index = tonumber(icon) or 1
    local is_per_char = (per_char == 1 or per_char == true) and 1 or 0
    CreateMacro(safe_name, icon_index, safe_body, is_per_char)
    return safe_name
end
