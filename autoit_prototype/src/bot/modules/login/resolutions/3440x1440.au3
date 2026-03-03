;
; src\bot\modules\login\resolution\3440x1440.au3
;
#include-once


global $g_3440x1440_COORDS = _init_3440x1440_coords_map()
global $g_3440x1440_COLORS = _init_3440x1440_colors_map()


func _init_3440x1440_coords_map()
    local $d = ObjCreate("Scripting.Dictionary")

    local $dc_err_f = [1399, 669]
    $d.Item("dc_err_f") = $dc_err_f
    local $dc_err_s = [2040, 683]
    $d.Item("dc_err_s") = $dc_err_s

    local $incrct_err_f = [1519, 710]
    $d.Item("incrct_err_f") = $incrct_err_f
    local $incrct_err_s = [1863, 749]
    $d.Item("incrct_err_s") = $incrct_err_s

    local $lgn_scrn_f = [1564, 705]
    $d.Item("lgn_scrn_f") = $lgn_scrn_f
    local $lgn_scrn_s = [1864, 707]
    $d.Item("lgn_scrn_s") = $lgn_scrn_s

    local $acc_name_f = [1593, 754]
    $d.Item("acc_name_f") = $acc_name_f
    local $acc_name_s = [1816, 754]
    $d.Item("acc_name_s") = $acc_name_s

    local $slct_char_f = [1682, 1395]
    $d.Item("slct_char_f") = $slct_char_f
    local $slct_char_s = [1758, 1395]
    $d.Item("slct_char_s") = $slct_char_s
    local $slct_char_t = [1791, 1324]
    $d.Item("slct_char_t") = $slct_char_t
    
    return $d
endfunc


; raw_color: 16762624, bgr_color: 0xFFC700, use only raw, bgr for testing
func _init_3440x1440_colors_map()
    local $d = ObjCreate("Scripting.Dictionary")

    $d.Item("dc_err_f") = 16762624 ; 0xFFC700
    $d.Item("dc_err_s") = 16762624 ; 0xFFC700

    $d.Item("incrct_err_f") = 454150 ; 0x06EE06
    $d.Item("incrct_err_s") = 16762624 ; 0xFFC700

    $d.Item("lgn_scrn_f") = 16762624 ; 0xFFC700
    $d.Item("lgn_scrn_s") = 16762624 ; 0xFFC700

    $d.Item("acc_name_f") = 8421504 ; 0x808080
    $d.Item("acc_name_s") = 8421504 ; 0x808080

    $d.Item("slct_char_f") = 16107797 ; 0xF5C915
    $d.Item("slct_char_s") = 15778050 ; 0xF0C102
    $d.Item("slct_char_t") = 16762624 ; 0xFFC700

    return $d
endfunc
