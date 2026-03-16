;
; src\ui\main.au3
;
#include-once

; Shared
#include "..\utils\logger.au3"


Opt("TrayAutoPause", 0) ; Disable AutoIt tray auto-pause

if not FileExists(@ScriptDir & "\run.au3") then
    log_error("Not correct directory for run UI script.")
    exit 0
endif

Opt("GUIOnEventMode", 1) ; Enable events for click on elements, without logic in main loop


; Systems
#include <GUIConstantsEx.au3>

; Shared
#include "..\config\constants.au3"
#include "..\config\roles.au3"

; Local
#include "config\constants.au3"
#include "config\paths.au3"

#include "state\session.au3"

#include "core\file_dialog.au3"
#include "core\process.au3"
#include "core\config_manager.au3"
#include "core\cache_manager.au3"

#include "modules\hotkeys\hotkeys_manager.au3"

#include "assets\style.au3"


local $ui_hwnd = GUICreate($PROJECT_NAME, $STYLE_WIDTH, $STYLE_HEIGHT) ; It's a window handle, hwnd

; --- Game group ---
GUICtrlCreateGroup(" Game ", $STYLE_GRP_LEFT, $STYLE_GRP_TOP, $STYLE_GRP_WIDTH, $STYLE_GRP_GAME_HEIGHT)
GUICtrlCreateLabel("Select the wow.exe file, for MAIN game window:", $STYLE_GRP_GAME_MGW_LBL_LEFT, $STYLE_GRP_GAME_MGW_LBL_TOP, -1, $STYLE_GRP_GAME_MGW_LBL_HEIGHT)
local $mgw_input = GUICtrlCreateInput("", $STYLE_GRP_GAME_MGW_LBL_LEFT, $STYLE_GRP_GAME_MGW_INPT_TOP, $STYLE_GRP_GAME_MGW_INPT_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT, 0x0800) ; mgw - main game window
local $mgw_b_btn = GUICtrlCreateButton("...", $STYLE_GRP_GAME_MGW_B_BTN_LEFT, $STYLE_GRP_GAME_MGW_INPT_TOP, $STYLE_GRP_GAME_MGW_B_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT) ; b - browse, btn - button

GUICtrlCreateLabel("Select the wow.exe file, for OTHER game window:", $STYLE_GRP_GAME_MGW_LBL_LEFT, $STYLE_GRP_GAME_OGW_LBL_TOP, -1, $STYLE_GRP_GAME_MGW_LBL_HEIGHT)
local $ogw_input = GUICtrlCreateInput("", $STYLE_GRP_GAME_MGW_LBL_LEFT, $STYLE_GRP_GAME_OGW_INPT_TOP, $STYLE_GRP_GAME_MGW_INPT_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT, 0x0800) ; ogw - other game client
local $ogw_b_btn = GUICtrlCreateButton("...", $STYLE_GRP_GAME_MGW_B_BTN_LEFT, $STYLE_GRP_GAME_OGW_INPT_TOP, $STYLE_GRP_GAME_MGW_B_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
; -----

; --- Start group ---
GUICtrlCreateGroup(" Start ", $STYLE_GRP_LEFT, $STYLE_GRP_START_TOP, $STYLE_GRP_WIDTH, $STYLE_GRP_START_HEIGHT)
local $start_run_btn = GUICtrlCreateButton("Run", $STYLE_GRP_START_RUN_BTN_LEFT, $STYLE_GRP_START_RUN_BTN_TOP, $STYLE_GRP_START_RUN_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
; -----

; --- Start one by one group ---
GUICtrlCreateGroup(" Start one by one ", $STYLE_GRP_LEFT, $STYLE_GRP_SOBO_TOP, $STYLE_GRP_WIDTH, $STYLE_GRP_START_HEIGHT)
local $sobo_tank_btn = GUICtrlCreateButton("Tank", $STYLE_GRP_GAME_MGW_LBL_LEFT, $STYLE_GRP_SOBO_TANK_BTN_TOP, $STYLE_GRP_SOBO_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
local $sobo_healer_btn = GUICtrlCreateButton("Healer", $STYLE_GRP_SOBO_HEALER_BTN_LEFT, $STYLE_GRP_SOBO_TANK_BTN_TOP, $STYLE_GRP_SOBO_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
local $sobo_dps0_btn = GUICtrlCreateButton("DPS 0", $STYLE_GRP_SOBO_DPS0_BTN_LEFT, $STYLE_GRP_SOBO_TANK_BTN_TOP, $STYLE_GRP_SOBO_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
local $sobo_dps1_btn = GUICtrlCreateButton("DPS 1", $STYLE_GRP_SOBO_DPS1_BTN_LEFT, $STYLE_GRP_SOBO_TANK_BTN_TOP, $STYLE_GRP_SOBO_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
local $sobo_dps2_btn = GUICtrlCreateButton("DPS 2", $STYLE_GRP_SOBO_DPS2_BTN_LEFT, $STYLE_GRP_SOBO_TANK_BTN_TOP, $STYLE_GRP_SOBO_BTN_WIDTH, $STYLE_GRP_GAME_MGW_INPT_HEIGHT)
; -----

init_config($PATH_USER_DATA_DIR)
init_cache($PATH_USER_DATA_DIR)

load_config()
load_cache()

local $block_gui = false ; prevent multi-click, logical block

GUISetOnEvent($GUI_EVENT_CLOSE, "close_ui_event")
GUICtrlSetOnEvent($mgw_b_btn, "mgw_b_btn_click")
GUICtrlSetOnEvent($ogw_b_btn, "ogw_b_btn_click")
GUICtrlSetOnEvent($start_run_btn, "start_run_btn_click")
GUICtrlSetOnEvent($sobo_tank_btn, "sobo_tank_btn_click")
GUICtrlSetOnEvent($sobo_healer_btn, "sobo_healer_btn_click")
GUICtrlSetOnEvent($sobo_dps0_btn, "sobo_dps0_btn_click")
GUICtrlSetOnEvent($sobo_dps1_btn, "sobo_dps1_btn_click")
GUICtrlSetOnEvent($sobo_dps2_btn, "sobo_dps2_btn_click")

GUISetState(@SW_SHOW, $ui_hwnd)

while true
    hotkeys_update()
    Sleep(10)
wend


func set_block_gui($flag)
    if $flag then
        if $block_gui then
            return true
        else
            $block_gui = true
            return false
        endif
    endif
    $block_gui = false
    return false
endfunc


func close_ui_event()
    exit 0
endfunc


func mgw_b_btn_click()
    if set_block_gui(true) then return
    local $path = get_path_from_file_dialog($ui_hwnd)
    if IsString($path) then
        GUICtrlSetData($mgw_input, $path)
        save_path_to_config_file($GW_TYPE_MAIN, $path)
    endif
    set_block_gui(false)
endfunc


func ogw_b_btn_click()
    if set_block_gui(true) then return
    local $path = get_path_from_file_dialog($ui_hwnd)
    if IsString($path) then
        GUICtrlSetData($ogw_input, $path)
        save_path_to_config_file($GW_TYPE_OTHER, $path)
    endif
    set_block_gui(false)
endfunc


func start_run_btn_click()
    if set_block_gui(true) then return
    if question_msg_for_run_all() then
        run_one_by_one($ROLE_TANK)
        run_one_by_one($ROLE_HEALER)
        run_one_by_one($ROLE_DPS_0)
        run_one_by_one($ROLE_DPS_1)
        run_one_by_one($ROLE_DPS_2)
    endif
    set_block_gui(false)
endfunc


func sobo_tank_btn_click()
    if set_block_gui(true) then return
    run_one_by_one($ROLE_TANK)
    set_block_gui(false)
endfunc


func sobo_healer_btn_click()
    if set_block_gui(true) then return
    run_one_by_one($ROLE_HEALER)
    set_block_gui(false)
endfunc


func sobo_dps0_btn_click()
    if set_block_gui(true) then return
    run_one_by_one($ROLE_DPS_0)
    set_block_gui(false)
endfunc


func sobo_dps1_btn_click()
    if set_block_gui(true) then return
    run_one_by_one($ROLE_DPS_1)
    set_block_gui(false)
endfunc


func sobo_dps2_btn_click()
    if set_block_gui(true) then return
    run_one_by_one($ROLE_DPS_2)
    set_block_gui(false)
endfunc


func load_config()
    GUICtrlSetData($mgw_input, load_path_from_config_file($GW_TYPE_MAIN))
    GUICtrlSetData($ogw_input, load_path_from_config_file($GW_TYPE_OTHER))
endfunc


func load_cache()
    for $i = 0 to UBound($g_game_windows) - 1
        $g_game_windows[$i] = HWnd(load_hwnd_from_cache_process_file($i))
    next
endfunc


func question_msg_for_run_all()
    local $state = MsgBox(BitOR(4, 32), "Running ALL game window?", "TANK, HEALER, DPS first, DPS second, DPS third game windows." & @CRLF & "Are you sure you want to run the startup script for the ALL game windows?", -1, $ui_hwnd)
    if $state = 6 then return true
    return false
endfunc


func run_one_by_one($role)
    if not IsInt($role) then return

    local $path = GUICtrlRead(($role = $ROLE_TANK) ? $mgw_input : $ogw_input)
    if StringStripWS($path, 3) = "" then
        log_warning("Not correct path to start wow.exe, check the path: " & $path, $ui_hwnd)
        return
    endif
    $path = StringStripWS($path, 3)

    local $is_wg_running = check_running_game_window($g_game_windows[$role])
    if not $is_wg_running then
        local $launch_dir = StringLeft($path, StringInStr($path, "\", 0, -1) - 1)
        ; Launch only in -d3d9ex, for more stable and performance fps, reduce lags, etc..
        ; WARNING! Need for CORRECT colors.
        local $pid = Run($path & " -d3d9ex", $launch_dir, @SW_SHOWNOACTIVATE)
        if @error then
            log_warning("Can't run game window, wow.exe, path: " & $path & @CRLF & "Launch stopped.", $ui_hwnd)
            return
        endif
        
        local $hwnd = get_hwnd_from_pid($pid, $TITLE_GAME_WINDOW)
        if not IsHWnd($hwnd) or $hwnd = HWnd(0) then
            log_warning("Can't find HWND from PID for game window, wow.exe, path: " & $path & @CRLF & "Launch stopped.", $ui_hwnd)
            return
        endif

        $g_game_windows[$role] = $hwnd
        save_hwnd_to_cache_process_file($role, $hwnd)
        Sleep(100)
    endif

    check_running_bot($role) ; Check bot script, if already running, close and start a new bot script
    Run(@AutoItExe & " " & @ScriptDir & "\src\bot\main.au3 " & $role & " " & $g_game_windows[$role])
endfunc


func check_running_game_window($hwnd)
    if IsHWnd($hwnd) and $hwnd <> HWnd(0) and WinExists($hwnd) then
        local $win_title = WinGetTitle($hwnd)
        if $win_title == $TITLE_GAME_WINDOW then
            return true
        endif
    endif
    return false
endfunc


func check_running_bot($role)
    local $title = $PROJECT_NAME & "_bot_" & $role
    if WinExists($title) then
        WinKill($title)
    endif
endfunc
