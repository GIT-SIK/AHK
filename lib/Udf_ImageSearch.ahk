#Include Acc.ahk   ; Acc 라이브러리를 포함
#Include Gdip_All.ahk ; GDI+ 라이브러리 포함

 If !pToken := Gdip_Startup()
 {
  MsgBox, 48, , Gdip ERROR
  return
 }


; (Title 기준)  비활성 창의 이미지를 해당 위치에 검색하여 T/F를 반환하는 함수
; winTitle			창 이름 입력
; searchImagePath	검색할 이미지가 저장된 폴더 위치 입력

InactiveSearchImageTitle(winTitle, searchImagePath, x := 0, y := 0, width := 0, height := 0)
{

    ; 창 ID 가져오기
    WinGet, hwnd, ID, %winTitle%
    if !hwnd {
        MsgBox, "창을 찾을 수 없습니다"
        Gdip_Shutdown(pToken)
        return
    }

    ; 비활성 창의 객체 가져오기
    hwnd := Acc_ObjectFromWindow(hwnd, -16)
    if !hwnd {
        MsgBox, "비활성 창의 객체를 가져올 수 없습니다."
        Gdip_Shutdown(pToken)
        return
    }

    ; 비활성 창의 이미지를 비트맵으로 캡처
    pBitmap := Gdip_BitmapFromHWND(hwnd)
    if !pBitmap {
        MsgBox, "비트맵을 가져올 수 없습니다."
        Gdip_Shutdown(pToken)
        return
    }

    ; 검색할 이미지 로드
    pSearchBitmap := Gdip_CreateBitmapFromFile(searchImagePath)
    if !pSearchBitmap {
        MsgBox, "검색할 이미지를 로드할 수 없습니다: " searchImagePath
        Gdip_DisposeImage(pBitmap)
        Gdip_Shutdown(pToken)
        return
    }

    ; 이미지 검색 범위를 제한할 경우 설정
    if (width > 0 && height > 0) {
        ; 지정된 범위의 이미지를 잘라내기
        pCroppedBitmap := Gdip_CropBitmap(pBitmap, x, y, width, height)
        Gdip_DisposeImage(pBitmap)
        pBitmap := pCroppedBitmap
    }

    ; 이미지 검색
    found := SearchBitmapInBitmap(pBitmap, pSearchBitmap)

    ; 리소스 해제
    Gdip_DisposeImage(pBitmap)
    Gdip_DisposeImage(pSearchBitmap)
    Gdip_Shutdown(pToken)

    if found {
        MsgBox, "이미지가 비활성 창에서 발견되었습니다!"
        return true
    } else {
        MsgBox, "이미지를 찾을 수 없습니다."
        return false
    }
}

; 비트맵 내에서 검색 이미지와 일치하는 부분을 찾는 함수
SearchBitmapInBitmap(pBitmap, pSearchBitmap)
{
    width := Gdip_GetImageWidth(pBitmap)
    height := Gdip_GetImageHeight(pBitmap)

    searchWidth := Gdip_GetImageWidth(pSearchBitmap)
    searchHeight := Gdip_GetImageHeight(pSearchBitmap)

    ; 메인 비트맵 내에서 검색 이미지와 일치하는 부분 찾기
    Loop, % width - searchWidth {
        Loop, % height - searchHeight {
            ; 각 픽셀을 비교
            if CompareBitmapRegion(pBitmap, pSearchBitmap, A_Index, A_LoopField)
                return true
        }
    }
    return false
}

; 두 비트맵 영역을 비교하는 함수
CompareBitmapRegion(pBitmap, pSearchBitmap, startX, startY)
{
    searchWidth := Gdip_GetImageWidth(pSearchBitmap)
    searchHeight := Gdip_GetImageHeight(pSearchBitmap)

    Loop, % searchWidth {
        Loop, % searchHeight {
            ; 각 픽셀 색상 비교
            color1 := Gdip_GetPixel(pBitmap, startX + A_Index, startY + A_LoopField)
            color2 := Gdip_GetPixel(pSearchBitmap, A_Index, A_LoopField)
            if (color1 != color2)
                return false
        }
    }
    return true
}