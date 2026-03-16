--
-- core\commands.lua
--
local _, store = ...

SLASH_WWMLTBXADDON1 = "/wwwtlkmltbx"


local function handle_slash_command(msg)
    local evaluated_msg = SecureCmdOptionParse(msg)
    print(evaluated_msg)
    if evaluated_msg == "follow_pause" then
        store.state.is_follow_pause = true
    elseif evaluated_msg == "follow_start" then
        store.state.is_follow = true
    elseif evaluated_msg == "follow_stop" then
        store.state.is_follow = false
    elseif evaluated_msg == "quit" then
        Quit()
    elseif evaluated_msg == "force_quit" then
        ForceQuit()
    end
end


SlashCmdList["WWMLTBXADDON"] = handle_slash_command
