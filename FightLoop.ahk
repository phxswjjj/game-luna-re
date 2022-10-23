AppTitle := "Luna Re"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss
Return

^!x:: ; Control+Alt+X hotkey.
    OutputDebug, [%CurrentDateTime%] Start

    While True
    {
        IfWinNotActive, ahk_id %UniqueID%
        {
            OutputDebug, [%CurrentDateTime%] [%AppTitle%] not Active
            Sleep, 1000
            Continue
        }
        
        PixelSearch, Px, Py, 158, 1071, 158, 1071, 0x3C3628, 3, Fast
        if ErrorLevel {
            ; OutputDebug, "戰鬥中 not found"
            Sleep, 1000
            Continue
        } else {
            OutputDebug, "戰鬥中 Wait 2 mins"
            Send {Esc}
            Sleep, 2 * 60 * 1000
            Send {Esc}
            Sleep, 2 * 60 * 1000
            Continue
        }
    }

Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp