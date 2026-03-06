;
; src\bot\modules\login\resolution_manager.au3.au3
;
#include-once

#include "..\..\..\utils\logger.au3"

#include "resolutions\1280x1024.au3"
#include "resolutions\3440x1440.au3"


func get_x_y_c_dictionary($resolution)
    local $dictionary_name = "g_" & $resolution & "_x_y_c_dictionary"
    local $dictionary = Eval($dictionary_name)
    if @error then
        log_error("Can't find or broke dictionary: " & $dictionary_name & ", for resolution: " & $resolution)
        exit 0 
    endif
    return $dictionary
endfunc
