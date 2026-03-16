;
; src\ui\modules\hotkeys\hotkeys_manager.au3
;
; Key in HEX, see https://learn.microsoft.com/en-us/windows/win32/inputdev/virtual-key-codes
;
; 0x11 - left/right CTRL
; 0x12 - left/right ALT

#include-once
#include <Misc.au3>
#include "..\..\state\session.au3"
#include "..\gw_switch.au3"
#include "sender.au3"

local $dll_user32 = DllOpen("user32.dll")

local $f1_press = false

local $space_press = false

local $f2_press = false 
local $ctrl_f2_press = false

local $f11_press = false
local $ctrl_f11_press = false

local $f12_press = false
local $ctrl_f12_press = false

func hotkeys_update()
    local $is_ctrl = _IsPressed(0x11, $dll_user32)

    ; F1
    if _IsPressed(0x70, $dll_user32) then
        if not $f1_press then
            $f1_press = true
            switch_gw($g_game_windows)
        endif
    else
        $f1_press = False
    endif

    ; F2 or F2 + CTRL
    local $is_f2 = _IsPressed(0x71, $dll_user32)
    if $is_f2 then
        if $is_ctrl then
            if not $ctrl_f2_press then
                $ctrl_f2_press = true
                send_hotkey_message(0x71, 0x11)
            endif
        else
            if not $f2_press and not $ctrl_f2_press then
                $f2_press = true
                send_hotkey_message(0x71)
            endif
        endif
    else
        $f2_press = false
        $ctrl_f2_press = false
    endif

    ; F11 or F12 + CTRL
    local $is_f11 = _IsPressed(0x7A, $dll_user32)
    if $is_f11 then
        if $is_ctrl then
            if not $ctrl_f11_press then
                $ctrl_f11_press = true
                send_hotkey_message(0x7A, 0x11)
            endif
        else
            if not $f11_press and not $ctrl_f11_press then
                $f11_press = true
                send_hotkey_message(0x7A)
            endif
        endif
    else
        $f11_press = false
        $ctrl_f11_press = false
    endif

    ; F12 or F12 + CTRL
    local $is_f12 = _IsPressed(0x7B, $dll_user32) 
    if $is_f12 then
        if $is_ctrl then
            if not $ctrl_f12_press then
                $ctrl_f12_press = true
                send_hotkey_message(0x7B, 0x11)
            endif
        else
            if not $f12_press and not $ctrl_f12_press then
                $f12_press = true
                send_hotkey_message(0x7B)
            endif
        endif
    else
        $f12_press = false
        $ctrl_f12_press = False
    endif

    ; SPACEBAR
    if _IsPressed(0x20, $dll_user32) then
        if not $space_press then
            $space_press = true
            if WinActive($g_game_windows[0]) then
                send_hotkey_message(0x20)
            endif
        endif
    else
        $space_press = False
    endif
endfunc
