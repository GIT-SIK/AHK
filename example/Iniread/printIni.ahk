iniread,gtimeSetValue1,save.ini,gtimeSet1, gt1
iniread,gtimeSetValue2,save.ini,gtimeSet2, gt2
iniread,gtimeSetValue3,save.ini,gtimeSet3, gt3

Gui, Add, Text, x20 y5 w160 h10 +Center, F3 EXIT / F2 RELOAD
Gui, Add, Text, x100 y35 w70 h10 +Center, %gtimeSetValue1%
Gui, Add, Text, x100 y55 w70 h10 +Center, %gtimeSetValue2%
Gui, Add, Text, x100 y75 w70 h10 +Center, %gtimeSetValue3%

Gui, Show, w210 h140, iniTest

F3::
Exit:
ExitAPP

F2::
reload