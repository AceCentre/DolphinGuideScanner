#SingleInstance,Force
Ins::Suspend

#Persistent
SetTitleMatchMode, 2
DetectHiddenWindows, on

DelayTimeMS := 800
varScanning := false

; Tray Menu functions. I hope people use this.
menu, tray, add ; separator
menu, tray, add, SetAutoScanTime
menu, tray, add, Help


; Main 
Help:
    HelloText =
    (
    Scanning app for Dolphin Guide

    1. Configure switch box to F8 or Space
    2. Run Dolphin Guide

    Usage:
        F8 or Space : Accept an item on screen and start scanning
        Ctrl-Shift c : Config window to set the time
        Ctrl-Shift d : View the time period set
        Ctrl-Shift h : This help box
    )
    MsgBox, %HelloText%
return

^+h::
    MsgBox, %HelloText%
return


SetAutoScanTime:
    Gui, Add, Text,, Delay Time (milliseconds):
    Gui, Add, Edit, r1 vDelayTime, %DelayTimeMS%
    Gui, Add, Button, default, OK
    Gui, Show,, Simple Input Example
    return  
    
    GuiClose:
    ButtonOK:
    Gui, Submit 
    DelayTimeMS := DelayTime
    MsgBox % "The auto-scanning time is " . floor(DelayTimeMS) . " milliseconds."  
    Gui, Destroy
return

^+c::
    gosub, SetAutoScanTime
return

^+d::
    MsgBox % "The Auto-Scan time is " . floor(DelayTimeSec) . "."  
return


right:=0
space::
right:=!right
if(right)
	SetTimer,pressright,%DelayTimeMS%
else{
	SetTimer,pressright,Off
	Send,{enter}
}
return
pressright:
	Send,{right}
return