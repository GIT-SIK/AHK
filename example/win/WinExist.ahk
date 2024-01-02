; WinExist, WinActivate, WinMove

F4::

msgbox EXIST

IfWinExist, Untitled.txt
{
MsgBox Exist Notepad
WinActivate
WinMove, 30, 30
return
}

IfWinNotExist, Untitled.txt
{
MsgBox !Exist Notepad
return
}

EXIT
F3::
Exitapp