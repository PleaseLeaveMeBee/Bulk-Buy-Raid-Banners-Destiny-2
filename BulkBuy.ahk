#Persistent
#NoEnv
#SingleInstance, Force

; Define a dark mode GUI style
Gui, Color, 1A1A1A
Gui, Font, cFFFFFF s10, Segoe UI

; Hotkey to activate the script
Up::
    ; Prompt the user to enter the number of times to loop
    Gui, New
    Gui, Color, 1A1A1A
    Gui, Font, cFFFFFF s10, Segoe UI
    Gui, Add, Text,, Enter the number of times to loop:
    Gui, Add, Edit, vLoopCount c000000 BackgroundColor=FFFFFF
    Gui, Add, Button, gStartLoop vOKButton, OK
    Gui, Show, w300 h150, Loop Count
    Gui, +OwnDialogs
    return

GuiEscape: ; Handles the Escape key to close the GUI
GuiClose: ; Handles the close button on the GUI
    Gui, Destroy
    return

StartLoop:
    Gui, Submit
    ; Validate the input
    if (LoopCount = "")
    {
        MsgBox, 48, Error, Please enter a valid number.
        Return
    }
    else if (LoopCount is not integer)
    {
        MsgBox, 48, Error, Invalid input. Please enter a valid number.
        Return
    }
    
    ; Hide the input GUI
    Gui, Destroy
    
    ; Start the clicking loop
    Loop, %LoopCount%
    {
        Click down
        Sleep, 3000
        Click up
        Sleep, 250
    }
    
    ; Notify the user that the loop is finished
    Gui, New
    Gui, Color, 1A1A1A
    Gui, Font, cFFFFFF s10, Segoe UI
    Gui, Add, Text,, Finished
    Gui, Add, Button, gExitApp vExitButton, Exit
    Gui, Show, w200 h100, Finished
    Gui, +OwnDialogs
    return

; Hotkey to completely quit the script
Down::ExitApp

; Handle Enter key to trigger buttons
~Enter::
    IfWinActive, Loop Count
    {
        GuiControl, Focus, OKButton
        ControlClick, Button1, Loop Count
    }
    else IfWinActive, Finished
    {
        GuiControl, Focus, ExitButton
        ControlClick, Button1, Finished
    }
    return

ExitApp:
    ExitApp
    return