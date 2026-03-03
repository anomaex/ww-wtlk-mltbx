--
-- config\colors.lua
--
local _, store = ...
store.config = store.config or {}

store.config.COLORS = {
    RED = { 255, 0, 0 },
    GREEN = { 0, 255, 0 },
    BLUE = { 0, 0, 255 },
    -- Bot state
    STATE_CAST = { 255, 0, 0 }, -- red
    STATE_NON_CAST = { 0, 255, 0 }, -- green
}
