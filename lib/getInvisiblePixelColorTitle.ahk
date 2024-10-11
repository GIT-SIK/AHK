#Include Acc.ahk ; Acc 라이브러리를 포함
#Include Gdip_All.ahk ; GDI+ 라이브러리 포함


GetInvisiblePixelColorTitle(winTitle, x, y, windowIndex := 0)
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
