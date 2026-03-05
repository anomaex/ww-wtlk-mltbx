;
; src\bot\core\input.au3
;
#include-once


Opt("SendKeyDownDelay", 5) ; 5 - default


#include <WinAPISysWin.au3>


local const $WM_KEYDOWN = 0x0100
local const $WM_KEYUP = 0x0101


func input_send($hwnd, $vk_code, $is_raw = 0)
    _WinAPI_PostMessage($hwnd, $WM_KEYDOWN, $vk_code, 0)
    Sleep(5) 
    _WinAPI_PostMessage($hwnd, $WM_KEYUP, $vk_code, 0)

    ;ControlSend($hwnd, "", "", $msg, $is_raw)
endfunc


func input_jump($hwnd)
    input_send($hwnd, 0x20) ; 0x20 - SPACE
endfunc
