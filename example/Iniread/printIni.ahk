iniread,getV1,save.ini,Value1, v1
iniread,getV2,save.ini,Value2, v2
iniread,getV3,save.ini,Value3, v3
iniread,getX3,save.ini,Value3, x3

Gui, Add, Text, x20 y5 w160 h15 +Center, F3 EXIT / F2 RELOAD

Gui, Add, Text, x20 y35 w70 h15 +Center, v1 : 
Gui, Add, Text, x20 y55 w70 h15 +Center, v2 : 
Gui, Add, Text, x20 y75 w70 h15 +Center, v3 : 
Gui, Add, Text, x20 y95 w70 h15 +Center, x3 : 

Gui, Add, Text, x100 y35 w70 h15 +Left, %getV1%
Gui, Add, Text, x100 y55 w70 h15 +Left, %getV2%
Gui, Add, Text, x100 y75 w70 h15 +Left, %getV3%
Gui, Add, Text, x100 y95 w70 h15 +Left, %getX3%

Gui, Show, w210 h140, iniTest

F3::
Exit:
ExitAPP

F2::
reload