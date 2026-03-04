;
; src\bot\modules\login\login.au3
;
#include-once

; Shared
#include "..\..\..\config\constants.au3"
#include "..\..\..\config\roles.au3"
#include "..\..\..\utils\logger.au3"

; Local
#include "..\..\state\session.au3"
#include "..\..\config\colors.au3"
#include "..\..\core\window.au3"
#include "..\..\core\scanner.au3"
#include "..\..\config\secret.au3"
; ONLY, in the correct position.
; [0] - role, [0][0] - account name, [0][1] - account password
; local const $sec_accounts_data[5][3] = [ _
;     ["username", "password"], _ ; TANK account
;     ["username", "password"], _ ; HEALER account
;     ["username", "password"], _ ; DPS 0 (first) account
;     ["username", "password"], _ ; DPS 1 (second) account
;     ["username", "password"] _ ; DPS 2 (third) account
; ]

#include "dispatcher.au3"


func enter_to_world()
    local $flag = false
    local $account_username = $sec_accounts_data[$g_role][0]
    local $account_password = $sec_accounts_data[$g_role][1]

    if IsString($account_username) and $account_username <> "" then
        if IsString($account_password) and $account_password <> "" then
            $flag = true
        endif
    endif
    
    if not $flag then
        log_error("Not correct data in sec_account_data, for a role: " & $g_role, $g_gw_hwnd)
        exit 0
    endif

    local $timer = TimerInit()
    local $timeout = 60000

    local $resolution, $coords_dict, $colors_dict

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

        if not $coords_dict then
            $coords_dict = get_coords_dictionary($resolution)
        endif

        if not $colors_dict then
            $colors_dict = get_colors_dictionary($resolution)
        endif

        if TimerDiff($timer) > $timeout then
            exit_error()
        endif

        Sleep(200)

        ;ToolTip("Color: " & $color, @DesktopWidth / 2, 10) ; for check color
        ;$timer = TimerInit()
        ;continueloop

        ; Check disconnect error
        local $coords_dc_err_f = $coords_dict.Item("dc_err_f") ; Coords have with two elements, coords[2]
        local $coords_dc_err_s = $coords_dict.Item("dc_err_s")
        local $colors_dc_err_f = $colors_dict.Item("dc_err_f") ; Simple color in int 255255255
        local $colors_dc_err_s = $colors_dict.Item("dc_err_s")
        local $px_clr_dc_err_f = get_pixel_color($g_gw_hwnd, $coords_dc_err_f[0], $coords_dc_err_f[1])
        local $px_clr_dc_err_s = get_pixel_color($g_gw_hwnd, $coords_dc_err_s[0], $coords_dc_err_s[1])
        if $px_clr_dc_err_f = $colors_dc_err_f and $px_clr_dc_err_s = $colors_dc_err_s then
            continueloop
        endif

        ; Check account or password incorrect error, some times this error show how secure if window and mouse not in game window focus 
        local $coords_incrct_err_f = $coords_dict.Item("incrct_err_f")
        local $coords_incrct_err_s = $coords_dict.Item("incrct_err_s")
        local $colors_incrct_err_f = $colors_dict.Item("incrct_err_f")
        local $colors_incrct_err_s = $colors_dict.Item("incrct_err_s")
        local $px_clr_incrct_err_f = get_pixel_color($g_gw_hwnd, $coords_incrct_err_f[0], $coords_incrct_err_f[1])
        local $px_clr_incrct_err_s = get_pixel_color($g_gw_hwnd, $coords_incrct_err_s[0], $coords_incrct_err_s[1])
        if $px_clr_incrct_err_f = $colors_incrct_err_f and $px_clr_incrct_err_s = $colors_incrct_err_s then
            continueloop
        endif

        ; Check log in screen
        local $coords_lgn_scrn_f = $coords_dict.Item("lgn_scrn_f")
        local $coords_lgn_scrn_s = $coords_dict.Item("lgn_scrn_s")
        local $colors_lgn_scrn_f = $colors_dict.Item("lgn_scrn_f")
        local $colors_lgn_scrn_s = $colors_dict.Item("lgn_scrn_s")
        local $px_clr_lgn_scrn_f = get_pixel_color($g_gw_hwnd, $coords_lgn_scrn_f[0], $coords_lgn_scrn_f[1])
        local $px_clr_lgn_scrn_s = get_pixel_color($g_gw_hwnd, $coords_lgn_scrn_s[0], $coords_lgn_scrn_s[1])
        if $px_clr_lgn_scrn_f = $colors_lgn_scrn_f and $px_clr_lgn_scrn_s = $colors_lgn_scrn_s Then
            ; Check username input
            local $coords_acc_name_f = $coords_dict.Item("acc_name_f")
            local $coords_acc_name_s = $coords_dict.Item("acc_name_s")
            local $colors_acc_name_f = $colors_dict.Item("acc_name_f")
            local $colors_acc_name_s = $colors_dict.Item("acc_name_s")
            local $px_clr_acc_name_f = get_pixel_color($g_gw_hwnd, $coords_acc_name_f[0], $coords_acc_name_f[1])
            local $px_clr_acc_name_s = get_pixel_color($g_gw_hwnd, $coords_acc_name_s[0], $coords_acc_name_s[1])
            if $px_clr_acc_name_f = $colors_acc_name_f and $px_clr_acc_name_s = $colors_acc_name_s then
                ControlSend($g_gw_hwnd, "", "", $account_username, 1)
                Sleep(500)
                ControlSend($g_gw_hwnd, "", "", "{TAB}")
                Sleep(100)
            elseif $px_clr_acc_name_f <> $colors_acc_name_f and $px_clr_acc_name_s <> $colors_acc_name_s then
                local $coords_acc_pass_f = $coords_dict.Item("acc_pass_f")
                local $coords_acc_pass_s = $coords_dict.Item("acc_pass_s")
                local $colors_acc_pass_f = $colors_dict.Item("acc_pass_f")
                local $colors_acc_pass_s = $colors_dict.Item("acc_pass_s")
                local $px_clr_acc_pass_f = get_pixel_color($g_gw_hwnd, $coords_acc_pass_f[0], $coords_acc_pass_f[1])
                local $px_clr_acc_pass_s = get_pixel_color($g_gw_hwnd, $coords_acc_pass_s[0], $coords_acc_pass_s[1])
                if $px_clr_acc_pass_f <> $colors_acc_pass_f and $px_clr_acc_pass_s <> $colors_acc_pass_s then
                    ControlSend($g_gw_hwnd, "", "", $account_password, 1)
                    Sleep(100)
                endif
            endif

            ; Remove auto log in to account, temporarily.

            continueloop
        endif
    
        ; Check select character
        local $coords_slct_char_f = $coords_dict.Item("slct_char_f")
        local $coords_slct_char_s = $coords_dict.Item("slct_char_s")
        local $coords_slct_char_t = $coords_dict.Item("slct_char_t")
        local $colors_slct_char_f = $colors_dict.Item("slct_char_f")
        local $colors_slct_char_s = $colors_dict.Item("slct_char_s")
        local $colors_slct_char_t = $colors_dict.Item("slct_char_t")
        local $px_clr_slct_char_f = get_pixel_color($g_gw_hwnd, $coords_slct_char_f[0], $coords_slct_char_f[1])
        local $px_clr_slct_char_s = get_pixel_color($g_gw_hwnd, $coords_slct_char_s[0], $coords_slct_char_s[1])
        local $px_clr_slct_char_t = get_pixel_color($g_gw_hwnd, $coords_slct_char_t[0], $coords_slct_char_t[1])
        if $px_clr_slct_char_f = $colors_slct_char_f and $px_clr_slct_char_s = $colors_slct_char_s and $px_clr_slct_char_t = $colors_slct_char_t then
            ControlSend($g_gw_hwnd, "", "", "{ENTER}")
            if $g_role = $ROLE_TANK then exit 0 ; TANK main game window, only for log in to world
            continueloop
        endif
        
        ; Check in World
        local $in_world_color = get_pixel_color($g_gw_hwnd, 5, 5)
        if $in_world_color = $COLOR_BLUE then
            exitloop
        endif
    wend
endfunc


func exit_error()
    log_error("Can't log into account, STUCK Log In process, timeout END, for a Role: " & $g_role, $g_gw_hwnd)
    exit 0
endfunc
