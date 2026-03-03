--
-- modules\action\profiles\druid_restoration.lua
--
local _, store = ...
store.modules = store.modules or {}
store.modules.action = store.modules.action or {}
store.modules.action.profiles = store.modules.action.profiles or {}


store.modules.action.profiles["druid_restoration"] = {
    exec = function()
        print("druid_restoration")
    end
}
