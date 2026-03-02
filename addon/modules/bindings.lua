--
-- modules\bindings.lua
--
local addon_name, store = ...
store.modules = store.modules or {}
store.modules.bindings = {}


local default_bind_set = 2 -- for character only
local default_profile = {
    cmds = {
        -- Movement Keys
        ["MOVEANDSTEER"] = "", -- first CMD, second KEY
        ["MOVEFORWARD"] = "W",
        ["MOVEBACKWARD"] = "S",
        ["TURNLEFT"] = "",
        ["TURNRIGHT"] = "",
        ["STRAFELEFT"] = "A",
        ["STRAFERIGHT"] = "D",
        ["JUMP"] = "SPACE",
        ["SITORSTAND"] = "",
        ["TOGGLESHEATH"] = "",
        ["TOGGLEAUTORUN"] = "",
        ["PITCHUP"] = "",
        ["PITCHDOWN"] = "",
        ["TOGGLERUN"] = "",

        -- Chat Functions
        ["OPENCHAT"] = "ENTER",
        ["OPENCHATSLASH"] = "",
        ["CHATPAGEUP"] = "",
        ["CHATPAGEDOWN"] = "",
        ["CHATBOTTOM"] = "",
        ["REPLY"] = "",
        ["REPLY2"] = "",
        ["COMBATLOGPAGEUP"] = "",
        ["COMBATLOGPAGEDOWN"] = "",
        ["COMBATLOGBOTTOM"] = "",

        -- Action Bar Functions
        ["ACTIONBUTTON1"] = "", -- Action Button 1, main panel
        ["ACTIONBUTTON2"] = "",
        ["ACTIONBUTTON3"] = "",
        ["ACTIONBUTTON4"] = "",
        ["ACTIONBUTTON5"] = "",
        ["ACTIONBUTTON6"] = "",
        ["ACTIONBUTTON7"] = "",
        ["ACTIONBUTTON8"] = "",
        ["ACTIONBUTTON9"] = "",
        ["ACTIONBUTTON10"] = "",
        ["ACTIONBUTTON11"] = "",
        ["ACTIONBUTTON12"] = "",
        ["SHAPESHIFTBUTTON1"] = "", -- Special Action Button 1, this is stance buttons for warrior, forms for druids, ...
        ["SHAPESHIFTBUTTON2"] = "",
        ["SHAPESHIFTBUTTON3"] = "",
        ["SHAPESHIFTBUTTON4"] = "",
        ["SHAPESHIFTBUTTON5"] = "",
        ["SHAPESHIFTBUTTON6"] = "",
        ["SHAPESHIFTBUTTON7"] = "",
        ["SHAPESHIFTBUTTON8"] = "",
        ["SHAPESHIFTBUTTON9"] = "",
        ["SHAPESHIFTBUTTON10"] = "",
        ["BONUSACTIONBUTTON1"] = "", -- Secondary Action Button 1, for vehicles and control mind
        ["BONUSACTIONBUTTON2"] = "",
        ["BONUSACTIONBUTTON3"] = "",
        ["BONUSACTIONBUTTON4"] = "",
        ["BONUSACTIONBUTTON5"] = "",
        ["BONUSACTIONBUTTON6"] = "",
        ["BONUSACTIONBUTTON7"] = "",
        ["BONUSACTIONBUTTON8"] = "",
        ["BONUSACTIONBUTTON9"] = "",
        ["BONUSACTIONBUTTON10"] = "",
        ["ACTIONPAGE1"] = "",
        ["ACTIONPAGE2"] = "",
        ["ACTIONPAGE3"] = "",
        ["ACTIONPAGE4"] = "",
        ["ACTIONPAGE5"] = "",
        ["ACTIONPAGE6"] = "",
        ["PREVIOUSACTIONPAGE"] = "",
        ["NEXTACTIONPAGE"] = "",
        ["TOGGLEACTIONBARLOCK"] = "",
        ["TOGGLEAUTOSELFCAST"] = "",

        -- Shaman Totem Bar Functions
        ["MULTICASTSUMMONBUTTON1"] = "", -- Call of the Elements
        ["MULTICASTACTIONBUTTON1"] = "", -- Earth Totem
        ["MULTICASTACTIONBUTTON2"] = "", -- Fire
        ["MULTICASTACTIONBUTTON3"] = "", -- Water
        ["MULTICASTACTIONBUTTON4"] = "", -- Air
        ["MULTICASTSUMMONBUTTON2"] = "", -- Call of the Ancestors
        ["MULTICASTACTIONBUTTON5"] = "",
        ["MULTICASTACTIONBUTTON6"] = "",
        ["MULTICASTACTIONBUTTON7"] = "",
        ["MULTICASTACTIONBUTTON8"] = "",
        ["MULTICASTSUMMONBUTTON3"] = "", -- Call of the Spirits
        ["MULTICASTACTIONBUTTON9"] = "",
        ["MULTICASTACTIONBUTTON10"] = "",
        ["MULTICASTACTIONBUTTON11"] = "",
        ["MULTICASTACTIONBUTTON12"] = "",
        ["MULTICASTRECALLBUTTON1"] = "", -- Totemic Recall

        -- Targeting Functions
        ["TARGETNEARESTENEMY"] = "",
        ["TARGETPREVIOUSENEMY"] = "",
        ["TARGETNEARESTFRIEND"] = "",
        ["TARGETPREVIOUSFRIEND"] = "",
        ["TARGETNEARESTENEMYPLAYER"] = "",
        ["TARGETPREVIOUSENEMYPLAYER"] = "",
        ["TARGETNEARESTFRIENDPLAYER"] = "",
        ["TARGETPREVIOUSFRIENDPLAYER"] = "",
        ["TARGETSELF"] = "",
        ["TARGETPARTYMEMBER1"] = "",
        ["TARGETPARTYMEMBER2"] = "",
        ["TARGETPARTYMEMBER3"] = "",
        ["TARGETPARTYMEMBER4"] = "",
        ["TARGETPET"] = "",
        ["TARGETPARTYPET1"] = "",
        ["TARGETPARTYPET2"] = "",
        ["TARGETPARTYPET3"] = "",
        ["TARGETPARTYPET4"] = "",
        ["TARGETLASTHOSTILE"] = "",
        ["TARGETLASTTARGET"] = "",
        ["NAMEPLATES"] = "",
        ["FRIENDNAMEPLATES"] = "",
        ["ALLNAMEPLATES"] = "",
        ["INTERACTMOUSEOVER"] = "",
        ["INTERACTTARGET"] = "",
        ["ASSISTTARGET"] = "",
        ["ATTACKTARGET"] = "",
        ["STARTATTACK"] = "",
        ["PETATTACK"] = "",
        ["FOCUSTARGET"] = "",
        ["TARGETFOCUS"] = "",
        ["TARGETMOUSEOVER"] = "",
        ["TARGETTALKER"] = "",

        -- Interface panel Functions
        ["TOGGLECHARACTER0"] = "",
        ["TOGGLEBACKPACK"] = "",
        ["TOGGLEBAG1"] = "",
        ["TOGGLEBAG2"] = "",
        ["TOGGLEBAG3"] = "",
        ["TOGGLEBAG4"] = "",
        ["OPENALLBAGS"] = "",
        ["TOGGLEKEYRING"] = "",
        ["TOGGLESPELLBOOK"] = "",
        ["TOGGLEPETBOOK"] = "",
        ["TOGGLEINSCRIPTION"] = "",
        ["TOGGLETALENTS"] = "",
        ["TOGGLECHARACTER4"] = "", -- Toggle PVP Pane
        ["TOGGLECHARACTER3"] = "", -- Toggle Pet Pane
        ["TOGGLECHARACTER2"] = "", -- Toggle Reputation Pane
        ["TOGGLECHARACTER1"] = "", -- Toggle Skill Pane
        ["TOGGLEQUESTLOG"] = "",
        ["TOGGLEGAMEMENU"] = "ESCAPE",
        ["TOGGLEMINIMAP"] = "",
        ["TOGGLEWORLDMAP"] = "M",
        ["TOGGLEWORLDMAPSIZE"] = "", -- Toggle World Map Size
        ["TOGGLESOCIAL"] = "", -- Toggle Social Pane
        ["TOGGLEFRIENDSTAB"] = "", -- Toggle Friends Pane
        ["TOGGLEWHOTAB"] = "", -- Toggle Who Pane
        ["TOGGLEGUILDTAB"] = "", -- Toggle Guild Pane
        ["TOGGLECHATTAB"] = "", -- Toggle Chat Pane
        ["TOGGLERAIDTAB"] = "", -- Toggle Raid Pane
        ["TOGGLELFGPARENT"] = "", -- Toggle Dungeon Finder Frame
        ["TOGGLELFRPARENT"] = "", -- Toggle Raid Browser
        ["TOGGLEWORLDSTATESCORES"] = "", -- Toggle Score Screen
        ["TOGGLEBATTLEFIELDMINIMAP"] = "", -- Toggle Zone Map
        ["TOGGLEMINIMAPROTATION"] = "", -- Toggle Minimap Rotation
        ["TOGGLECHANNELPULLOUT"] = "", -- Toggle Channel Pullout
        ["TOGGLEACHIEVEMENT"] = "", -- Toggle Achievement Frame
        ["TOGGLESTATISTICS"] = "", -- Toggle Statistics Frame
        ["TOGGLECURRENCY"] = "", -- Toggle Currency Frame
        
        -- Miscellaneous Functions
        ["STOPCASTING"] = "",
        ["STOPATTACK"] = "",
        ["DISMOUNT"] = "",
        ["MINIMAPZOOMIN"] = "",
        ["MINIMAPZOOMOUT"] = "",
        ["TOGGLEMUSIC"] = "",
        ["TOGGLESOUND"] = "",
        ["MASTERVOLUMEUP"] = "",
        ["MASTERVOLUMEDOWN"] = "",
        ["TOGGLESELFMUTE"] = "",
        ["TOGGLEUI"] = "",
        ["TOGGLEFPS"] = "",
        ["SCREENSHOT"] = "",

        -- Camera Functions
        ["NEXTVIEW"] = "",
        ["PREVVIEW"] = "",
        ["CAMERAZOOMIN"] = "",
        ["CAMERAZOOMOUT"] = "",
        ["SETVIEW1"] = "",
        ["SETVIEW2"] = "",
        ["SETVIEW3"] = "",
        ["SETVIEW4"] = "",
        ["SETVIEW5"] = "",
        ["SAVEVIEW1"] = "",
        ["SAVEVIEW2"] = "",
        ["SAVEVIEW3"] = "",
        ["SAVEVIEW4"] = "",
        ["SAVEVIEW5"] = "",
        ["RESETVIEW1"] = "",
        ["RESETVIEW2"] = "",
        ["RESETVIEW3"] = "",
        ["RESETVIEW4"] = "",
        ["RESETVIEW5"] = "",
        ["FLIPCAMERAYAW"] = "",

        -- MultiActionBar Bindings
        ["MULTIACTIONBAR1BUTTON1"] = "", -- BottomLeft Action Button 1
        ["MULTIACTIONBAR1BUTTON2"] = "",
        ["MULTIACTIONBAR1BUTTON3"] = "",
        ["MULTIACTIONBAR1BUTTON4"] = "",
        ["MULTIACTIONBAR1BUTTON5"] = "",
        ["MULTIACTIONBAR1BUTTON6"] = "",
        ["MULTIACTIONBAR1BUTTON7"] = "",
        ["MULTIACTIONBAR1BUTTON8"] = "",
        ["MULTIACTIONBAR1BUTTON9"] = "",
        ["MULTIACTIONBAR1BUTTON10"] = "",
        ["MULTIACTIONBAR1BUTTON11"] = "",
        ["MULTIACTIONBAR1BUTTON12"] = "",
        ["MULTIACTIONBAR2BUTTON1"] = "", -- BottomRight Action Button 1
        ["MULTIACTIONBAR2BUTTON2"] = "",
        ["MULTIACTIONBAR2BUTTON3"] = "",
        ["MULTIACTIONBAR2BUTTON4"] = "",
        ["MULTIACTIONBAR2BUTTON5"] = "",
        ["MULTIACTIONBAR2BUTTON6"] = "",
        ["MULTIACTIONBAR2BUTTON7"] = "",
        ["MULTIACTIONBAR2BUTTON8"] = "",
        ["MULTIACTIONBAR2BUTTON9"] = "",
        ["MULTIACTIONBAR2BUTTON10"] = "",
        ["MULTIACTIONBAR2BUTTON11"] = "",
        ["MULTIACTIONBAR2BUTTON12"] = "",
        ["MULTIACTIONBAR3BUTTON1"] = "", -- Right Action Button 1
        ["MULTIACTIONBAR3BUTTON2"] = "",
        ["MULTIACTIONBAR3BUTTON3"] = "",
        ["MULTIACTIONBAR3BUTTON4"] = "",
        ["MULTIACTIONBAR3BUTTON5"] = "",
        ["MULTIACTIONBAR3BUTTON6"] = "",
        ["MULTIACTIONBAR3BUTTON7"] = "",
        ["MULTIACTIONBAR3BUTTON8"] = "",
        ["MULTIACTIONBAR3BUTTON9"] = "",
        ["MULTIACTIONBAR3BUTTON10"] = "",
        ["MULTIACTIONBAR3BUTTON11"] = "",
        ["MULTIACTIONBAR3BUTTON12"] = "",
        ["MULTIACTIONBAR4BUTTON1"] = "", -- Right ActionBar 2 Button 1
        ["MULTIACTIONBAR4BUTTON2"] = "",
        ["MULTIACTIONBAR4BUTTON4"] = "",
        ["MULTIACTIONBAR4BUTTON5"] = "",
        ["MULTIACTIONBAR4BUTTON6"] = "",
        ["MULTIACTIONBAR4BUTTON7"] = "",
        ["MULTIACTIONBAR4BUTTON8"] = "",
        ["MULTIACTIONBAR4BUTTON9"] = "",
        ["MULTIACTIONBAR4BUTTON10"] = "",
        ["MULTIACTIONBAR4BUTTON11"] = "",
        ["MULTIACTIONBAR4BUTTON12"] = "",

        -- Raid Targeting
        ["RAIDTARGET1"] = "", -- Star
        ["RAIDTARGET2"] = "",
        ["RAIDTARGET3"] = "",
        ["RAIDTARGET4"] = "",
        ["RAIDTARGET5"] = "",
        ["RAIDTARGET6"] = "",
        ["RAIDTARGET7"] = "",
        ["RAIDTARGET8"] = "",
        ["RAIDTARGETNONE"] = "",

        -- Vehicle Controls
        ["VEHICLEEXIT"] = "",
        ["VEHICLEPREVSEAT"] = "",
        ["VEHICLENEXTSEAT"] = "",
        ["VEHICLEAIMUP"] = "",
        ["VEHICLEAIMDOWN"] = "",
        ["VEHICLEAIMINCREMENT"] = "",
        ["VEHICLEAIMDECREMENT"] = "",
        ["VEHICLECAMERAZOOMIN"] = "",
        ["VEHICLECAMERAZOOMOUT"] = ""
    }
}


local function clear_all()
    LoadBindings(0)
end


local function unbind_all()
    for cmd, _ in pairs(default_profile.cmds) do
        local keys = {GetBindingKey(cmd)}
        for _, key in ipairs(keys) do
            if key then
                SetBinding(key, nil)
            end
        end
    end

    SaveBindings(default_bind_set)
end


function store.modules.bindings.init()
    clear_all()
    unbind_all()
    for cmd, key  in pairs(default_profile.cmds) do
        if key ~= "" and key ~= nil then
            SetBinding(key, cmd)
        end
    end
    SaveBindings(default_bind_set)
end
