
HotKeySet("{ENTER}", "scan")
HotKeySet("{SPACE}", "randclick")
HotKeySet("{ESC}", "Terminate")
HotKeySet("{HOME}", "reload")

    WinMinimizeAll()

;get Minesweeper//////////////////////////////////////////////////////////////////
    If NOT WinExists("Minesweeper") Then
            Run("C:\WINDOWS\system32\winmine.exe")
            WinWaitActive("Minesweeper")
        Else
            WinActivate ("Minesweeper")
            WinWaitActive("Minesweeper")
    EndIf
;Have Minesweeper////////////////////////////////////////////////////////////////// 
    
    $size = WinGetPos("Minesweeper")
    $xstart = $size[0]+15
    $ystart = $size[1]+96
    $box    = 16

;Start////////////////////////////////////////////////////////////////////////////
    
    $n = 0
    $xx = $size[0]
    $yy = $size[1]
    
    Do
        randclick($n)
                
    Until $n = 2

    while 1 
    scan() ;findflaggables()
    wend

    
;finds if there are flaggables near.
    Func canflag($xv, $yv, $sum, $getnum)
        
        $size = WinGetPos("Minesweeper")
        
        If $xv = $size[0] + 15 Then;for leftest column
            If $yv = $size[1] + 96 Then;for top left box
                $sumF = getFstat($xv+16, $yv) + getFstat($xv+16, $yv+16) + getFstat( $xv, $yv+16)
                If $sumF = $getnum Then
                    cnf($xv+16, $yv)
                    cnf($xv+16, $yv+16)
                    cnf($xv, $yv+16)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+16, $yv)
                    fnf($xv+16, $yv+16)
                    cnf($xv, $yv+16)
                EndIf
            ElseIf $yv = $size[1] + $size[3] - 27 Then;for bottom left box
                $sumF = getFstat($xv+16, $yv) + getFstat( $xv, $yv-16) + getFstat( $xv+16, $yv-16)
                If $sumF = $getnum Then
                    cnf($xv+16, $yv)
                    cnf($xv, $yv-16)
                    cnf($xv+16, $yv-16)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+16, $yv)
                    fnf($xv, $yv-16)
                    fnf($xv+16, $yv-16)
                EndIf
            Else  ;the same for only left column
                $sumF = getFstat($xv+16, $yv) + getFstat($xv+16, $yv+16) + getFstat( $xv, $yv+16) + getFstat( $xv, $yv-16) + getFstat( $xv+16, $yv-16)
                If $sumF = $getnum Then
                    cnf($xv+16, $yv)
                    cnf($xv+16, $yv+16)
                    cnf($xv, $yv+16)
                    cnf($xv, $yv-16)
                    cnf($xv+16, $yv-16)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+16, $yv)
                    fnf($xv+16, $yv+16)
                    fnf($xv, $yv+16)
                    fnf($xv, $yv-16)
                    fnf($xv+16, $yv-16)
                EndIf
            EndIf   
        ElseIf $yv = $size[1] + 96 Then;for top row only
                If $xv = $size[0] + $size[2] - 27 Then;top right box
                $sumF = getFstat( $xv, $yv+16) + getFstat( $xv-16, $yv+16) + getFstat( $xv-16, $yv) 
                    If $sumF = $getnum Then
                        cnf($xv, $yv+16)
                        cnf($xv-16, $yv+16)
                        cnf($xv-16, $yv)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv, $yv+16)
                        fnf($xv-16, $yv+16)
                        fnf($xv-16, $yv)
                    EndIf
                Else
                $sumF = getFstat($xv+16, $yv) + getFstat($xv+16, $yv+16) + getFstat( $xv, $yv+16) + getFstat( $xv-16, $yv+16) + getFstat( $xv-16, $yv) 
                    If $sumF = $getnum Then
                        cnf($xv+16, $yv)
                        cnf($xv+16, $yv+16)
                        cnf($xv, $yv+16)
                        cnf($xv-16, $yv+16)
                        cnf($xv-16, $yv)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv+16, $yv)
                        fnf($xv+16, $yv+16)
                        fnf($xv, $yv+16)
                        fnf($xv-16, $yv+16)
                        fnf($xv-16, $yv)
                    EndIf
                EndIf
        ElseIf $xv = $size[0] + $size[2] - 27 Then;rightest column
                If $yv = $size[1] + $size[3] - 27 Then
                $sumF = getFstat( $xv-16, $yv) + getFstat( $xv-16, $yv-16) + getFstat( $xv, $yv-16) 
                    If $sumF = $getnum Then
                        cnf($xv-16, $yv)
                        cnf($xv-16, $yv-16)
                        cnf($xv, $yv-16)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv-16, $yv)
                        fnf($xv-16, $yv-16)
                        fnf($xv, $yv-16)
                    EndIf
                Else
                $sumF = getFstat( $xv, $yv+16) + getFstat( $xv-16, $yv+16) + getFstat( $xv-16, $yv) + getFstat( $xv-16, $yv-16) + getFstat( $xv, $yv-16)
                    If $sumF = $getnum Then
                        cnf($xv, $yv+16)
                        cnf($xv-16, $yv+16)
                        cnf($xv-16, $yv)
                        cnf($xv-16, $yv-16)
                        cnf($xv, $yv-16)
                    ElseIf $sum + $sumF = $getnum Then
                        fnf($xv, $yv+16)
                        fnf($xv-16, $yv+16)
                        fnf($xv-16, $yv)
                        fnf($xv-16, $yv-16)
                        fnf($xv, $yv-16)
                    EndIf
                EndIf
        ElseIf $yv = $size[1] + $size[3] - 27 Then;bottom row
                $sumF = getFstat($xv+16, $yv) + getFstat( $xv-16, $yv) + getFstat( $xv-16, $yv-16) + getFstat( $xv, $yv-16) + getFstat( $xv+16, $yv-16) 
                If $sumF = $getnum Then
                    cnf($xv+16, $yv)
                    cnf($xv-16, $yv)
                    cnf($xv-16, $yv-16)
                    cnf($xv, $yv-16)
                    cnf($xv+16, $yv-16)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+16, $yv)
                    fnf($xv-16, $yv)
                    fnf($xv-16, $yv-16)
                    fnf($xv, $yv-16)
                    fnf($xv+16, $yv-16)
                EndIf
        Else
                $sumF = getFstat($xv+16, $yv) + getFstat($xv+16, $yv+16) + getFstat( $xv, $yv+16) + getFstat( $xv-16, $yv+16) + getFstat( $xv-16, $yv) + getFstat( $xv-16, $yv-16) + getFstat( $xv, $yv-16) + getFstat( $xv+16, $yv-16) 
                If $sumF = $getnum Then
                    cnf($xv+16, $yv)
                    cnf($xv+16, $yv+16)
                    cnf($xv, $yv+16)
                    cnf($xv-16, $yv+16)
                    cnf($xv-16, $yv)
                    cnf($xv-16, $yv-16)
                    cnf($xv, $yv-16)
                    cnf($xv+16, $yv-16)
                ElseIf $sum + $sumF = $getnum Then
                    fnf($xv+16, $yv)
                    fnf($xv+16, $yv+16)
                    fnf($xv, $yv+16)
                    fnf($xv-16, $yv+16)
                    fnf($xv-16, $yv)
                    fnf($xv-16, $yv-16)
                    fnf($xv, $yv-16)
                    fnf($xv+16, $yv-16)
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
        $xstart = $size[0]+15
        $ystart = $size[1]+96
        
        $xmines = ($size[2] - 26) / 16
        $ymines = ($size[3] - 107) / 16
        
        Do
            $i = 0
            $rx = Random (0, $xmines - 1, 1)
            $ry = Random (0, $ymines - 1, 1)
            
            If PixelGetColor(($rx * 16) + $xstart, ($ry * 16) + $ystart) = 16777215 Then
                If getNstat(($rx * 16) + $xstart, ($ry * 16) + $ystart) < 2 Then
                    If Not PixelGetColor(($rx * 16) + $xstart + 9, ($ry * 16) + $ystart + 12) = 0 Then
                        MouseClick("Left", ($rx * 16) + $xstart, ($ry * 16) + $ystart, 1, 0)
                        $i = 1
                        $getdanum = getnum(($rx * 16) + $xstart, ($ry * 16) + $ystart)
                        If $getdanum = 0 Then
                            $n = $n+1
                        EndIf
                        If PixelGetColor(($rx * 16) + $xstart + 9, ($ry * 16) + $ystart + 12) = 0 Then
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
        $xmines = ($size[2] - 26) / 16
        $ymines = ($size[3] - 107) / 16
        $xv = $size[0] + 15
        $yv = $size[1] + 96
        
        For $ycount = 0 To $ymines - 1  Step 1
            For $xcount = 0 To $xmines - 1 Step 1
                If PixelGetColor($xv + 16 * $xcount, $yv + 16 * $ycount) = 8421504 Then
                    $number = getnum($xv + 16 * $xcount, $yv + 16 * $ycount) 
                    If NOT $number = 0 Then
                        $thesum = getAstat($xv + 16 * $xcount, $yv + 16 * $ycount)
                        If $thesum > 0 Then
                            MouseMove($xv + 16 * $xcount, $yv + 16 * $ycount, 0)
                            canflag($xv + 16 * $xcount, $yv + 16 * $ycount, $thesum, $number)
                        EndIf
                    EndIf   
                EndIf
            Next
        Next
        
        For $ycount = $ymines - 1 To 0  Step -1
            For $xcount = $xmines - 1 To 0 Step -1
                If PixelGetColor($xv + 16 * $xcount, $yv + 16 * $ycount) = 8421504 Then
                    $number = getnum($xv + 16 * $xcount, $yv + 16 * $ycount) 
                    If NOT $number = 0 Then
                        $thesum = getAstat($xv + 16 * $xcount, $yv + 16 * $ycount)
                        If $thesum > 0 Then
                            MouseMove($xv + 16 * $xcount, $yv + 16 * $ycount, 0)
                            canflag($xv + 16 * $xcount, $yv + 16 * $ycount, $thesum, $number)
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
        
        If $xv = $size[0] + 15 Then;for leftest column
            If $yv = $size[1] + 96 Then;for top left box
                $sum = getstat($xv+16, $yv) + getstat($xv+16, $yv+16) + getstat( $xv, $yv+16)
                Return $sum         
            ElseIf $yv = $size[1] + $size[3] - 27 Then;for bottom left box
                $sum = getstat($xv+16, $yv) + getstat( $xv, $yv-16) + getstat( $xv+16, $yv-16)
                Return $sum             
            Else  ;the same for only left column
                $sum = getstat($xv+16, $yv) + getstat($xv+16, $yv+16) + getstat( $xv, $yv+16) + getstat( $xv, $yv-16) + getstat( $xv+16, $yv-16) 
                Return $sum             
            EndIf   
        ElseIf $yv = $size[1] + 96 Then;for top row only
                If $xv = $size[0] + $size[2] - 27 Then;top right box
                $sum = getstat( $xv, $yv+16) + getstat( $xv-16, $yv+16) + getstat( $xv-16, $yv) 
                Return $sum             
                Else
                $sum = getstat($xv+16, $yv) + getstat($xv+16, $yv+16) + getstat( $xv, $yv+16) + getstat( $xv-16, $yv+16) + getstat( $xv-16, $yv) 
                Return $sum             
                EndIf
        ElseIf $xv = $size[0] + $size[2] - 27 Then;rightest column
                If $yv = $size[1] + $size[3] - 27 Then
                $sum = getstat( $xv-16, $yv) + getstat( $xv-16, $yv-16) + getstat( $xv, $yv-16) 
                Return $sum                 
                Else
                $sum = getstat( $xv, $yv+16) + getstat( $xv-16, $yv+16) + getstat( $xv-16, $yv) + getstat( $xv-16, $yv-16) + getstat( $xv, $yv-16)
                Return $sum                 
                EndIf
        ElseIf $yv = $size[1] + $size[3] - 27 Then;bottom row
                $sum = getstat($xv+16, $yv) + getstat( $xv-16, $yv) + getstat( $xv-16, $yv-16) + getstat( $xv, $yv-16) + getstat( $xv+16, $yv-16) 
                Return $sum             
        Else
                $sum = getstat($xv+16, $yv) + getstat($xv+16, $yv+16) + getstat( $xv, $yv+16) + getstat( $xv-16, $yv+16) + getstat( $xv-16, $yv) + getstat( $xv-16, $yv-16) + getstat( $xv, $yv-16) + getstat( $xv+16, $yv-16) 
                Return $sum
        EndIf
    EndFunc
    
;find and flag
    Func getNstat($x, $y)
        $size = WinGetPos("Minesweeper")
        $xv = $x
        $yv = $y
        $sum = 0
        
        If $xv = $size[0] + 15 Then;for leftest column
            If $yv = $size[1] + 96 Then;for top left box
                $sum = getnum($xv+16, $yv) + getnum($xv+16, $yv+16) + getnum( $xv, $yv+16)
                Return $sum         
            ElseIf $yv = $size[1] + $size[3] - 27 Then;for bottom left box
                $sum = getnum($xv+16, $yv) + getnum( $xv, $yv-16) + getnum( $xv+16, $yv-16)
                Return $sum             
            Else  ;the speal for only left column
                $sum = getnum($xv+16, $yv) + getnum($xv+16, $yv+16) + getnum( $xv, $yv+16) + getnum( $xv, $yv-16) + getnum( $xv+16, $yv-16) 
                Return $sum             
            EndIf   
        ElseIf $yv = $size[1] + 96 Then;for top row only
                If $xv = $size[0] + $size[2] - 27 Then;top right box
                $sum = getnum( $xv, $yv+16) + getnum( $xv-16, $yv+16) + getnum( $xv-16, $yv) 
                Return $sum             
                Else
                $sum = getnum($xv+16, $yv) + getnum($xv+16, $yv+16) + getnum( $xv, $yv+16) + getnum( $xv-16, $yv+16) + getnum( $xv-16, $yv) 
                Return $sum             
                EndIf
        ElseIf $xv = $size[0] + $size[2] - 27 Then;rightest column
                If $yv = $size[1] + $size[3] - 27 Then
                $sum = getnum( $xv-16, $yv) + getnum( $xv-16, $yv-16) + getnum( $xv, $yv-16) 
                Return $sum                 
                Else
                $sum = getnum( $xv, $yv+16) + getnum( $xv-16, $yv+16) + getnum( $xv-16, $yv) + getnum( $xv-16, $yv-16) + getnum( $xv, $yv-16)
                Return $sum                 
                EndIf
        ElseIf $yv = $size[1] + $size[3] - 27 Then;bottom row
                $sum = getnum($xv+16, $yv) + getnum( $xv-16, $yv) + getnum( $xv-16, $yv-16) + getnum( $xv, $yv-16) + getnum( $xv+16, $yv-16) 
                Return $sum             
        Else
                $sum = getnum($xv+16, $yv) + getnum($xv+16, $yv+16) + getnum( $xv, $yv+16) + getnum( $xv-16, $yv+16) + getnum( $xv-16, $yv) + getnum( $xv-16, $yv-16) + getnum( $xv, $yv-16) + getnum( $xv+16, $yv-16) 
                Return $sum
        EndIf
    EndFunc

;reload
    Func reload()           
            MouseClick("Left", $size[0] + $size[2] / 2, $size[1] + 70, 1, 0)
            Sleep(10)
    EndFunc
;Exit
    Func Terminate()
    Exit 0
    EndFunc
