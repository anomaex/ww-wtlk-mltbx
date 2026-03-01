;
; src/bot/main.au3
;
#include-once

Opt("TrayAutoPause", 0) ; Disable AutoIt tray auto-pause

; Shared
#include "..\config\constants.au3"
#include "..\config\roles.au3"
#include "..\utils\logger.au3"

; Local
#include "config\session.au3"
#include "core\window.au3"
#include "modules\login\login.au3"
#include "modules\action\dispatcher.au3"
#include "config\secret.au3"
; ONLY, in right position
; [0] - account role, [0][0] - class, [0][1] - spec
; Without TANK, because it's a main window. You are in control of the situation.
; local const $sec_classes_and_specs[4][3] = [ _
;     ["class_name", "class_spec_name"], _ ; HEALER account
;     ["paladin", "retribution"], _ ; DPS 0 (first) account
;     ["paladin", "retribution"], _ ; DPS 1 (second) account
;     ["paladin", "retribution"] _ ; DPS 2 (third) account
; ]


if $CmdLine[0] <> 2 then exit 0

local $bot_name_title = $PROJECT_NAME & "-bot-" & $CmdLine[1]
AutoItWinSetTitle($bot_name_title)

$g_role = int($CmdLine[1])
$g_gw_hwnd = HWnd($CmdLine[2])

local $flag = waiting_game_window($g_gw_hwnd, $TITLE_GAME_WINDOW)
if not $flag then
    log_error("Can't find the game window, for a role: " & $g_role, $g_gw_hwnd)
    exit 0
endif

enter_to_world()

if $g_role = $ROLE_TANK then exit 0

local $profile_id = $g_role - 1
$g_current_profile = $sec_classes_and_specs[$profile_id][0] & "_" & $sec_classes_and_specs[$profile_id][1]

while true
    check_win($g_gw_hwnd, $TITLE_GAME_WINDOW)

    dispatch_action()

    Sleep(150)
wend
