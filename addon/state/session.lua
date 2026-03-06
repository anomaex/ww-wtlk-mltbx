--
-- state\session.lua
--
local _, store = ...

store.state = {
    is_casting = false,
    is_eatdrink = false,
    is_follow = false,
    is_follow_pause = false
}
