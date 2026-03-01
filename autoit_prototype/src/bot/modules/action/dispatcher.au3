;
; src/bot/modules/action/dispatcher.au3
;
#include-once

#include "..\..\..\utils\logger.au3"
#include "..\..\config\session.au3"
#include "common.au3"

#include "profiles\druid_restoration.au3"
#include "profiles\paladin_retribution.au3"


func dispatch_action()
    if common_update_state() then return

    local $profile_func = "execute_" & $g_current_profile
    Call($profile_func)
    if @error then
        log_error("Can't find or broke function: " & $profile_func)
        exit 0
    endif
endfunc
