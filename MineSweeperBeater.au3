
HotKeySet("{ENTER}", "scan")
HotKeySet("{SPACE}", "randclickHot")
HotKeySet("{ESC}", "Terminate")
HotKeySet("{HOME}", "reStart")

    WinMinimizeAll()
 $xOffset = 15
Global $yOffset = 101 ;Windows xp (with classic theme) header was '96' pixels high, running in windows 11 its 101
Global $box    = 16

Global $xBorder = 27 ;width of pixels left and right of minefield
Global $yBorder = 112 ;(windows xp was 107) hight of pixels above/below minefield

Func randclickHot()
    randclick(0)
EndFunc   ;==>HotKeyFunc

;get Minesweeper//////////////////////////////////////////////////////////////////
    If NOT WinExists("Minesweeper") Then
			Run("C:\Users\steve\Documents\Drive\Archives\Powers\WINDOWS\system32\winmine.exe")
            ;Run("C:\WINDOWS\system32\winmine.exe")
            WinWaitActive("Minesweeper")
        Else
            WinActivate ("Minesweeper")
            WinWaitActive("Minesweeper")
    EndIf
;Have Minesweeper//////////////////////////////////////////////////////////////////

;Start////////////////////////////////////////////////////////////////////////////

	reStart()
    while 1
		scan() ;findflaggables()
    wend


;finds if there are flaggables near.
    Func canflag($xv, $yv, $sum, $getnum)

        $size = WinGetPos("Minesweeper")

        If $xv = $size[0] + $xoffset Then;for leftest column
            If $yv = $size[1] + $yOffset Then;for top left box
                $sumF = getFstat($xv+$box, $yv) + getFstat($xv+$box, $yv+$box) + getFstat( $xv, $yv+$box)
                If $sumF = $getnum Then
                    cnf($xv+$box, $yv)
                    cnf($xv+$box, $yv+$box)
                    cnf($xv, $yv+$box)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+$box, $yv)
                    fnf($xv+$box, $yv+$box)
                    cnf($xv, $yv+$box)
                EndIf
            ElseIf $yv = $size[1] + $size[3] - $xBorder Then;for bottom left box
                $sumF = getFstat($xv+$box, $yv) + getFstat( $xv, $yv-$box) + getFstat( $xv+$box, $yv-$box)
                If $sumF = $getnum Then
                    cnf($xv+$box, $yv)
                    cnf($xv, $yv-$box)
                    cnf($xv+$box, $yv-$box)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+$box, $yv)
                    fnf($xv, $yv-$box)
                    fnf($xv+$box, $yv-$box)
                EndIf
            Else  ;the same for only left column
                $sumF = getFstat($xv+$box, $yv) + getFstat($xv+$box, $yv+$box) + getFstat( $xv, $yv+$box) + getFstat( $xv, $yv-$box) + getFstat( $xv+$box, $yv-$box)
                If $sumF = $getnum Then
                    cnf($xv+$box, $yv)
                    cnf($xv+$box, $yv+$box)
                    cnf($xv, $yv+$box)
                    cnf($xv, $yv-$box)
                    cnf($xv+$box, $yv-$box)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+$box, $yv)
                    fnf($xv+$box, $yv+$box)
                    fnf($xv, $yv+$box)
                    fnf($xv, $yv-$box)
                    fnf($xv+$box, $yv-$box)
                EndIf
            EndIf
        ElseIf $yv = $size[1] + $yOffset Then;for top row only
                If $xv = $size[0] + $size[2] - $xBorder Then;top right box
                $sumF = getFstat( $xv, $yv+$box) + getFstat( $xv-$box, $yv+$box) + getFstat( $xv-$box, $yv)
                    If $sumF = $getnum Then
                        cnf($xv, $yv+$box)
                        cnf($xv-$box, $yv+$box)
                        cnf($xv-$box, $yv)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv, $yv+$box)
                        fnf($xv-$box, $yv+$box)
                        fnf($xv-$box, $yv)
                    EndIf
                Else
                $sumF = getFstat($xv+$box, $yv) + getFstat($xv+$box, $yv+$box) + getFstat( $xv, $yv+$box) + getFstat( $xv-$box, $yv+$box) + getFstat( $xv-$box, $yv)
                    If $sumF = $getnum Then
                        cnf($xv+$box, $yv)
                        cnf($xv+$box, $yv+$box)
                        cnf($xv, $yv+$box)
                        cnf($xv-$box, $yv+$box)
                        cnf($xv-$box, $yv)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv+$box, $yv)
                        fnf($xv+$box, $yv+$box)
                        fnf($xv, $yv+$box)
                        fnf($xv-$box, $yv+$box)
                        fnf($xv-$box, $yv)
                    EndIf
                EndIf
        ElseIf $xv = $size[0] + $size[2] - $xBorder Then;rightest column
                If $yv = $size[1] + $size[3] - $xBorder Then
                $sumF = getFstat( $xv-$box, $yv) + getFstat( $xv-$box, $yv-$box) + getFstat( $xv, $yv-$box)
                    If $sumF = $getnum Then
                        cnf($xv-$box, $yv)
                        cnf($xv-$box, $yv-$box)
                        cnf($xv, $yv-$box)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv-$box, $yv)
                        fnf($xv-$box, $yv-$box)
                        fnf($xv, $yv-$box)
                    EndIf
                Else
                $sumF = getFstat( $xv, $yv+$box) + getFstat( $xv-$box, $yv+$box) + getFstat( $xv-$box, $yv) + getFstat( $xv-$box, $yv-$box) + getFstat( $xv, $yv-$box)
                    If $sumF = $getnum Then
                        cnf($xv, $yv+$box)
                        cnf($xv-$box, $yv+$box)
                        cnf($xv-$box, $yv)
                        cnf($xv-$box, $yv-$box)
                        cnf($xv, $yv-$box)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv, $yv+$box)
                        fnf($xv-$box, $yv+$box)
                        fnf($xv-$box, $yv)
                        fnf($xv-$box, $yv-$box)
                        fnf($xv, $yv-$box)
                    EndIf
                EndIf
        ElseIf $yv = $size[1] + $size[3] - $xBorder Then;bottom row
                $sumF = getFstat($xv+$box, $yv) + getFstat( $xv-$box, $yv) + getFstat( $xv-$box, $yv-$box) + getFstat( $xv, $yv-$box) + getFstat( $xv+$box, $yv-$box)
                If $sumF = $getnum Then
                    cnf($xv+$box, $yv)
                    cnf($xv-$box, $yv)
                    cnf($xv-$box, $yv-$box)
                    cnf($xv, $yv-$box)
                    cnf($xv+$box, $yv-$box)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+$box, $yv)
                    fnf($xv-$box, $yv)
                    fnf($xv-$box, $yv-$box)
                    fnf($xv, $yv-$box)
                    fnf($xv+$box, $yv-$box)
                EndIf
        Else
                $sumF = getFstat($xv+$box, $yv) + getFstat($xv+$box, $yv+$box) + getFstat( $xv, $yv+$box) + getFstat( $xv-$box, $yv+$box) + getFstat( $xv-$box, $yv) + getFstat( $xv-$box, $yv-$box) + getFstat( $xv, $yv-$box) + getFstat( $xv+$box, $yv-$box)
                If $sumF = $getnum Then
                    cnf($xv+$box, $yv)
                    cnf($xv+$box, $yv+$box)
                    cnf($xv, $yv+$box)
                    cnf($xv-$box, $yv+$box)
                    cnf($xv-$box, $yv)
                    cnf($xv-$box, $yv-$box)
                    cnf($xv, $yv-$box)
                    cnf($xv+$box, $yv-$box)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+$box, $yv)
                    fnf($xv+$box, $yv+$box)
                    fnf($xv, $yv+$box)
                    fnf($xv-$box, $yv+$box)
                    fnf($xv-$box, $yv)
                    fnf($xv-$box, $yv-$box)
                    fnf($xv, $yv-$box)
                    fnf($xv+$box, $yv-$box)
                EndIf
        EndIf
    EndFunc

;check box number after click
    Func getnum($x, $y)
        $color = PixelGetColor($x+9, $y+12)

        If $color = 12632256      Then;gray     0
            Return 0
        ElseIf $color = 255    Then;blue      1
            Return 1
        ElseIf $color = 32768     Then;Dkgreen  2
            Return 2
        ElseIf $color = 16711680  Then;Red  3
            Return 3
        ElseIf $color = 128 Then;Dkblue 4
            Return 4
        ElseIf $color = 8388608   Then ;Dkred   5
            Return 5
        ElseIf $color = 32896      Then;teal    6
            Return 6
        ElseIf $color = 0      Then;MINE    END mine red16711680
            Return 0
        Else
    ;Didn't get PixelGetColor HAVE 7 OR 8 Yet
            Return 3  ;if other return 3, just because (Forgot why i did that)
        EndIf
    EndFunc

;check if box is clicked if so 1
    Func getstat($x, $y)
        $color = PixelGetColor($x, $y)
        If $color = 8421504 Then    ;Gray already clicked...
            Return 0
        ElseIf $color = 16777215 Then ;White
        $color = PixelGetColor($x+9, $y+12)
            If $color = 0 Then      ;flagged
                Return 0
            Else
                Return 1
            EndIf
        EndIf
    EndFunc

;check if box is flagged if so 1
    Func getFstat($x, $y)
        $color = PixelGetColor($x, $y)
        If $color = 8421504 Then    ;Gray already clicked...
            Return 0
        ElseIf $color = 16777215 Then ;White
        $color = PixelGetColor($x+9, $y+12)
            If $color = 0 Then      ;flagged
        ;MsgBox(0, "not needed but it has a flagged near it all ready", "")
                Return 1
            Else
                Return 0
            EndIf
        EndIf
    EndFunc

;flag a not flagged
    Func fnf($x ,$y)
        $color = PixelGetColor($x, $y)
        If $color = 16777215 Then ;White
        $color = PixelGetColor($x+9, $y+12)
            If $color = 0 Then      ;flagged
        ;MsgBox(0, "not needed but it has a flagged near it all ready", "")
            Else
                MouseClick("Right", $x, $y, 1, 0)
            EndIf
        EndIf

    EndFunc

;Click a not flagged
    Func cnf($x ,$y)
        $color = PixelGetColor($x, $y)
        If $color = 16777215 Then ;White
        $color = PixelGetColor($x+9, $y+12)
            If $color = 0 Then      ;flagged
        ;MsgBox(0, "not needed but it has a flagged near it all ready", "")
            Else
                MouseClick("Left", $x, $y, 1, 0)
            EndIf
        EndIf

    EndFunc

;RANDOM clicks when stuck
    Func randclick(ByRef $n)
        $size = WinGetPos("Minesweeper")
        $xstart = $size[0]+$xOffset
        $ystart = $size[1]+$yOffset

        $xmines = ($size[2] - ($xBorder)) / $box
        $ymines = ($size[3] - ($yBorder)) / $box

        Do
            $i = 0
            $rx = Random (0, $xmines - 1, 1)
            $ry = Random (0, $ymines - 1, 1)

            If PixelGetColor(($rx * $box) + $xstart, ($ry * $box) + $ystart) = 16777215 Then
                If getNstat(($rx * $box) + $xstart, ($ry * $box) + $ystart) < 2 Then
                    If Not PixelGetColor(($rx * $box) + $xstart + 9, ($ry * $box) + $ystart + 12) = 0 Then
                        MouseClick("Left", ($rx * $box) + $xstart, ($ry * $box) + $ystart, 1, 0)
                        $i = 1
                        $getdanum = getnum(($rx * $box) + $xstart, ($ry * $box) + $ystart)
                        If $getdanum = 0 Then
                            $n = $n+1
                        EndIf
                        If PixelGetColor(($rx * $box) + $xstart + 9, ($ry * $box) + $ystart + 12) = 0 Then
							reload()
							$i = 0
							$n = 0
                        EndIf
                    EndIf
                EndIf
            EndIf

        Until $i = 1

    EndFunc

;Scan through
    Func scan()
        $size = WinGetPos("Minesweeper")
        $xmines = ($size[2] - $xBorder) / $box	;width minus border outside of boxes
        $ymines = ($size[3] - $yBorder) / $box
        $xv = $size[0] + $xOffset
        $yv = $size[1] + $yOffset

        For $ycount = 0 To $ymines - 1  Step 1
            For $xcount = 0 To $xmines - 1 Step 1
                If PixelGetColor($xv + $box * $xcount, $yv + $box * $ycount) = 8421504 Then
                    $number = getnum($xv + $box * $xcount, $yv + $box * $ycount)
                    If NOT $number = 0 Then
                        $thesum = getAstat($xv + $box * $xcount, $yv + $box * $ycount)
                        If $thesum > 0 Then
                            MouseMove($xv + $box * $xcount, $yv + $box * $ycount, 0)
                            canflag($xv + $box * $xcount, $yv + $box * $ycount, $thesum, $number)
                        EndIf
                    EndIf
                EndIf
            Next
        Next

        For $ycount = $ymines - 1 To 0  Step -1
            For $xcount = $xmines - 1 To 0 Step -1
                If PixelGetColor($xv + $box * $xcount, $yv + $box * $ycount) = 8421504 Then
                    $number = getnum($xv + $box * $xcount, $yv + $box * $ycount)
                    If NOT $number = 0 Then
                        $thesum = getAstat($xv + $box * $xcount, $yv + $box * $ycount)
                        If $thesum > 0 Then
                            MouseMove($xv + $box * $xcount, $yv + $box * $ycount, 0)
                            canflag($xv + $box * $xcount, $yv + $box * $ycount, $thesum, $number)
                        EndIf
                    EndIf
                EndIf
            Next
        Next


    EndFunc

;find and flag
    Func getAstat($xv, $yv)
        $size = WinGetPos("Minesweeper")
        $sum = 0

        If $xv = $size[0] + $xOffset Then;for leftest column
            If $yv = $size[1] + $yOffset Then;for top left box
                $sum = getstat($xv+$box, $yv) + getstat($xv+$box, $yv+$box) + getstat( $xv, $yv+$box)
                Return $sum
            ElseIf $yv = $size[1] + $size[3] - $xBorder Then;for bottom left box
                $sum = getstat($xv+$box, $yv) + getstat( $xv, $yv-$box) + getstat( $xv+$box, $yv-$box)
                Return $sum
            Else  ;the same for only left column
                $sum = getstat($xv+$box, $yv) + getstat($xv+$box, $yv+$box) + getstat( $xv, $yv+$box) + getstat( $xv, $yv-$box) + getstat( $xv+$box, $yv-$box)
                Return $sum
            EndIf
        ElseIf $yv = $size[1] + $yOffset Then;for top row only
                If $xv = $size[0] + $size[2] - $xBorder Then;top right box
                $sum = getstat( $xv, $yv+$box) + getstat( $xv-$box, $yv+$box) + getstat( $xv-$box, $yv)
                Return $sum
                Else
                $sum = getstat($xv+$box, $yv) + getstat($xv+$box, $yv+$box) + getstat( $xv, $yv+$box) + getstat( $xv-$box, $yv+$box) + getstat( $xv-$box, $yv)
                Return $sum
                EndIf
        ElseIf $xv = $size[0] + $size[2] - $xBorder Then;rightest column
                If $yv = $size[1] + $size[3] - $xBorder Then
                $sum = getstat( $xv-$box, $yv) + getstat( $xv-$box, $yv-$box) + getstat( $xv, $yv-$box)
                Return $sum
                Else
                $sum = getstat( $xv, $yv+$box) + getstat( $xv-$box, $yv+$box) + getstat( $xv-$box, $yv) + getstat( $xv-$box, $yv-$box) + getstat( $xv, $yv-$box)
                Return $sum
                EndIf
        ElseIf $yv = $size[1] + $size[3] - $xBorder Then;bottom row
                $sum = getstat($xv+$box, $yv) + getstat( $xv-$box, $yv) + getstat( $xv-$box, $yv-$box) + getstat( $xv, $yv-$box) + getstat( $xv+$box, $yv-$box)
                Return $sum
        Else
                $sum = getstat($xv+$box, $yv) + getstat($xv+$box, $yv+$box) + getstat( $xv, $yv+$box) + getstat( $xv-$box, $yv+$box) + getstat( $xv-$box, $yv) + getstat( $xv-$box, $yv-$box) + getstat( $xv, $yv-$box) + getstat( $xv+$box, $yv-$box)
                Return $sum
        EndIf
    EndFunc

;find and flag
    Func getNstat($x, $y)
        $size = WinGetPos("Minesweeper")
        $xv = $x
        $yv = $y
        $sum = 0

        If $xv = $size[0] + $xOffset Then;for leftest column
            If $yv = $size[1] + $yOffset Then;for top left box
                $sum = getnum($xv+$box, $yv) + getnum($xv+$box, $yv+$box) + getnum( $xv, $yv+$box)
                Return $sum
            ElseIf $yv = $size[1] + $size[3] - $xBorder Then;for bottom left box
                $sum = getnum($xv+$box, $yv) + getnum( $xv, $yv-$box) + getnum( $xv+$box, $yv-$box)
                Return $sum
            Else  ;the speal for only left column
                $sum = getnum($xv+$box, $yv) + getnum($xv+$box, $yv+$box) + getnum( $xv, $yv+$box) + getnum( $xv, $yv-$box) + getnum( $xv+$box, $yv-$box)
                Return $sum
            EndIf
        ElseIf $yv = $size[1] + $yOffset Then;for top row only
                If $xv = $size[0] + $size[2] - $xBorder Then;top right box
                $sum = getnum( $xv, $yv+$box) + getnum( $xv-$box, $yv+$box) + getnum( $xv-$box, $yv)
                Return $sum
                Else
                $sum = getnum($xv+$box, $yv) + getnum($xv+$box, $yv+$box) + getnum( $xv, $yv+$box) + getnum( $xv-$box, $yv+$box) + getnum( $xv-$box, $yv)
                Return $sum
                EndIf
        ElseIf $xv = $size[0] + $size[2] - $xBorder Then;rightest column
                If $yv = $size[1] + $size[3] - $xBorder Then
                $sum = getnum( $xv-$box, $yv) + getnum( $xv-$box, $yv-$box) + getnum( $xv, $yv-$box)
                Return $sum
                Else
                $sum = getnum( $xv, $yv+$box) + getnum( $xv-$box, $yv+$box) + getnum( $xv-$box, $yv) + getnum( $xv-$box, $yv-$box) + getnum( $xv, $yv-$box)
                Return $sum
                EndIf
        ElseIf $yv = $size[1] + $size[3] - $xBorder Then;bottom row
                $sum = getnum($xv+$box, $yv) + getnum( $xv-$box, $yv) + getnum( $xv-$box, $yv-$box) + getnum( $xv, $yv-$box) + getnum( $xv+$box, $yv-$box)
                Return $sum
        Else
                $sum = getnum($xv+$box, $yv) + getnum($xv+$box, $yv+$box) + getnum( $xv, $yv+$box) + getnum( $xv-$box, $yv+$box) + getnum( $xv-$box, $yv) + getnum( $xv-$box, $yv-$box) + getnum( $xv, $yv-$box) + getnum( $xv+$box, $yv-$box)
                Return $sum
        EndIf
    EndFunc

;reload
    Func reload()
		$size = WinGetPos("Minesweeper")
		MouseClick("Left", $size[0] + $size[2] / 2, $size[1] + 70, 1, 0)
		Sleep(20)
	EndFunc

;reload
    Func reStart()
		reload()

		$n = 0
		Do
			randclick($n)
		Until $n = 2
    EndFunc

;Exit
    Func Terminate()
		Exit 0
    EndFunc
