;
; src\bot\modules\hotkeys\receiver.au3
;
#include-once

#include <WinAPISysWin.au3>

#include "..\..\..\config\constants.au3"

#include "..\..\state\session.au3"

#include "hotkeys_manager.au3"


local $hidden_bot_window = GUICreate($PROJECT_NAME & "_bot_window_" & $g_role) ; need hidden bot window for receive PostMessage
local const $WM_BOT_COMMAND = _WinAPI_RegisterWindowMessage($PROJECT_NAME & "_message_identifier")
GUIRegisterMsg($WM_BOT_COMMAND, "on_get_hotkey_message")


func on_get_hotkey_message($hwnd, $i_msg, $w_param, $i_param)
    if $i_msg <> $WM_BOT_COMMAND then return 0

    hotkey_handler($w_param, $i_param)

    return 0
endfunc
