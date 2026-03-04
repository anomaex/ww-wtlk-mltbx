--
-- core\commands.lua
--
local _, store = ...

SLASH_WWMLTBXADDON1 = "/wwwtlkmltbx"


local function HandleSlashCommand(msg)
    local evaluated_msg = SecureCmdOptionParse(msg)
    print(evaluated_msg)
    if evaluated_msg == "follow" then
        store.state.is_follow = true
    elseif evaluated_msg == "stopfollow" then
        store.state.is_follow = false
    end
end


SlashCmdList["WWMLTBXADDON"] = HandleSlashCommand