#Include, CaptureScreen.ahk ; assumes it's in the same folder as script

#InstallKeybdHook

TraceLog(msg) {
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] %msg%
}
Return

^!x:: ; Control+Alt+X hotkey.
    MouseMove, 0, 0
    PixelGetColor, color, 538, 845
    TraceLog(Format("(538, 845) is {1}", color))
    
    MouseMove, 538, 845
    FormatTime, FileDate,, MMdd_HHmmss
    CaptureScreen(0, 1, "CaptureScreen_" FileDate ".png")

Return

^!z::  ; Control+Alt+Z hotkey.
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
WinGetTitle, Title, A
OutputDebug, %Title%: The color at the current cursor position (%MouseX%, %MouseY%) is %color%.

Return

#KeyHistory
