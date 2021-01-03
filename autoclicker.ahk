#SingleInstance force

; Default to disabled
global Toggle := False
; Default to primary weapon
global Primary := True

HotKey, *LButton, % OnOff()
UpdateToolTip()
Return

; Hotkey to enable/disable script
*XButton1::
	Toggle := !Toggle
	Hotkey, *LButton, % OnOff()
	UpdateToolTip()
	Return

~*1::
	Primary := True
	UpdateToolTip()
	Return

~*2::
	Primary := False
	UpdateToolTip()
	Return

; Logic for when LMB is pressed
*LButton::
	SetMouseDelay 5
	While GetKeyState("LButton","P")
		Click
		if (!Primary) {
			Click, right
		}
	Return

UpdateToolTip() {
	OnOff := OnOff()
	if (Toggle) {
		Weapon := (Primary) ? "Primary" : "Secondary"
		ToolTip, %OnOff% (%Weapon%), A_ScreenWidth, A_ScreenHeight
	} else {
		ToolTip, %OnOff%, A_ScreenWidth, A_ScreenHeight
	}
    return
}

OnOff() {
	return (Toggle) ? "On" : "Off"
}