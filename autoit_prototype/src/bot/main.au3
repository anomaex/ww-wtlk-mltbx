;
; src\bot\main.au3
;
#include-once

Opt("TrayAutoPause", 0) ; Disable AutoIt tray auto-pause


; Shared
#include "..\utils\logger.au3"
#include "..\config\constants.au3"


if $CmdLine[0] <> 2 then exit 0

local $bot_name_title = $PROJECT_NAME & "-bot-" & $CmdLine[1]
AutoItWinSetTitle($bot_name_title)

while true
    Sleep(150)
wend
