;
; src\ui\modules\hotkeys\sender.au3
;
#include-once

#include <WinAPISysWin.au3>

#include "..\..\..\config\constants.au3"


local const $WM_BOT_COMMAND = _WinAPI_RegisterWindowMessage($PROJECT_NAME & "_message_identifier")

local $cache_bots_list[0]


func send_hotkey_message($key_hex_core, $modifier_hex_code = 0x0)
    _refresh_bots_cache()
    
    for $i = 0 to UBound($cache_bots_list) - 1
        _WinAPI_PostMessage($cache_bots_list[$i], $WM_BOT_COMMAND, $key_hex_core, $modifier_hex_code)
    next
endfunc


func _refresh_bots_cache()
    
    local $bots_list = WinList($PROJECT_NAME & "_bot_window") ; need hidden bot window for PostMessage, NOT a bot script title name
    if $bots_list[0][0] = 0 then
        return
    endif

    local $new_bots_list[$bots_list[0][0]]
    for $i = 0 to $bots_list[0][0] - 1
        $new_bots_list[$i] = $bots_list[$i + 1][1]
    next

    $cache_bots_list = $new_bots_list
endfunc
