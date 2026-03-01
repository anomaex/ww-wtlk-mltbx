;
; src/ui/modules/hotkeys.au3
;
#include-once

#include "..\config\session.au3"
#include "..\..\utils\logger.au3"


local $current_gw_id = 1


func switch_gw()
    if WinActive($g_game_windows[0][0]) then
        $current_gw_id = 1
    endif

    for $i = 1 to 4
        local $current_gw_hwnd = $g_game_windows[$current_gw_id][0]
        
        if WinExists($current_gw_hwnd) then
            if WinActive($current_gw_hwnd) = 0 then
                WinActivate($current_gw_hwnd)
                add_current_gw_id()
                exitloop
            endif
        endif

        add_current_gw_id()
        Sleep(5)
    next
endfunc


func add_current_gw_id()
    $current_gw_id += 1
    if $current_gw_id > 4 then
        $current_gw_id = 1
    endif
endfunc
