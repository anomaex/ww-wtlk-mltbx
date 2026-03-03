--
-- core\binding_manager.lua
--
local _, store = ...
store.core = store.core or {}

local default_bind_set = 2 -- for character only


local function set_default()
    LoadBindings(0)
end


local function unbind(profile)
    for cmd, _ in pairs(profile) do
        local keys = {GetBindingKey(cmd)}
        for _, key in ipairs(keys) do
            if key then
                SetBinding(key, nil)
            end
        end
    end

    SaveBindings(default_bind_set)
end


function store.core.set_bindings(profile)
    set_default()
    unbind(profile)
    for cmd, key  in pairs(profile) do
        if key ~= "" and key ~= nil then
            SetBinding(key, cmd)
        end
    end
    SaveBindings(default_bind_set)
end
