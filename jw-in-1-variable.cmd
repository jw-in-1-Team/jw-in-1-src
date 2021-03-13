REM V1.52 modification ZZZ for Zoom log 
REM ------------------------- RECUP VARIABLE --------------------------------
ECHO ===========VV===========VV========VV=============VV========
set notfound~=True
set notfound@=True
FOR /F "usebackq tokens=* delims= eol=-" %%s in (%FileSetup%) do (
	set t=%%s
	for /f "tokens=1,2,3,4*" %%a in ("!t!") do (
		set Array[0]=%%a
		set Array[1]=%%b
		set Array[2]=%%c
		set Array[3]=%%d
		set Array[4]=%%e
	) 
	if !Array[0]!==~ (
		if !notfound~!==True (
			if %mydate% == !Array[1]! (
				set /a A3= !Array[2]!
				if !mytime! GEQ !A3! (
					set /a A4= !Array[3]!
					if !A4! GEQ !mytime! ( 
						set ChooseDefaultV=A
						set UrlEdge=!Array[4]!
						set set notfound~=False
					)  
				)
			)
		)
	) ELSE (
		if !Array[0]!==# (
			if !notfound@!==True (
				if !DoW!==!Array[2]! (
					set /a A3= !Array[3]!
					if !mytime! GEQ !A3! (
						set /a A4= !Array[4]!
						if !A4! GEQ !mytime! (
							For /l %%Z in (!Array[1]!,1,!Array[1]!) do ( 
								set /a ZoomNu=%%Z
								set ChooseDefaultZ=%%Z
								set notfound@=False
							)
						) 
					)
				)
			)
		) ELSE (
			if !Array[0]!==@ (
				set Channel[!TVshortcut!]=!Array[1]!
				set condOR= 0
				if !DoW!==!Array[2]! set condOR=1
				if !Array[2]!==$ set condOR=1
				if !condOR!==1 (
					set /a A3= !Array[3]!
					if !mytime! GEQ !A3! (
						set /a A4= !Array[4]!
						if !A4! GEQ !mytime! ( 
							if "!ChooseDefaultV!"=="-2" (set ChooseDefaultV=!TVshortcut!)
								if "!TVshortcut!"=="P" ( 
								goto VideoLaunch
							)
						) 
					)
				)
			) else (
				if !Array[0]!==set ( 
					if !Array[3]! ==/a (
						set /a !Array[1]!=!Array[2]!
						set Array[3]=NO
						) else (
							if "!Array[3]!" =="" (set !Array[1]!=!Array[2]!) ELSE (
								set !Array[1]!=!Array[2]! !Array[3]! !Array[4]!
								)
							)					
						)
					)
				)
			)
		)
	)
)
ECHO ===========/\===========/\========/\=============/\========
:VideoLaunch