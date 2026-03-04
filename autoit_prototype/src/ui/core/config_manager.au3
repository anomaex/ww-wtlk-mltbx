;
; src\ui\core\config_manager.au3
;
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
