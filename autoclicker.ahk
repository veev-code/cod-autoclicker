#SingleInstance force

global Enabled := False
Update()
Return

; Hotkey to enable/disable script
*XButton1::
	Enabled := !Enabled
	Update()
	Return

; Logic for when LMB is pressed
*LButton::
	SetMouseDelay 5
	While GetKeyState("LButton","P")
		Click
	Return

Update() {
	if (Enabled) {
		Hotkey, *LButton, On
		ToolTip, On, A_ScreenWidth, A_ScreenHeight
	} else {
		Hotkey, *LButton, Off
		ToolTip, Off, A_ScreenWidth, A_ScreenHeight
	}
}