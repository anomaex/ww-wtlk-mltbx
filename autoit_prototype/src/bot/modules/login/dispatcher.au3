;
; src/bot/modules/login/log_in_data.au3
;
#include-once

#include "..\..\..\utils\logger.au3"

#include "resolutions\1280x1024.au3"
#include "resolutions\3440x1440.au3"


func get_coords_dictionary($resolution)
    local $coords_dictionary_name = "g_" & $resolution & "_COORDS"
    local $coords_dictionary = Eval($coords_dictionary_name)
    if @error then
        log_error("Can't find or broke dictionary: " & $coords_dictionary_name & ", for resolution: " & $resolution)
        exit 0 
    endif
    return $coords_dictionary
endfunc


func get_colors_dictionary($resolution)
    local $colors_dictionary_name = "g_" & $resolution & "_COLORS"
    local $colors_dictionary = Eval($colors_dictionary_name)
    if @error then
        log_error("Can't find or broke dictionary: " & $colors_dictionary_name & ", for screen resolution: " & $resolution)
        exit 0 
    endif
    return $colors_dictionary
endfunc
