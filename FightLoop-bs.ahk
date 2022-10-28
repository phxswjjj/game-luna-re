AppTitle := "BlueStacks App Player"
UniqueID := WinExist(AppTitle)
if not UniqueID {
    OutputDebug, "[%AppTitle%] not found"
    Return
}

FormatTime, CurrentDateTime, , HH:mm:ss
Return

StartFight() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 872, 225
    if color != 0x88A76F
    {
        Return False
    }
    Click, 658 935
    Return True
}

SkipLevelup() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 746, 610
    if color = 0xC39C66
    {
        Click, 946, 845
        Sleep, 1000
    }
    Return True
}
SkipOthers() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 901, 472
    if color = 0xA0A097
    {
        Click, 947, 753
        Sleep, 1000
    }
    Return True
}

PickGift() {
    SkipLevelup()
    SkipOthers()

    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 805, 211
    if color != 0x333DBA
    {
        Return False
    }
    PixelGetColor, color, 850, 725
    if color != 0x494A56
    {
        Return False
    }
    Click, 922, 689
    Sleep, 1000
    Click, 940, 928
    Return True
}

FightAgain() {
    WinActivate, ahk_id %UniqueID%
    PixelGetColor, color, 857, 168
    If color != 0x333DBA
    {
        Return False
    }
    Click, 1393, 980
    Return True
}

^!x:: ; Control+Alt+X hotkey.
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] Start

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

        ; 進入戰鬥
        If Not StartFight()
        {
            OutputDebug, [%CurrentDateTime%] 進入戰鬥 not found
            Break
        }

        ; 等 3 分鐘
        Sleep, 3 * 60 * 1000

        ; 戰鬥結算，選禮物
        If Not PickGift()
        {
            OutputDebug, [%CurrentDateTime%] 戰鬥結算(禮物) not found
            Break
        }
        Sleep, 2000

        ; 重試
        If Not FightAgain()
        {
            ; 等待 1 分鐘後重試
            Sleep, 60 * 1000
            If Not FightAgain()
            {
                OutputDebug, [%CurrentDateTime%] 重試 not found
                Break
            }
        }
        Sleep, 2000
    }
    FormatTime, CurrentDateTime,, HH:mm:ss
    OutputDebug, [%CurrentDateTime%] Exit While

Return

^!z:: ; Control+Alt+Z hotkey.
    OutputDebug, "Z pressed"
    OutputDebug, [%CurrentDateTime%] Stopped
ExitApp