;
; src\ui\modules\hotkeys\dispatcher.au3
;
#include-once

#include <Misc.au3>

#include "..\..\state\session.au3"

#include "gw_switch.au3"
#include "sender.au3"


local $dll_user32 = DllOpen("user32.dll")

local $is_f1_press = false 
local $is_f2_press = false 
local $is_space_press = false


; F1 - 70, F2 - 71, ... , F11 - 7A, F12 - 7B
func hotkeys_update()
    ; F1 - key 70
    if _IsPressed("70", $dll_user32) then
        if not $is_f1_press then
            $is_f1_press = true
            switch_gw($g_game_windows)
        endif
    else
        $is_f1_press = False
    endif

    ; F2 - key 71
    if _IsPressed("71", $dll_user32) then
        if not $is_f2_press then
            $is_f2_press = true
            test_post_message(71)
        endif
    else
        $is_f2_press = False
    endif

    ; SPACE - key 20
    if _IsPressed("20", $dll_user32) then
        if not $is_space_press then
            $is_space_press = true
            if WinActive($g_game_windows[0]) then
                test_post_message(20)
            endif
        endif
    else
        $is_space_press = False
    endif
endfunc
