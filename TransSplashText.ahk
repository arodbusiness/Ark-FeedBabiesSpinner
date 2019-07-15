TransSplashText_On(Number=99,Text1="",Text2="",Text3="",ByRef hwndText3="",ByRef hwndText3S="",Font="",TC="",SC="",TS="",xPos="",yPos="",w="")
{
	If Text = 
		Text = TransSplashText
	If Font = 
		Font = Impact
	If TC = 
		TC = White
	If SC = 
		SC = 828284
	If TS = 
		TS = 16
	If xPos = 
		xPos = Center
	If yPos = 
		yPos = Center
	If w = 
		w = 500
		
	Q = 4
	If SC != 0
	{
		Gui, %Number%:Font, S%TS% C%SC% Q%Q%, %Font%
		Gui, %Number%:Add, Text, x12 y8 hwndhwndText1S, %Text1%

		Gui, %Number%:Font, S%TS% C%SC% Q%Q%, %Font%
		Gui, %Number%:Add, Text, x45 y8 hwndhwndText2S, %Text2%

		Gui, %Number%:Font, S%TS% C%SC% Q%Q%, %Font%
		Gui, %Number%:Add, Text, x85 y8 w%w% -wrap hwndhwndText3S, %Text3%
	
		
		
	}
	
	Gui, %Number%:Font, S%TS% C%TC% Q%Q%, %Font%
	Gui, %Number%:Add, Text, x10 y6 BackgroundTrans hwndhwndText1, %Text1%


	ToggleColor := Text2="ON" ? "Green" : "Red"
	Gui, %Number%:Font, S%TS% C%ToggleColor% Q%Q%, %Font%
	Gui, %Number%:Add, Text, x43 y6 BackgroundTrans hwndhwndText2, %Text2%

	Gui, %Number%:Font, S%TS% C%TC% Q%Q%, %Font%
	Gui, %Number%:Add, Text, x83 y6 w%w% -wrap BackgroundTrans hwndhwndText3, %Text3%

	
	
	
	Gui, %Number%:Color, EEAA99
	Gui, %Number%:+LastFound -Caption +AlwaysOnTop +ToolWindow +E0x20
	WinSet, TransColor, EEAA99
	Gui, %Number%:Show, x%xPos% y%yPos% AutoSize NA, TransSplashTextWindow
	
}

TransSplashText_Update(Text3="",hwnd3="",hwnd3S="")
{
	if (Text3!="")
	{
		GuiControl, Text, %hwnd3%, %Text3%
		GuiControl, Text, %hwnd3S%, %Text3%
	}

}