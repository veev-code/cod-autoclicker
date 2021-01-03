#SingleInstance force

global Enabled := False
global Primary := True
global UseSecondary := True

HotKey, *LButton, % OnOff()
UpdateToolTip()
Return

; Hotkey to enable/disable script
*XButton1::
	Enabled := !Enabled
	Hotkey, *LButton, % OnOff()
	UpdateToolTip()
	Return

; Hotkey to toggle support for secondary
; If secondary is enabled, holding LMB will spam LMB+RMB (use for, e.g., dual Diamatti's)
; If secondary is disabled, will do nothing (use for, e.g., MAC-10)
*XButton2::
	UseSecondary := !UseSecondary
	UpdateToolTip()
	Return

; When 1 is pressed last, assume we're using primary weapon
~*1::
	Primary := True
	UpdateToolTip()
	Return

; When 2 is pressed last, assume we're using secondary weapon
~*2::
	Primary := False
	UpdateToolTip()
	Return

; Logic for when LMB is pressed
*LButton::
	if (Primary) {
		SetMouseDelay 5
		While GetKeyState("LButton","P")
			Click
	} else if (UseSecondary) {
		SetMouseDelay 5
		While GetKeyState("LButton","P")
			Click
			Click, right
	} else {
		Click
	}
	Return

UpdateToolTip() {
	OnOff := OnOff()
	if (Enabled) {
		Weapon := (Primary) ? "Primary" : "Secondary"
		if (Primary) {
			ToolTip, %OnOff% (%Weapon%), A_ScreenWidth, A_ScreenHeight
		} else {
			SecondaryEnabled := (UseSecondary) ? "Enabled" : "Disabled"
			ToolTip, %OnOff% (%Weapon% - %SecondaryEnabled%), A_ScreenWidth, A_ScreenHeight
		}
	} else {
		ToolTip, %OnOff%, A_ScreenWidth, A_ScreenHeight
	}
	return
}

OnOff() {
	return (Enabled) ? "On" : "Off"
}