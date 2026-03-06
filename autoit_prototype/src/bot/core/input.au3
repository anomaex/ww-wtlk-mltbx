;
; src\bot\core\input.au3
;
#include-once


Opt("SendKeyDelay", 0) ; 5 - default, it's for ControlSend()
Opt("SendKeyDownDelay", 0) ; 5 - default, it's for ControlSend()


#include <WinAPISysWin.au3>


local $l_PAUSE_UP = 10
local $l_WM_KEYDOWN = 0x0100
local $l_WM_KEYUP = 0x0101


; In HEX, see https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
; Function _WinAPI_PostMessage() more stable for DirectX/OpenGL window.
; Function ControlSend() can: may skip keystrokes, may can't work on background, modifiers like Shift/Ctrl/Alt may "stick", etc.


func input_send($hwnd, $vk_hex_code)
    _WinAPI_PostMessage($hwnd, $l_WM_KEYDOWN, $vk_hex_code, 0)
    Sleep($l_PAUSE_UP)
    _WinAPI_PostMessage($hwnd, $l_WM_KEYUP, $vk_hex_code, 0)
endfunc


func input_send_down($hwnd, $vk_hex_code)
    _WinAPI_PostMessage($hwnd, $l_WM_KEYDOWN, $vk_hex_code, 0)
    Sleep($l_PAUSE_UP)
endfunc


func input_send_up($hwnd, $vk_hex_code)
    Sleep($l_PAUSE_UP)
    _WinAPI_PostMessage($hwnd, $l_WM_KEYUP, $vk_hex_code, 0)
endfunc


func input_text($hwnd, $text)
    ControlSend($hwnd, "", "", $text, 1)
endfunc
