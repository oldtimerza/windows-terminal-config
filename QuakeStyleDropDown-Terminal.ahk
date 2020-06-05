#Persistent
SetBatchLines, -1
Process, Priority,, High

Gui +LastFound
hWnd := WinExist()

; Subscribe to win-create events to get the activated window
DllCall( "RegisterShellHookWindow", UInt,hWnd )
MsgNum := DllCall( "RegisterWindowMessage", Str,"SHELLHOOK" )
OnMessage(MsgNum, Func("OnWin"))
Return

OnWin(event, hwnd)
{
  ; WinGetClass, winClass, ahk_id %lParam%
  WinGetClass, winClass, ahk_id %hwnd%
  if (winClass = "CASCADIA_HOSTING_WINDOW_CLASS")
  {
    global activatedWindow
    activatedWindow = -1
  }
  else
  {
    ; 1 is HSHELL_WINDOOWCREATED
    ; 4 is HSHELL_WINDOWACTIVATED
    if (event == 1 || event & 4)
    {
      global activatedWindow
      activatedWindow = -1
      activatedWindow = %hwnd%
    }
  }
}

; Toggle windows terminal using Ctrl,`
^`::ToggleTerminal()

ShowAndPositionTerminal()
{
  WinShow ahk_class CASCADIA_HOSTING_WINDOW_CLASS
  WinActivate ahk_class CASCADIA_HOSTING_WINDOW_CLASS

  WinMove, ahk_class CASCADIA_HOSTING_WINDOW_CLASS,, -5, -10, A_ScreenWidth + 10, A_ScreenHeight,
  Winset, AlwaysOnTop, On, A
}

ToggleTerminal()
{
  global activatedWindow
  WinMatcher := "ahk_class CASCADIA_HOSTING_WINDOW_CLASS"

  DetectHiddenWindows, On

  if WinExist(WinMatcher)
  {
    DetectHiddenWindows, Off

    if WinExist(WinMatcher)
    {
      ; Script sees it without detecting hidden windows, so..
      WinHide ahk_class CASCADIA_HOSTING_WINDOW_CLASS
      if activatedWindow > 0
      {
        WinActivate, ahk_id, %activatedWindow%
        activatedWindow = -1
      }
      else
      {
        Send !{Esc}
      }
    }
    ; Check if its hidden
    else if !WinExist(WinMatcher) || !WinActive(WinMatcher)
    {
      ShowAndPositionTerminal()
    }
  }
  else
  {
    Run "%SCOOP%\apps\windows-terminal\current\WindowsTerminal.exe"
    Sleep, 1000
    ShowAndPositionTerminal()
  }
}