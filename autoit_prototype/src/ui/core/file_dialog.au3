;
; src\ui\core\file_dialog.au3
;
#include-once


func get_path_from_file_dialog($hwnd)
    local $path = FileOpenDialog("Select the wow.exe file:", @DesktopDir, "(*.exe)", 1, "wow.exe", $hwnd)
    if not @error then return $path
    return false
endfunc
