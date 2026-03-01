#include-once


func get_hwnd_from_pid($pid, $title_game_window)
    local $timer = TimerInit()
    local $timeout = 15000
    while true
        local $all_windows = WinList($title_game_window)
        for $i = 1 To $all_windows[0][0]
            local $f_hwnd = $all_windows[$i][1]
            if WinGetProcess($f_hwnd) = $pid and BitAND(WinGetState($f_hwnd), 2) then
                return $f_hwnd
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
