#include-once


local $user_data_dir_path = ""
local $config_file_path = ""


func init_config($path_user_data_dir)
    $user_data_dir_path = $path_user_data_dir
    $config_file_path = $user_data_dir_path & "\config.ini"
    check_create_config_dir()
endfunc


func check_create_config_dir()
   if not FileExists($user_data_dir_path) then
        DirCreate($user_data_dir_path)
    endif
    if not FileExists($config_file_path) then
        FileWrite($config_file_path, "")
    endif
endfunc


func save_path_to_config_file($gw_type_name, $path)
    check_create_config_dir()
    IniWrite($CONFIG_FILE_PATH, "game", $gw_type_name & "_path", $path)
endfunc


func load_path_from_config_file($gw_type_name)
    if FileExists($config_file_path) then
        return IniRead($config_file_path, "game", $gw_type_name & "_path", "")
    endif
    check_create_config_dir()
    return ""
endfunc


; Save run main checkbox to config file
func save_rmcbox_to_config_file($state)
    check_create_config_dir()
    IniWrite($config_file_path, "start", "main_start_cbox", String($state))
endfunc


; Load run main checkbox to config file
func load_rmcbox_from_config_file()
    if FileExists($config_file_path) then
        local $value = IniRead($config_file_path, "start", "main_start_cbox", "")
        if $value = "1" then return true
    else
        check_create_config_dir()
    endif
    return false
endfunc
