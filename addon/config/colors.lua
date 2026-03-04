--
-- config\colors.lua
--
local _, store = ...
store.config = store.config or {}

store.config.COLORS = {
    RED = { 1, 0, 0 },
    GREEN = { 0, 1, 0 },
    BLUE = { 0, 0, 1 },
    
    -- Bot state
    STATE_CAST = { 1, 0, 0 }, -- red
    STATE_NON_CAST = { 0, 1, 0 }, -- green
}
