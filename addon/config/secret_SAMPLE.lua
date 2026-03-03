--
-- config\secret.lua
--
local _, store = ...
store.config = store.config or {}

store.config.secret = {
    name_class_spec = {
        ["Character_name_first"] = "druid_restoration",
        ["Character_name_second"] = "paladin_retribution",
        ["Character_name_third"] = "paladin_retribution",
        ["Character_name_fifth"] = "paladin_retribution"
    }
}