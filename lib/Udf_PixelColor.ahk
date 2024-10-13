#Include Acc.ahk ; Acc 라이브러리를 포함
#Include Gdip_All.ahk ; GDI+ 라이브러리 포함

 If !pToken := Gdip_Startup()
 {
  MsgBox, 48, , Gdip ERROR
  return
 }

; (Title 기준)  비활성 창의 픽셀 컬러를 검색하여 컬러를 리턴하는 함수
; winTitle			창 이름 입력
; windowIndex		중복된 창에 대해 몇 번째 창에서 작업할 건지 인덱스 입력 

InactivePixelGetColorTitle(winTitle, x, y, windowIndex := 0)
{
    if (windowIndex = 0) {
        ; 창 제목으로 픽셀 색상 가져오기
        WinGet, hwnd, ID, %winTitle%
    } else {
        ; 주어진 제목을 가진 모든 창의 ID 목록 가져오기
        WinGet, idList, List, %winTitle%
        
        ; 주어진 창 인덱스가 목록의 범위 내에 있는지 확인
        if (windowIndex <= idList) {
            hwnd := idList[windowIndex] ; 지정한 창 인덱스의 핸들 가져오기
        } else {
            MsgBox, "지정한 순서의 창이 없습니다."
            return ""
        }
    }

    hwnd := Acc_ObjectFromWindow(hwnd, -16) ; 비활성화된 창의 객체 가져오기
    pBitmap := Gdip_BitmapFromHWND(hwnd)
    color := Gdip_GetPixel(pBitmap, x, y)
    Gdip_DisposeImage(pBitmap)
    return color
}

; RGB 값으로 변환
SetColorInGui(color)
{
    ; Gdip_GetPixel 함수는 BGR 형식으로 색상을 반환하므로 이를 RGB로 변환
    b := (color & 0xFF0000) >> 16
    g := (color & 0x00FF00) >> 8
    r := (color & 0x0000FF)
    ; 변환된 색상 반환
    return {r: r, g: g, b: b}
}


; ******************************************* 해당 UDF는 Gdip, Acc를 사용하지 않습니다.
; AHK Forum
; https://www.autohotkey.com/board/topic/38414-pixelcolorx-y-window-transp-off-screen-etc-windows/


; (ID 기준)  비활성 창의 픽셀 컬러를 검색하여 컬러를 리턴하는 함수

InactivePixelGetColorId(pc_x, pc_y, pc_wID)
{
	If pc_wID
	{
		pc_hDC := DllCall("GetDC", "UInt", pc_wID)
		WinGetPos, , , pc_w, pc_h, ahk_id %pc_wID%
		pc_hCDC := CreateCompatibleDC(pc_hDC)
		pc_hBmp := CreateCompatibleBitmap(pc_hDC, pc_w, pc_h)
		pc_hObj := SelectObject(pc_hCDC, pc_hBmp)
		
		pc_hmCDC := CreateCompatibleDC(pc_hDC)
		pc_hmBmp := CreateCompatibleBitmap(pc_hDC, 1, 1)
		pc_hmObj := SelectObject(pc_hmCDC, pc_hmBmp)
		
		DllCall("PrintWindow", "UInt", pc_wID, "UInt", pc_hCDC, "UInt", 0)
		DllCall("BitBlt" , "UInt", pc_hmCDC, "Int", 0, "Int", 0, "Int", 1, "Int", 1, "UInt", pc_hCDC, "Int", pc_x, "Int", pc_y, "UInt", 0xCC0020)
		pc_fmtI := A_FormatInteger
		SetFormat, Integer, Hex
		DllCall("GetBitmapBits", "UInt", pc_hmBmp, "UInt", VarSetCapacity(pc_bits, 4, 0), "UInt", &pc_bits)
		pc_c := NumGet(pc_bits, 0)
		SetFormat, Integer, %pc_fmtI%

		DeleteObject(pc_hBmp), DeleteObject(pc_hmBmp)
		DeleteDC(pc_hCDC), DeleteDC(pc_hmCDC)
		DllCall("ReleaseDC", "UInt", pc_wID, "UInt", pc_hDC)
		Return pc_c
	}
}


CreateCompatibleDC(hdc=0) {
	return DllCall("CreateCompatibleDC", "UInt", hdc)
}     

CreateCompatibleBitmap(hdc, w, h) {
	return DllCall("CreateCompatibleBitmap", UInt, hdc, Int, w, Int, w)
}

SelectObject(hdc, hgdiobj) {
	return DllCall("SelectObject", "UInt", hdc, "UInt", hgdiobj)
}

DeleteObject(hObject) {
   Return, DllCall("DeleteObject", "UInt", hObject)
}

DeleteDC(hdc) {
	Return, DllCall("DeleteDC", "UInt", hdc)
}
