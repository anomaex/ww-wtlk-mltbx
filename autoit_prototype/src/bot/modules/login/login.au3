;
; src\bot\modules\login\login.au3
;
#include-once

#include "..\..\..\utils\logger.au3"

#include "..\..\..\config\constants.au3"

#include "..\..\state\session.au3"
#include "..\..\config\secret.au3"

#include "..\..\core\window.au3"
#include "..\..\core\scanner.au3"
#include "..\..\core\input.au3"

#include "resolution_manager.au3"


func login_process()
    local $account_username = $sec_accounts_data[$g_role][0]
    local $account_password = $sec_accounts_data[$g_role][1]

    if $account_username = "" and $account_password = "" then
        log_error("Not correct data in sec_account_data, for a role: " & $g_role, $g_gw_hwnd)
        exit 0
    endif

    local $resolution, $x_y_c_dict
    
    local $timer = TimerInit()
    local $timeout = 60000
    local $state = 0
    local $error_count = 0

    while true
        check_win($g_gw_hwnd, $TITLE_GAME_WINDOW)
        
        if not $resolution then
            local $gw_client_size = WinGetClientSize($g_gw_hwnd)
            if @error then
                log_error("Can't get game window client size, for a role: " & $g_role, $g_gw_hwnd)
                exit 0
            endif

            $resolution = $gw_client_size[0] & "x" & $gw_client_size[1]
        endif

          if not $x_y_c_dict then
            $x_y_c_dict = get_x_y_c_dictionary($resolution)
        endif

        if TimerDiff($timer) > $timeout then
            exit_error()
        endif

        Sleep(200)

        ; Log in logic
        
        ; Account name and pass screen logic
        if $state = 0 or ($state >= 1 and $state <= 3) then
            local $inpt_name_pass_f = $x_y_c_dict.Item("inpt_name_pass_f")
            local $inpt_name_pass_s = $x_y_c_dict.Item("inpt_name_pass_s")
            local $px_clr_inpt_name_pass_f = get_pixel_color($g_gw_hwnd, $inpt_name_pass_f[0], $inpt_name_pass_f[1])
            local $px_clr_inpt_name_pass_s = get_pixel_color($g_gw_hwnd, $inpt_name_pass_s[0], $inpt_name_pass_s[1])
            if $state = 0 and($px_clr_inpt_name_pass_f = $inpt_name_pass_f[2] or $px_clr_inpt_name_pass_s = $inpt_name_pass_f[2]) then
                $state = 1
            else
                local $incrrct_name_pass_f = $x_y_c_dict.Item("incrrct_name_pass_f")
                local $incrrct_name_pass_s = $x_y_c_dict.Item("incrrct_name_pass_s")
                local $px_clr_incrrct_name_pass_f = get_pixel_color($g_gw_hwnd, $incrrct_name_pass_f[0], $incrrct_name_pass_f[1])
                local $px_clr_incrrct_name_pass_s = get_pixel_color($g_gw_hwnd, $incrrct_name_pass_s[0], $incrrct_name_pass_s[1])
                if $px_clr_incrrct_name_pass_f = $incrrct_name_pass_f[2] and $px_clr_incrrct_name_pass_s = $incrrct_name_pass_s[2] then
                    input_send($g_gw_hwnd, 0x0D)
                    $error_count += 1
                    if $error_count > 2 then
                        exit_error()
                    endif
                    Sleep(2000)
                    $state = 2
                    $timer = TimerInit()
                    continueloop
                endif                
            endif

            if $state = 1 then
                local $inpt_name_f = $x_y_c_dict.Item("inpt_name_f")
                local $inpt_name_s = $x_y_c_dict.Item("inpt_name_s")
                local $px_clr_inpt_name_f = get_pixel_color($g_gw_hwnd, $inpt_name_f[0], $inpt_name_f[1])
                local $px_clr_inpt_name_s = get_pixel_color($g_gw_hwnd, $inpt_name_s[0], $inpt_name_s[1])
                if $px_clr_inpt_name_f = $inpt_name_f[2] or $px_clr_inpt_name_s = $inpt_name_s[2] then
                    input_text($g_gw_hwnd, $account_username)
                    Sleep(100)
                    input_send($g_gw_hwnd, 0x09)
                    Sleep(100)
                    $state = 2
                    continueloop
                endif
            elseif $state = 2 then
                    input_text($g_gw_hwnd, $account_password)
                    Sleep(100)
                    $state = 3
                    continueloop
            elseif $state = 3 then
                local $inpt_pass_f = $x_y_c_dict.Item("inpt_pass_f")
                local $inpt_pass_s = $x_y_c_dict.Item("inpt_pass_s")
                local $px_clr_inpt_pass_f = get_pixel_color($g_gw_hwnd, $inpt_pass_f[0], $inpt_pass_f[1])
                local $px_clr_inpt_pass_s = get_pixel_color($g_gw_hwnd, $inpt_pass_s[0], $inpt_pass_s[1])
                if $px_clr_inpt_pass_f = $inpt_pass_f[2] or $px_clr_inpt_pass_s = $inpt_pass_s[2] then
                    input_send($g_gw_hwnd, 0x0D)
                    Sleep(100)
                    $state = 10
                    $timer = TimerInit()
                    continueloop
                endif
            endif
        endif

        ; Select character screen logic
        if $state = 0 or $state >= 10 then
            local $slct_char_f = $x_y_c_dict.Item("slct_char_f")
            local $slct_char_s = $x_y_c_dict.Item("slct_char_s")
            local $px_clr_slct_char_f = get_pixel_color($g_gw_hwnd, $slct_char_f[0], $slct_char_f[1])
            local $px_clr_slct_char_s = get_pixel_color($g_gw_hwnd, $slct_char_s[0], $slct_char_s[1])
            if $px_clr_slct_char_f = $slct_char_f[2] or $px_clr_slct_char_s = $slct_char_s[2] then
                local $slct_char_t = $x_y_c_dict.Item("slct_char_t")
                local $px_clr_slct_char_t = get_pixel_color($g_gw_hwnd, $slct_char_t[0], $slct_char_t[1])
                if $px_clr_slct_char_t <> $slct_char_t[2] then
                    input_send($g_gw_hwnd, 0x0D)
                    Sleep(100)
                    $state = 20
                    $timer = TimerInit()
                    if $g_role = 0 then exit 0 ; tank window only for log in logic
                    continueloop
                endif
            endif
        endif

        ; In world screen logic
        if $state = 0 or $state >= 20 then
            local $in_world_f = $x_y_c_dict.Item("in_world_f")
            local $px_clr_in_world_f = get_pixel_color($g_gw_hwnd, $in_world_f[0], $in_world_f[1])
            if $px_clr_in_world_f = $in_world_f[2] then
                exitloop
            endif
        endif
    wend
endfunc


func exit_error()
    log_error("Can't log into account, STUCK Log In process, timeout END, for a role: " & $g_role, $g_gw_hwnd)
    exit 0
endfunc
