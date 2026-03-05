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
#include "modules\hotkeys_receiver.au3"


local $bot_name_title = $PROJECT_NAME & "_bot_" & $CmdLine[1]
AutoItWinSetTitle($bot_name_title)

$g_role = int($CmdLine[1])
$g_gw_hwnd = HWnd($CmdLine[2])

while true
    Sleep(150)
wend
