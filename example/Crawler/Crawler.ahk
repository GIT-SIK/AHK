;; TestPage  -> https://deve1oper.tistory.com/6 -> Title crawling

;; Type1
urldownloadtofile,https://deve1oper.tistory.com/6, temp.txt
fileread, check1, temp.txt
fileDelete, temp.txt


;; Type2
winHttp:=ComObjCreate("WinHttp.WinHttpRequest.5.1")
winHttp.Open("GET","https://deve1oper.tistory.com/6")
winHttp.send
check2:=winHttp.ResponseText


del=
(
"
)
StringReplace,check1,check1,%del%,, All
StringReplace,check2,check2,%del%,, All


RegExMatch(check1,"<h3 class=tit_post>(.*)</h3>",tit1)
RegExMatch(check2,"<h3 class=tit_post>(.*)</h3>",tit2)


Gui, Add, Text, x22 y34 w350 h25 +Center,  URLDOWNLOADTOFILE
Gui, Add, Text, x22 y104 w350 h25 +Center, WINHTTP

Gui, Add, Text, x22 y54 w350 h25 vga1 +Left, %tit1%
Gui, Add, Text, x22 y124 w350 h25 vga2 +Left,  %tit2%

Gui, add, statusbar, vsb, Deve1oper.tistory.com/6  :: Title
Gui, Show, w395 h200, Crawler
return