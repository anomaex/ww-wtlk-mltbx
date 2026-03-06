;
; src\bot\modules\login\resolution\1280x1024.au3
;
#include-once


global $g_1280x1024_x_y_c_dictionary = _init_1280x1024_x_y_c_map()


func _init_1280x1024_x_y_c_map()
    local $d = ObjCreate("Scripting.Dictionary")

    local $inpt_name_pass_f = [525, 501, 16762624] ; 0xFFC700
    $d.Item("inpt_name_pass_f") = $inpt_name_pass_f
    local $inpt_name_pass_s = [704, 500, 16762624]
    $d.Item("inpt_name_pass_s") = $inpt_name_pass_s
    
    local $inpt_name_f = [552, 534, 8421504] ; 0x808080
    $d.Item("inpt_name_f") = $inpt_name_f
    local $inpt_name_s = [702, 534, 8421504]
    $d.Item("inpt_name_s") = $inpt_name_s

    local $inpt_pass_f = [541, 624, 16777215] ; 0xFFFFFF
    $d.Item("inpt_pass_f") = $inpt_pass_f
    local $inpt_pass_s = [562, 624, 16777215]
    $d.Item("inpt_pass_s") = $inpt_pass_s


    local $slct_char_f = [618, 992, 14201361] ; 0xD8B211
    $d.Item("slct_char_f") = $slct_char_f
    local $slct_char_s = [664, 992, 14201361]
    $d.Item("slct_char_s") = $slct_char_s

    local $in_world_f = [5, 5, 255] ; 0x0000FF
    $d.Item("in_world_f") = $in_world_f

    ; Errors
    local $incrrct_name_pass_f = [364, 526, 458503] ; 0x06FF07
    $d.Item("incrrct_name_pass_f") = $incrrct_name_pass_f
    local $incrrct_name_pass_s = [813, 521, 458503]
    $d.Item("incrrct_name_pass_s") = $incrrct_name_pass_s

    return $d
endfunc
