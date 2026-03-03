;
; src\bot\core\window.au3
;
#include-once


func waiting_game_window($hwnd, $title_game_window)
    if not IsHWnd($hwnd) then
        $hwnd = HWnd($hwnd)
    endif
    local $timer = TimerInit()
    local $timeout = 25000
    while true
        local $all_windows = WinList($title_game_window)
        for $i = 1 To $all_windows[0][0]
            local $f_hwnd = $all_windows[$i][1]
            if $f_hwnd = $hwnd and BitAND(WinGetState($f_hwnd), 2) then
                return true
                exitloop 2
            endif
            sleep(10)
        next
        if TimerDiff($timer) > $timeout then
            exitloop
        endif
        sleep(100)
    wend
    return false
endfunc


func check_win($hwnd, $title_game_window)
    if not WinExists($hwnd) then
        if WinGetTitle($hwnd) <> $title_game_window then 
            exit 0
        endif
    endif
endfunc
