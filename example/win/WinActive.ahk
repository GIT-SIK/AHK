#IfWinActive, ahk_class Notepad
#f::
MsgBox (A) NotePad
return

#IfWinActive, ahk_class CalcFrame
#f::
MsgBox (A) CalcFrame
return

#IfWinActive  
#f::
MsgBox (P)
return


;Active WinClose
F4::
if WinActive("ahk_class Notepad") or WinActive("ahk_class" .ClassName)
WinClose
return

;EXIT
F3::
ExitApp