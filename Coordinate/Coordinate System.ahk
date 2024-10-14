#NoTrayIcon
Gui, Font, S12 CDefault Bold, Calibri
Gui, Add, GroupBox, x12 y159 w225 h110 , 설정 모드, 창 이름
Gui, Add, GroupBox, x12 y59 w225 h90 , 좌표, 색상
Gui, Add, GroupBox, x12 y279 w225 h60 , 입력
Gui, Add, GroupBox, x12 y349 w225 h60 , 모드

Gui, Font, S11 CDefault Normal, Calibri
Gui, Add, Text, x22 y79 w35 h20 , 좌표
Gui, Add, Text, x92 y79 w35 h20 , 좌표색
Gui, Add, Text, x162 y79 w35 h20 , 찾기
Gui, Add, Text, x202 y79 w30 h20 , 이동
Gui, Add, Text, x22 y99 w70 h19 vi cBlue, NULL
Gui, Add, Text, x92 y99 w70 h19 vcl cBlue, NULL
Gui, Add, Text, x162 y99 w35 h19, F1
Gui, Add, Text, x202 y99 w30 h19, F6
Gui, Add, Text, x22 y119 w70 h18 vi2 cred, NULL
Gui, Add, Text, x92 y119 w70 h18 vcl2 cred, NULL
Gui, Add, Text, x162 y119 w35 h19, F2

Gui, Add, Text, x22 y182 w210 h20 vModeName, Screen 모드
Gui, Add, GroupBox, x12 y202 w225 h1,
Gui, Add, Text, x22 y222 w210 h35 vActWin, 

Gui, Add, Edit, x32 y301 w50 h25 vxx, 0
Gui, Add, Edit, x92 y301 w50 h25 vyy, 0
Gui, Add, Text, x82 y311 w10 h20 , `,

Gui, Add, Radio, x22 y369 w70 h30 Checked vScr gUpdateRadio, Screen
Gui, Add, Radio, x94 y369 w70 h30 vRel gUpdateRadio, Relative
Gui, Add, Radio, x172 y369 w60 h30 vCli gUpdateRadio, Client

Gui, Add, Button, x162 y299 w60 h30 gIn, 전송 [F7]
Gui, Add, Button, x85 y419 w90 h30 gExit, 종료 [F3]

Gui, Font, S14 CDefault Bold, Calibri
Gui, Add, Text, x12 y25 w225 h20 +Center, Find Coordinate && Color

Gui, Show, x820 y1 w249 h462, Find Coordinate & Color
SetTimer, UpdateActiveWindow, 1000  ; 매초 활성 창 이름 업데이트
return

UpdateActiveWindow:
    WinGetActiveTitle, activeWindowTitle
    GuiControl,, ActWin, %activeWindowTitle%
return

UpdateRadio:
GuiControl, text, i, NULL
GuiControl, text, cl, NULL
GuiControl, text, i2, NULL
GuiControl, text, cl2, NULL

UpdateCoordMode:
Gui, Submit, NoHide
if (Rel == 1) {
    SetCoordMode("Relative")
} else if (Scr == 1) {
    SetCoordMode("Screen")
} else if (Cli == 1) {
    SetCoordMode("Client")
}
return

SetCoordMode(mode) {
    if (mode == "Relative") {
        CoordMode, Mouse, Relative
        CoordMode, Pixel, Relative
    } else if (mode == "Screen") {
        CoordMode, Mouse, Screen
        CoordMode, Pixel, Screen
    } else if (mode == "Client") {
        CoordMode, Mouse, Client
        CoordMode, Pixel, Client
    }
GuiControl,, ModeName, %mode% 모드
}

; 1번 좌표로 입력 전송
F7::
In:
Gosub, UpdateCoordMode
GuiControl, text, i, %xx%, %yy%
x := xx
y := yy
PixelGetColor, c, %x%, %y%
GuiControl, text, cl, %c%
return

; 1번 좌표, 컬러 출력
F1::
Gosub, UpdateCoordMode
MouseGetPos, x, y
PixelGetColor, c, %x%, %y%
GuiControl, text, i, %x%, %y%
GuiControl, text, cl, %c%
return

; 2번 좌표, 컬러 출력
F2::
Gosub, UpdateCoordMode
MouseGetPos, x, y
PixelGetColor, c, %x%, %y%
GuiControl, text, i2, %x%, %y%
GuiControl, text, cl2, %c%
return

; 1번, 입력된 좌표 이동
F6::
Gosub, UpdateCoordMode
MouseMove, %x%, %y%
return

; 종료 버튼
F3::
Exit:
ExitApp
