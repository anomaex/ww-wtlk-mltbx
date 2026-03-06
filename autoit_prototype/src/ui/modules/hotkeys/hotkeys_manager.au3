;
; src\ui\modules\hotkeys\hotkeys_manager.au3
;
#include-once

#include <Misc.au3>

#include "..\..\state\session.au3"

#include "..\gw_switch.au3"
#include "sender.au3"


local $dll_user32 = DllOpen("user32.dll")

local $is_f1_press = false 
local $is_space_press = false

local $f2_press = false 
local $ctrl_f2_press = false
local $alt_f2_press = false


; Key in HEX, see https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes


func hotkeys_update()
    local $is_ctrl = _IsPressed(0x11, $dll_user32) ; 0x11 - left or right CTRL
    local $is_alt = _IsPressed(0x12, $dll_user32) ; 0x12 - left or right ALT

    ; F1 - 0x70
    if _IsPressed(0x70, $dll_user32) then
        if not $is_f1_press then
            $is_f1_press = true
            switch_gw($g_game_windows)
        endif
    else
        $is_f1_press = False
    endif

    ; F2 or F2 + CTRL or F2 + ALT
    local $is_f2 = _IsPressed(0x71, $dll_user32) 
    if $is_f2 then
        if $is_ctrl then
            if not $ctrl_f2_press then
                $ctrl_f2_press = true
                send_hotkey_message(0x71, 0x11)
            endif
        elseif $is_alt then
            if not $alt_f2_press then
                $alt_f2_press = true
                send_hotkey_message(0x71, 0x12)
            endif
        else
            if not $f2_press and not $ctrl_f2_press and not $alt_f2_press then
                $f2_press = true
                send_hotkey_message(0x71)
            endif
        endif
    else
        $f2_press = false
        $ctrl_f2_press = false
        $alt_f2_press = false
    endif

    ; SPACEBAR - 0x20
    if _IsPressed(0x20, $dll_user32) then
        if not $is_space_press then
            $is_space_press = true
            if WinActive($g_game_windows[0]) then
                send_hotkey_message(0x20)
            endif
        endif
    else
        $is_space_press = False
    endif
endfunc
