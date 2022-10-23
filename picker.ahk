
#InstallKeybdHook

^!z::  ; Control+Alt+Z hotkey.
MouseGetPos, MouseX, MouseY
PixelGetColor, color, %MouseX%, %MouseY%
WinGetTitle, Title, A
OutputDebug, %Title%: The color at the current cursor position (%MouseX%, %MouseY%) is %color%.

#KeyHistory
