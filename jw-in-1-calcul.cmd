REM V1.31 modification ZZZ for Zoom log 
REM --------------------------Date and Day of week -----------------------
for /f %%d in ('"powershell (Get-Date).DayOfWeek.Value__"') do set DW=%%d
set /a DoW =  %DW%
for /f "tokens=2 delims==" %%a in ('wmic OS Get localdatetime /value') do set "dt=%%a"
set mydate=%dt:~0,4%%dt:~4,2%%dt:~6,2%
REM ----------------------------------------------------------------------
REM ------------------------- Check Time convert in minutes-------------
set hour=%time:~0,2%
set minute=%time:~3,2%
set /a mytime= %hour%*60 + %minute%
REM  =========== FileSetupZoom ,=================================
echo DATE: %mydate% - TIME: %mytime% - Day of the Week: %DoW%
set ChooseDefaultZ=-2
set ChooseDefaultV=-2
REM ----- REVERSE ORDER 
set FileSetup=jw-in-1-tv.txt
call jw-in-1-variable.cmd
set FileSetup=jw-in-1.txt
call jw-in-1-variable.cmd
REM ---------------------- RETURN THE COM
set JW-IN-1-CHOOSE=Q
REM -------CHECK IF VIDEO ON LOCAL----------------
if not "%LocalFolder%" =="" (
	>nul 2>nul dir /a-d /s "%LocalFolder%\*" && ( set LOCALVIDEO=YES) || ( set LOCALVIDEO=NO)
)
REM ---------------------------- PRIORITY --------
REM -----------------------------1 ZOOM 
if not "%ChooseDefaultZ%" == "-2" (
	set JW-IN-1-CHOOSE=%ChooseDefaultZ%
	goto CalculEnd
	) 
REM ---------------------------- 2 NEWS ---

if "%ChooseDefaultV%"=="N" (
	set JW-IN-1-CHOOSE=%ChooseDefaultV%
	goto CalculEnd
)
REM ---------------------------- 3 CHECK SPECIAL---
if %mydate% LSS %LocalDateEnd% (
	IF %mydate% GTR %LocalDateStart% (
		IF "%LOCALVIDEO%"=="YES" (
			set JW-IN-1-CHOOSE=S
			goto CalculEnd
			)
	)
)
REM -------------------------- 4 PROGRAM -------------
if not "%ChooseDefaultV%" == "-2" (
	set JW-IN-1-CHOOSE=%ChooseDefaultV%
	) 
:CalculEnd
if "%JW-IN-1-CHOOSE%"=="" (
	if "%JW-IN-1-CHOOSE-DEFAULT%"=="" (set JW-IN-1-CHOOSE=Q) ELSE (set JW-IN-1-CHOOSE=%JW-IN-1-CHOOSE-DEFAULT%)
)