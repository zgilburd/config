if not A_IsAdmin
{
  Run *RunAs "%A_ScriptFullPath%" 
  ExitApp
}

;Disable Win+L on script load
RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1

;Remap locking function to Win+Z
#Z::
  ; re-enable locking workstation, then lock it
  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0
  DllCall("LockWorkStation")
;after locking workstation force a reload of this script which effectively disables Win + L locking the computer again, but LAlt + L will lock it
  Sleep, 3000
  RegWrite, REG_DWORD, HKEY_CURRENT_USER, Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
return

;Who uses capslock anyway?
Capslock::Ctrl

;Turn off that damn narrator
#Enter::
return