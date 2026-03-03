;
; src\bot\config\secret.au3
;
#include-once


; DON'T WRITE YOUR PERSONAL DATA HERE
; DON'T WRITE YOUR PERSONAL DATA HERE
; DON'T WRITE YOUR PERSONAL DATA HERE
; DON'T WRITE YOUR PERSONAL DATA HERE
; DON'T WRITE YOUR PERSONAL DATA HERE


; It's only sample/template how need to create secret.au3
; It's only sample/template how need to create secret.au3
; It's only sample/template how need to create secret.au3


; ONLY, in the correct position.
; [0] - role, [0][0] - account name, [0][1] - account password
local const $sec_accounts_data[5][3] = [ _
    ["account_name", "password"], _ ; TANK account
    ["account_name", "password"], _ ; HEALER account
    ["account_name", "password"], _ ; DPS 0 (first) account
    ["account_name", "password"], _ ; DPS 1 (second) account
    ["account_name", "password"] _ ; DPS 2 (third) account
]

; ONLY, in right position
; [0] - account role, [0][0] - class, [0][1] - spec
; Without TANK, because it's a main window. You are in control of the situation.
local const $sec_classes_and_specs[4][2] = [ _
    ["druid", "restoration"], _ ; HEALER account
    ["paladin", "retribution"], _ ; DPS 0 (first) account
    ["paladin", "retribution"], _ ; DPS 1 (second) account
    ["paladin", "retribution"] _ ; DPS 2 (third) account
]