#SingleInstance force

global Enabled := False
global Primary := True
global EnableSecondary := True

Update()
Return

; Hotkey to enable/disable script
*XButton1::
	Enabled := !Enabled
	Update()
	Return

; Hotkey to toggle support for secondary
; If secondary is enabled, holding LMB will spam LMB+RMB (use for, e.g., dual Diamatti's)
; If secondary is disabled, will do nothing (use for, e.g., MAC-10)
*XButton2::
	EnableSecondary := !EnableSecondary
	Update()
	Return

; When 1 is pressed last, assume we're using primary weapon
~*1::
	Primary := True
	Update()
	Return

; When 2 is pressed last, assume we're using secondary weapon
~*2::
	Primary := False
	Update()
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

Update() {
	if (Enabled) {
		if (Primary) {
			Hotkey, *LButton, On
			ToolTip, On (Primary), A_ScreenWidth, A_ScreenHeight
		} else {
			if (EnableSecondary) {
				Hotkey, *LButton, On
				ToolTip, On (Secondary - Enabled), A_ScreenWidth, A_ScreenHeight
			} else {
				Hotkey, *LButton, Off
				ToolTip, On (Secondary - Disabled), A_ScreenWidth, A_ScreenHeight
			}
		}
	} else {
		Hotkey, *LButton, Off
		ToolTip, Off, A_ScreenWidth, A_ScreenHeight
	}
}