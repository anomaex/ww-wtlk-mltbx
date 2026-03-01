;
; src/ui/modules/hotkeys.au3
;
#include-once


func inpt_space($hwnd)
    ControlSend($hwnd, "", "", "{SPACE}")
    Sleep(5)
endfunc
