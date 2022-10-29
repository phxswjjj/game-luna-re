
#InstallKeybdHook

TraceLog(msg) {
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] %msg%
}
Return

^!x:: ; Control+Alt+X hotkey.
    PixelGetColor, color, 872, 225
    TraceLog(Format("(872, 225) is {1}", color))

Return

^!z::  ; Control+Alt+Z hotkey.
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
WinGetTitle, Title, A
OutputDebug, %Title%: The color at the current cursor position (%MouseX%, %MouseY%) is %color%.

Return

#KeyHistory
