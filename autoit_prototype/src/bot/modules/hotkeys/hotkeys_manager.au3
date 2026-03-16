;
; src\bot\modules\hotkeys_manager.au3
;
; Key in HEX, see https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
;
; 0x0 - none
; 0x11 - left/right CTRL
; 0x12 - left/right ALT
; 0x71 - key F2
; 0x7A - key F11
; 0x7B - key F12
; 0x31 - key 1
; 0xBB - key =
; 0x20 - SPACEBAR
; 0x25 - Left arrow
; 0x27 - Right arrow

#include-once
#include "..\..\core\input.au3"
#include "..\..\state\session.au3"
#include "receiver.au3"

local $follow = false

func hotkey_handler($key, $modifier)
    select
        ; F2 or F2 + CTRL, start or stop follow macros
        case $key = 0x71 and $modifier = 0x11
            input_follow_stop()

        case $key = 0x71 and $modifier = 0x0
            if $follow then
                $follow = false
                input_follow_stop()
            else
                $follow = true
                input_follow_start()
            endif

        case $key = 0x71 and $modifier = 0x0
            input_follow_pause()

        ; F11 or F11 + CTRL, quit or force quit from game macros
        case $key = 0x7A and $modifier = 0x11
            input_force_quit()

        case $key = 0x7A and $modifier = 0x0
            input_quit()

        ; F12, bot actions
        case $key = 0x7B and $modifier = 0x11
            $g_bot_actions = false

        case $key = 0x7B and $modifier = 0x0
            if $g_bot_actions then
                $g_bot_actions = false
            else
                $g_bot_actions = true
            endif

        ; SPACEBAR, Jump keybind
        case $key = 0x20 and $modifier = 0x0
            input_jump()
    endselect
endfunc

func input_jump()
    input_send($g_gw_hwnd, 0x20)
endfunc

func input_follow_pause()
    input_send($g_gw_hwnd, 0x31)
    input_follow_break()
endfunc

func input_follow_start()
    input_send_down($g_gw_hwnd, 0x12) 
    input_send($g_gw_hwnd, 0x31)
    input_send_up($g_gw_hwnd, 0x12)
endfunc

func input_follow_stop()
    input_send_down($g_gw_hwnd, 0x11)
    input_send($g_gw_hwnd, 0x31)
    input_send_up($g_gw_hwnd, 0x11)
    input_follow_break()
endfunc

func input_follow_break()
    input_send($g_gw_hwnd, 0x25)
    input_send($g_gw_hwnd, 0x27)
endfunc

func input_quit()
    input_send($g_gw_hwnd, 0xBB)
endfunc

func input_force_quit()
    input_send_down($g_gw_hwnd, 0x11)
    input_send($g_gw_hwnd, 0xBB)
    input_send_up($g_gw_hwnd, 0x11)
endfunc
