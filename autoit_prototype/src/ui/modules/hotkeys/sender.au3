;
; src\ui\modules\hotkeys\sender.au3
;
#include-once

#include <WinAPISysWin.au3>

#include "..\..\..\config\constants.au3"


local $cache_bots_list[0]
local $timer_cache_bots = 0
local $timeout_cache_bots = 5000 ; 5 sec


func test_post_message($send_key_code)
    _refresh_bots_cache()
    
    for $i = 0 to UBound($cache_bots_list) - 1
        _WinAPI_PostMessage($cache_bots_list[$i], $WM_BOT_COMMAND, $send_key_code, 0)
    next
endfunc


func _refresh_bots_cache()
    if UBound($cache_bots_list) <> 0 or TimerDiff($timer_cache_bots) < $timeout_cache_bots then return
    
    local $bots_list = WinList($PROJECT_NAME & "-bot-")
    if $bots_list[0][0] = 0 then
        return
    endif

    local $new_bots_list[$bots_list[0][0]]
    for $i = 1 to $bots_list[0][0]
        $new_bots_list[$i-1] = $bots_list[$i][1]
    next

    $cache_bots_list = $new_bots_list
    $timer_cache_bots = TimerInit()
endfunc
