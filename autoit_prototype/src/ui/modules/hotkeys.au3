;
; src\ui\modules\hotkeys.au3
;
#include-once

#include <Misc.au3>

#include "..\config\session.au3"
#include "..\core\input.au3"
#include "switch_game_window.au3"


local $dll_user32 = DllOpen("user32.dll")

local $is_f1_press = false 
local $is_space_press = false


func hotkeys_update()
    ; Key 70 = f1
    if _IsPressed("70", $dll_user32) then
        if not $is_f1_press then
            $is_f1_press = true
            switch_gw()
        endif
    else
        $is_f1_press = False
    endif

    ; Key 20 = SPACE
    if _IsPressed("20", $dll_user32) then
        if not $is_space_press then
            $is_space_press = true
            if WinActive($g_game_windows[0][0]) then
                for $i = 1 to UBound($g_game_windows) - 1
                    inpt_space($g_game_windows[$i][0])
                next
            endif
        endif
    else
        $is_space_press = False
    endif
endfunc


func hotkeys_close()
    DllClose($dll_user32)
endfunc
