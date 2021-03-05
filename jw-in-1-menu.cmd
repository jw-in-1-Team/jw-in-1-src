ECHO ===========================================================
ECHO .
set ListMenu=%LMenu%
IF defined %INDEX% ( SET INDEX=-2) ELSE (SET INDEX=0)
for %%m in (%ListMenu%) do (
	set SBMENU=!Choose[%%m]!
	REM ----- BOUCLE SUB MENU --START ------
	for %%n in (!Choose[%%m]!) do (
		ECHO   %%n  !Menu[%%m][%%n]!
		IF %MenuCount% == 0 (
			set CHOO=!CHOO!%%n
			set /A INDEX+=1
			Set CHO[!INDEX!]=%%n
			)
		)
	ECHO .
	)
	REM ----- BOUCLEs SUB MENU --END ------
)
ECHO     %ECHOChoose% %JW-IN-1-CHOOSE%           %JW-IN-1-CHOOSE%           %JW-IN-1-CHOOSE%           %JW-IN-1-CHOOSE%
ECHO ===========================================================
ECHO %EchoPress%
ECHO ===========================================================
REM GAETAN supprimer cette ligne

choice /T %MenuSecond% /C %CHOO% /D %JW-IN-1-CHOOSE%
set JW-IN-1-CHOOSE-USER=!CHO[%ERRORLEVEL%]!
set /A MenuCount=%MenuCount%+1