;
; src\utils\logger.au3
;
#include-once


func log_error($msg, $parent_hwnd = 0)
    $msg = String($msg) & @CRLF & "The game window and script has been terminated."
    if IsHWnd($parent_hwnd) and $parent_hwnd <> HWnd(0) then
        MsgBox(16, "ERROR", $msg, -1, $parent_hwnd)
    else
        MsgBox(16, "ERROR", $msg)
    endif
endfunc


func log_debug($msg, $parent_hwnd = 0)
    if IsHWnd($parent_hwnd) and $parent_hwnd <> HWnd(0) then
        MsgBox(0, "DEBUG", String($msg), -1, $parent_hwnd)
    else
        MsgBox(0, "DEBUG", String($msg))
    endif
endfunc


func log_warning($msg, $parent_hwnd = 0)
    if IsHWnd($parent_hwnd) and $parent_hwnd <> HWnd(0) then
        MsgBox(48, "WARNING", String($msg), -1, $parent_hwnd)
    else
        MsgBox(48, "WARNING", String($msg))
    endif
endfunc
