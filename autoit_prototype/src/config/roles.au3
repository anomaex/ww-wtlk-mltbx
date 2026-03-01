;
; src/config/roles.au3
;
#include-once


global enum $ROLE_TANK, $ROLE_HEALER, $ROLE_DPS_0, $ROLE_DPS_1, $ROLE_DPS_2


func get_role_name($role)
    switch $role
        case $ROLE_TANK
            return "TANK"
        case $ROLE_HEALER
            return "HEALER"
        case $ROLE_DPS_0
            return "DPS first"
        case $ROLE_DPS_1
            return "DPS second"
        case $ROLE_DPS_2
            return "DPS third"
    endswitch
    return -1
endfunc
