; Coordinate System
; 업데이트 내역
; 1.00V - 버전 
; 2.00V - 버전 [ GUI 재 구성]
; 2.10V - GUI : Option 단추 추가로 인한 GUI 재 구성
; 2.11V - Source : Option 단추 추가로 인한 Source 추가
; 3.21V - GUI : GUI Edit 입력란 추가
; 3.22V - Source : Edit 입력란 추가로 인한 변수 값 수정
; 3.23V - Source : 3.21V 오류로 인한 재 수정
; 3.33V - 버전 [ GUI 재 구성]
; 3.43V - GUI : Edit 입력에 따른 좌표값 란 추가
; 3.44V - Source : GUI Edit 입력에 따른 좌표값 수정 
; 3.45V - Source : Pixel 오차범위 이상 오류로 값 수정
; 3.56V - SG : 좌표버튼 및 Gui 설명서 재 수정



#NoTrayIcon




Gui, Font, S9 CDefault, Verdana
Gui, Add, Text, x22 y79 w80 h20 , 좌표
Gui, Add, Text, x112 y79 w70 h20 , 좌표색
Gui, Add, Text, x22 y99 w90 h19 vi cBlue, NULL
Gui, Add, Text, x112 y99 w90 h19 vcl cBlue, NULL
Gui, Add, Text, x22 y119 w90 h19 vi2 cred, NULL
Gui, Add, Text, x112 y119 w90 h19 vcl2 cred, NULL
Gui, Add, GroupBox, x12 y59 w200 h80 , 위치영역

Gui, Add, Edit, x22 y169 w50 h20 vxx, 0
Gui, Add, Edit, x82 y169 w50 h20 vyy, 0
Gui, Add, Text, x72 y179 w10 h20 , `,
Gui, Add, GroupBox, x12 y149 w200 h60 , 입력영역

Gui, Add, GroupBox, x12 y219 w200 h60 , CoordMode
Gui, Add, Radio, x22 y239 w90 h30 vRel, Relative
Gui, Add, Radio, x112 y239 w90 h30 vScr, Screen

Gui, Add, Button, x142 y169 w50 h30 gin, 전송
Gui, Add, Button, x122 y339 w90 h30 gbtn, 종료 [F3]
Gui, Add, Button, x22 y339 w90 h30 gMv, 좌표이동 [F6]

Gui, Add, Text, x12 y289 w190 h20 +Center, 1좌표 F1 / 2좌표 F2 / 종료 F3
Gui, Add, Text, x12 y309 w190 h20 +Center, 좌표전송 F7 / 좌표이동 F6

Gui, Font, S10 CDefault Bold, Verdana

Gui, Add, Text, x12 y20 w200 h30 +Center, Find Coordinate & Color System

Gui, Font, S7 CDefault Bold, Verdana

Gui, Add, Text, x195 y3 w200 h15 , 3.56V

Gui, Show, x820 y1 w229 h387, Find Coordinate & Color
return



F7::
in:
Gui,submit,nohide
CoordMode, Pixel, Screen
GuiControl, text, i, %xx% ,%yy%
x:=xx
y:=yy
x1:=xx-1
y1=%yy%
PixelGetColor,c,%x1%,%y1%
GuiControl, text, cl, %c%
return



F1::

Gui,submit,nohide
if(Rel==1)
{
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
}
else if(Scr==1)
{
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
}
else
{
msgbox,,Error, [Click] Audio Box Rel & Scr 
return
}
Mousegetpos,x,y
x1:=x-1
y1=%y%
PixelGetColor,c,%x1%,%y1%
GuiControl, text, i, %x% ,%y%
GuiControl, text, cl, %c%
return 

F6::
Mv:
CoordMode, Mouse, Screen
MouseMove, %x%, %y%
return

F2::
Gui,submit,nohide
if(Rel==1)
{
CoordMode, Mouse, Relative
CoordMode, Pixel, Relative
}
else if(Scr==1)
{
CoordMode, Mouse, Screen
CoordMode, Pixel, Screen
}
else
{
msgbox,,Error, [Click] Audio Box Rel & Scr 
return
}
Mousegetpos,x,y
x1:=x-1
y1=%y%
PixelGetColor,c,%x1%,%y1%
GuiControl, text, i2, %x% ,%y%
GuiControl, text, cl2, %c%
return 

F3::
btn:
ExitApp


