; Switch Auto-Scaner for Dolphin Guide software
; Language:       English
; Platform:       Win9x+/NT
; Author:         Will Wade
;
; Script Function:
;   On a press of "Space bar" the script will send the arrow key to scan through a list of options in Dolphin Guide
;   Functions when maximized, minimized to taskbar, or minimized to system tray. Change the timing through the minimised task bar app.
; 
; Controls
;   Ctrl-Shift c : Config window to set the time
;   Ctrl-Shift d : View the time period set
;   F8 or Space: Accept an item on screen and start scanning


; init
#SingleInstance force
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

; Actual working bit

Ins::Suspend
	
F8::
	if (varScanning){
		Send {Enter}
		sleep (DelayTimeMS*2)
		varScanning := false
	} else {
		varScanning := true
		sleep DelayTimeMS
		Loop{
			Send Right
			sleep DelayTimeMS
			F8KeyDown := GetKeyState("F8","P")? 1 : 0
			if (F8KeyDown){
				break
			}
		}
	}
return
