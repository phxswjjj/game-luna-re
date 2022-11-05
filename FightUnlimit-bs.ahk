AppTitle := "BlueStacks App Player"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss
Return

TraceLog(msg) {
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] %msg%
}

IsNoEnergy() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 685, 747
    if color != 0x5379AD
    {
        Return False
    }
    PixelGetColor, color, 836, 738
    if color != 0xD3E8FB
    {
        Return False
    }
    Return True
}

SetFightRepeat() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 538, 845
    If color = 0xCCFF92
    {
        Return True
    }
    Click, 649, 838
    Sleep, 500
    Click, 880, 342
    Sleep, 200
    Click, 952, 852
    
    Sleep, 3000
    PixelGetColor, color, 538, 845
    If color = 0xCCFF92
    {
        Return True
    }
    TraceLog(Format("(538, 845) is {1}", color))
    Return False
}

StartFightUnlimit() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 872, 225
    if color != 0x88A76F
    {
        TraceLog(Format("(872, 225) is {1}", color))
        Return False
    }
    Click, 658 935
    Sleep, 500

    PixelGetColor, color, 1024, 734
    if color != 0x4D5065
    {
        TraceLog(Format("(1024, 734) is {1}", color))
        Return False
    }
    Click, 1024, 734
    Return True
}

^!x:: ; Control+Alt+X hotkey.
    TraceLog("Start")
    
    IfWinNotActive, ahk_id %UniqueID%
    {
        WinActivate, ahk_id %UniqueID%
    }
    If Not SetFightRepeat()
    {
        TraceLog("設置重複戰鬥失敗")
        Return
    }
    If Not StartFightUnlimit()
    {
        TraceLog("進入戰鬥失敗")
        Return
    }

    While True
    {
        FormatTime, CurrentDateTime,, HH:mm:ss
        IfWinNotActive, ahk_id %UniqueID%
        {
            WinActivate, ahk_id %UniqueID%
            ; OutputDebug, [%CurrentDateTime%] [%AppTitle%] not Active
            Sleep, 1000
            Continue
        }

        ; 行動力耗盡
        If IsNoEnergy()
        {
            ; 等行動力恢復、關閉行動力視窗
            TraceLog("等行動力恢復")
            Sleep, 48 * 60 * 1000
            WinActivate, ahk_id %UniqueID%
            Click, 1553, 395

            Sleep, 1000
            ; 設置重複戰鬥
            If Not SetFightRepeat()
            {
                TraceLog("設置重複戰鬥失敗")
                Break
            }
            If Not StartFightUnlimit()
            {
                TraceLog("進入戰鬥失敗")
                Break
            }
            TraceLog("進入戰鬥")
            Continue
        }

        Sleep, 60 * 1000
    }
    TraceLog("Exit While")

Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp