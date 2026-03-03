;
; src\bot\modules\login\resolution\1280x1024.au3
;
#include-once


global $g_1280x1024_COORDS = _init_1280x1024_coords_map()
global $g_1280x1024_COLORS = _init_1280x1024_colors_map()


func _init_1280x1024_coords_map()
    local $d = ObjCreate("Scripting.Dictionary")

    local $dc_err_f = [396, 480]
    $d.Item("dc_err_f") = $dc_err_f
    local $dc_err_s = [852, 481]
    $d.Item("dc_err_s") = $dc_err_s

    local $incrct_err_f = [364, 519]
    $d.Item("incrct_err_f") = $incrct_err_f
    local $incrct_err_s = [814, 520]
    $d.Item("incrct_err_s") = $incrct_err_s

    local $lgn_scrn_f = [526, 501]
    $d.Item("lgn_scrn_f") = $lgn_scrn_f
    local $lgn_scrn_s = [736, 505]
    $d.Item("lgn_scrn_s") = $lgn_scrn_s

    local $acc_name_f = [552, 533]
    $d.Item("acc_name_f") = $acc_name_f
    local $acc_name_s = [718, 536]
    $d.Item("acc_name_s") = $acc_name_s

    local $slct_char_f = [613, 993]
    $d.Item("slct_char_f") = $slct_char_f
    local $slct_char_s = [668, 992]
    $d.Item("slct_char_s") = $slct_char_s
    local $slct_char_t = [692, 940]
    $d.Item("slct_char_t") = $slct_char_t
    
    return $d
endfunc


; raw_color: 16762624, bgr_color: 0xFFC700, use only raw, bgr for testing
func _init_1280x1024_colors_map()
    local $d = ObjCreate("Scripting.Dictionary")

    $d.Item("dc_err_f") = 16762624 ; 0xFFC700
    $d.Item("dc_err_s") = 16762624 ; 0xFFC700

    $d.Item("incrct_err_f") = 458503 ; 0x06FF07
    $d.Item("incrct_err_s") = 458503 ; 0x06FF07

    $d.Item("lgn_scrn_f") = 16762624 ; 0xFFC700
    $d.Item("lgn_scrn_s") = 16762624 ; 0xFFC700

    $d.Item("acc_name_f") = 8421504 ; 0x808080
    $d.Item("acc_name_s") = 8421504 ; 0x808080

    $d.Item("slct_char_f") = 16238336 ; 0xF7C700
    $d.Item("slct_char_s") = 16107793 ; 0xF5C911
    $d.Item("slct_char_t") = 16762624 ; 0xFFC700

    return $d
endfunc
