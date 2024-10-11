
;; 기본적인 GUI 생성한다.
;; - 예제
;; 메뉴, 그룹박스, 상태표시줄 생성

;; * 메뉴 생성
;; - 서브메뉴 생성
menu, files, add, Reload, re
menu, files, add, Close , Exit
menu, hidden1, add, Menu1  , MenuTest
menu, hidden1, add, Menu2 , MenuTest


;; - 메뉴 생성
menu, myMenu, add, Tools, :files
menu, myMenu, add, SubMenu, :hidden1

;; - 메뉴바 생성
gui, menu, myMenu


;; 그룹 박스 생성

Gui, Add, GroupBox, x12 y39 w150 h60 +Center, GroupA
Gui, Add, Text, x22 y54 w50 h14 vgb1 +Center,  TextA
Gui, Add, Text, x22 y78 w130 h18 vgb2 +Center,  TextB

Gui, Add, GroupBox, x182 y39 w150 h60 +Center, GroupB
Gui, Add, Text, x192 y54 w50 h14 vga1 +Center, TextA
Gui, Add, Text, x192 y78 w130 h18 vga2 +Center,  TextB

;; 상태표시줄 생성
gui, add, statusbar, vsb,  StatusBar

Gui, Show, w345 h400, GUITitle
return


;; hidden1 서브 메뉴에 관한 Goto
MenuTest:
return

;; 재시작
re:
reload

;; 종료
GuiClose:
Exit:
ExitAPP


