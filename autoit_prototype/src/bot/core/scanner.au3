;
; src/bot/core/scanner.au3
;
#include-once

#include <WinAPIGdi.au3>


; Use DWM (Desktop Window Manager) for get pixel on Windowed mode game window
; It's use only client coord without borders
; It's light for cpu and ram
; Return integer format color, use integer for performance
func get_pixel_color($hwnd, $x_pos, $y_pos)
    local $h_dc = _WinAPI_GetDC($hwnd)
    if Not $h_dc then return false

    local $p_color = _WinAPI_GetPixel($h_dc, $x_pos, $y_pos)
    _WinAPI_ReleaseDC($hwnd, $h_dc)
    return $p_color
endfunc
