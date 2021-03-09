@echo off
COLOR 2F
setlocal enabledelayedexpansion
set Local=no
set MenuCount=0
set LocalDateStart=20200101
set LocalDateEnd=20330101
SET VERSIONLOCAL=version1.50
ECHO ===========================================================
ECHO ===========           JW-IN-1 %VERSIONLOCAL%       ===========
ECHO ===========================================================
REM  =========== FileSetupZoom ,FILENAMETV aren setup by default and can be update later =========
REM TODO MOVE NEXT LINE in txt with /a 
set ZoomFolder="%APPDATA%"
set InternetStatut=NOT
call jw-in-1-calcul.cmd
:SearchInternet
ping -n 3 8.8.8.8 | find "TTL=" >nul || (
	ECHO ===**=====================================**=======
	ECHO =========     NO INTERNET CONNEXION     ===========
	ECHO =====**======================*============*========
	if "%LOCALVIDEO%"=="YES" (
		REM -------------- NOT INTERNET CHECK IF VLC LOCAL 
		GOTO Priority0
	) ELSE (
		timeout /t 20 /nobreak
		GOTO SearchInternet
	)
)
set InternetStatut=YES
goto FirstTimeWithInternet
:ReadyToAnother
nircmd win close process msedge.exe
nircmd win close process %ZoomExe%
nircmd win close process %VLC%
REM  ------------- UPDATE SETUP FROM SERVER ----- 
:FirstTimeWithInternet
IF "%FILENAME%" == "" (set aaa=1) ELSE (
	IF EXIST tempo.txt (DEL tempo.txt)
	wget --no-check-certificate --no-verbose https://docs.google.com/uc?export=download^&id=%FILEID% -O tempo.txt
	for %%a in (tempo.txt) do (
		if not "%%~za"=="0" (
		move /Y tempo.txt %FILENAME%
		)
	)
)
IF "%FILENAMETV%" == "" (set aaa=1) ELSE (
	IF EXIST tempo.txt (DEL tempo.txt)
	wget --no-check-certificate --no-verbose https://docs.google.com/uc?export=download^&id=%FILEIDTV% -O tempo.txt
	for %%a in (tempo.txt) do (
		if not "%%~za"=="0" ( 
		move /Y tempo.txt %FILENAMETV%
		)
	)
)
call jw-in-1-calcul.cmd
call jw-in-1-update.cmd
call jw-in-1-menu.cmd

REM  ----- PRIORITY 0 : ASSEMBLY URL ----
if "%JW-IN-1-CHOOSE-USER%"=="A" (
	start msedge.exe --kiosk %UrlEdge% --edge-kiosk-type=fullscreen
	GOTO MeetingEnd
)
REM  ----- PRIORITY 1 : LOCAL VIDEO  -----
if "%JW-IN-1-CHOOSE-USER%"=="S" (
	:Priority0
	ECHO ===========================================================
	ECHO LAUNCH %LocalDateStart% VIDEO %LocalDateEnd% LOCAL %LocalFolder%
	ECHO ===========================================================
	CALL %VLC% %LocalFolder%\ --fullscreen --video-on-top --sub-autodetect-file
	if InternetStatut==YES (GOTO ReadyToAnother) ELSE (GOTO SearchInternet)
)
REM  ----- PRIORITY 2 : QUIT -----------
if "%JW-IN-1-CHOOSE-USER%"=="Q" (GOTO MeetingEnd)
REM  ----- PRIORITY3 : ZOOM sinon VLC ------
FOR %%z in (%Choose[Z]%) DO (
	IF "%JW-IN-1-CHOOSE-USER%"=="%%z" (
		ECHO ===========================================================
		ECHO = %mytime%: LAUNCH ZOOM B!Log[%%z]! D!Pwd[%%z]! =
		ECHO ===========================================================
		@ECHO ON
		CALL %ZoomFolder%\%ZoomExe:"=% "-url=zoommtg://zoom.us/join?action=join&confno=!Log[%%z]!&pwd=!Pwd[%%z]!
		@ECHO OFF
		GOTO MeetingEnd
	)
) 
REM  ----- PRIORITY 2 : DAILY TEXT by DEFAULT ------
call jw-in-1-msedge.cmd
if "%JW-IN-1-CHOOSE-USER%"=="D" (GOTO MeetingEnd)
REM ----------------------------TV-------------------------------------
call jw-in-1-tv.cmd
IF not "%JW-IN-1-CHOOSE-USER%"=="" (GOTO ReadyToAnother)
:MeetingEnd
