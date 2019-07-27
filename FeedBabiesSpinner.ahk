#SingleInstance Force
#Include TransSplashText.ahk


;oVoice := ComObjCreate("SAPI.SpVoice")
;Voices := oVoice.GetVoices
;oVoice.Voice := Voices.Item(1)

GuiN := 86
GuiX := 0
GuiY := 30

Enabled := false
GoSub, UpdateGUI

Loop{

	if (Enabled && WinActive("ahk_class UnrealWindow") && CheckDC()){
		EventInfo = Disconnected
		GoSub, UpdateGUI
		;oVoice.Speak("Disconnected")
		SoundPlay, Disconnected.mp3
		Sleep 5000
	}
	else
	{

		if (Enabled && WinActive("ahk_class UnrealWindow")){
			EventInfo = Rotating
			GoSub, UpdateGUI
			;BlockInput, MouseMove
			DllCall("mouse_event", "UInt", 0x01, "UInt", 220, "UInt", 0)
			;BlockInput, MouseMoveOff
			Sleep 250
			Send {f}
			EventInfo = Looking For Inventory
			GoSub, UpdateGUI
			Sleep 1000
		}
		if (Enabled && CheckInv() && WinActive("ahk_class UnrealWindow")){
			;;;;;;;;;;;;;;;;;;;;IN INVENTORY
			EventInfo = Found Inventory
			GoSub, UpdateGUI
			Sleep 500
			X := 0.5*A_ScreenWidth
			;if (A_ScreenWidth>=1920){
				;;;;;;1920x1080
				Y := 0.44*A_ScreenHeight
			;}else{
				;;;;;;1680x1050
				;Y := 0.47*A_ScreenHeight
			;}
			PixelGetColor, Color, %X%, %Y%
			B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF
			if (Enabled &&WinActive("ahk_class UnrealWindow")){
				;BlockInput, MouseMove
				if (R<20 && G>65 && B>100){
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;IN Food Supply
					EventInfo = Food Supply
					GoSub, UpdateGUI
					Sleep 1000
					X := 0.18*A_ScreenWidth
					if (A_ScreenWidth>=1920){
						;;;;;;1920x1080
						Y := 0.18*A_ScreenHeight
					}else{
						;;;;;;1680x1050
						Y := 0.22*A_ScreenHeight
					}
					MouseClick, Left, X, Y, 5
					
					Sleep 500
					X := 0.67*A_ScreenWidth
					if (A_ScreenWidth>=1920){
						;;;;;;1920x1080
						Y := 0.26*A_ScreenHeight
					}else{
						;;;;;;1680x1050
						Y := 0.29*A_ScreenHeight
					}
				}
				else{
					;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;IN Baby
					EventInfo = Feed Baby
					GoSub, UpdateGUI
					Sleep 1500
					
					X := 0.19*A_ScreenWidth
					if (A_ScreenWidth>=1920){
						;;;;;;1920x1080
						Y := 0.27*A_ScreenHeight
					}else{
						;;;;;;1680x1050
						Y := 0.30*A_ScreenHeight
					}
				}
				
			}
			if (Enabled && CheckInv() && WinActive("ahk_class UnrealWindow")){
				EventInfo = Transfering Food
				GoSub, UpdateGUI
				MouseMove, X, Y, 5
				Sleep 100
				Loop, 5{
					Send {t}
					Sleep 500
				}
			}
			;BlockInput, MouseMoveOff
			Send {f}
			EventInfo = Exit Inventory
			GoSub, UpdateGUI
			Sleep 1000
		}
		else{
			if (Enabled &&WinActive("ahk_class UnrealWindow"))
			{
				EventInfo = No Inventory Found
				GoSub, UpdateGUI
			}
		}
	}
	Sleep 1000
}
return

F12::
	Enabled := Enabled ? False : True
	GoSub, UpdateGUI
return

CheckInv(){

	if (A_ScreenWidth>=1920){
		;;;;;;1920x1080
		X := 0.438*A_ScreenWidth
		Y := 0.026*A_ScreenHeight
	}else{
		;;;;;;1680x1050
		X := 0.440*A_ScreenWidth
		Y := 0.08*A_ScreenHeight
	}
	
	PixelGetColor, Color, %X%, %Y%
	B := Color >> 16 & 0xFF, G := Color >> 8 & 0xFF, R := Color & 0xFF

	if (R<165 && G>220 && B>240 && WinActive("ahk_class UnrealWindow"))
		RetVal := true
	else
		RetVal := false
		
	return RetVal
}



CheckDC(){


	Y := 0.560*A_ScreenHeight ;;;;.551-.574
	X1 := 0.390*A_ScreenWidth ;;;;.368
	X2 := 0.450*A_ScreenWidth ;;;;;.470
	X3 := 0.550*A_ScreenWidth ;;;;;.528
	X4 := 0.600*A_ScreenWidth ;;;;;.629
		
	Loop, 4
	{
		X := X%A_Index%
		PixelGetColor, Color, %X%, %Y%
		B%A_Index% := Color >> 16 & 0xFF
		G%A_Index% := Color >> 8 & 0xFF
		R%A_Index% := Color & 0xFF
		if (R%A_Index%<25 && G%A_Index%>69 && B%A_Index%>95)
			Test%A_Index% := 1
		else
			Test%A_Index% := 0
	}
	
	;Tooltip, R1:%R1% G1:%G1% B1:%B1%`nR2:%R2% G2:%G2% B2:%B2%`nR3:%R3% G3:%G3% B3:%B3%`nR4:%R4% G4:%G4% B4:%B4% 
	
	if (Test1=1 && Test2=1 && Test3=1 && Test4=1)
		RetVal := true
	else
		RetVal := false
			
			
	return RetVal
}



UpdateGUI:
	Gui, %GuiN%:Destroy
	
	if Enabled 
	{
		EnabledText := "ON"
	}else{
		EnabledText := "OFF"
	}
	
	TransSplashText_On(GuiN,"F12:", EnabledText, EventInfo, hwndText, hwndTextS,,"White","Black",,GuiX,GuiY)
return
