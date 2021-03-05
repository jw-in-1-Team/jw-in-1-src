REM Version 1.4 modification  if %mydate% LSS %LocalDateEnd%

If %minute% GTR 45 (set lang=%StreamLang1%) ELSE (
	If %minute% LSS 15 (set lang=%StreamLang1%) ELSE (set lang=%StreamLang2%)
)
set TEMPO=!channel[%JW-IN-1-CHOOSE-USER%]!
if "%TEMPO%"=="" ( set CATE=) ELSE ( set CATE=--category %TEMPO%)
if "%TEMPO%"=="LatestVideos" ( 
	set RANDO=
	set RANDO1= --sort newest
	) ELSE ( 
	set RANDO= --random
	set RANDO1= --sort random
)
ECHO ===========================================================
ECHO ===               LAUNCH STREAMING                    =====
ECHO ===========================================================
set M3UF=jw-in-1.m3u
REM set M3UP=jw-scripts-master\
IF EXIST output.m3u (DEL output.m3u)
call python "%JWB%\jwb-index" %RANDO1% --lang %lang% %CATE%  -m m3u %M3UF%
call %VLC%%RANDO% --fullscreen --video-on-top --sub-autodetect-file %M3UF%