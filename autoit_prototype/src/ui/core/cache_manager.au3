;
; src\ui\core\cache_manager.au3
;
#include-once


local $user_data_dir_path = ""
local $cache_dir_path = ""
local $cache_process_file_path = ""


func init_cache($path_user_data_dir)
    $user_data_dir_path = $path_user_data_dir
    $cache_dir_path = $user_data_dir_path & "\cache"
    $cache_process_file_path = $cache_dir_path & "\process.ini"
    check_create_cache_dir()
endfunc


func check_create_cache_dir()
   if not FileExists($user_data_dir_path) then
        DirCreate($user_data_dir_path)
    endif
    if not FileExists($cache_dir_path) then
        DirCreate($cache_dir_path)
    endif
    if not FileExists($cache_process_file_path) then
        FileWrite($cache_process_file_path, "")
    endif
endfunc


func save_hwnd_to_cache_process_file($role, $hwnd)
    check_create_cache_dir()
    IniWrite($cache_process_file_path, "hwnd", "gw_role_" & $role, $hwnd)
endfunc


func load_hwnd_from_cache_process_file($role)
    if FileExists($cache_process_file_path) then
        return IniRead($cache_process_file_path, "hwnd", "gw_role_" & $role, "0")
    else
        check_create_cache_dir()
    endif
    return "0"
endfunc
