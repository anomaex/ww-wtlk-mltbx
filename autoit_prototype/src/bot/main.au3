;
; src\bot\main.au3
;
#include-once


Opt("TrayAutoPause", 0) ; Disable AutoIt tray auto-pause

if $CmdLine[0] <> 2 then exit 0


; Shared
#include "..\utils\logger.au3"
#include "..\config\constants.au3"

; Local
#include "modules\hotkeys\hotkeys_manager.au3"
#include "modules\login\login.au3"


local $bot_name_title = $PROJECT_NAME & "_bot_" & $CmdLine[1]
AutoItWinSetTitle($bot_name_title)

$g_role = int($CmdLine[1])
$g_gw_hwnd = HWnd($CmdLine[2])

local $gw_window = WinWait($g_gw_hwnd, 60)
if $gw_window = 0 then
    log_error("Can't wait window, timeout END, for a role: " & $g_role, $g_gw_hwnd)
    exit 0
endif

$gw_window = waiting_game_window($g_gw_hwnd, $TITLE_GAME_WINDOW)
if not $gw_window then 
    log_error("Can't wait window, timeout END, for a role: " & $g_role, $g_gw_hwnd)
    exit 0
endif

login_process()

while true
    check_win($g_gw_hwnd, $TITLE_GAME_WINDOW)



    Sleep(150)
wend
