REM VERSION 1.43
set FU=jw-in-1.bat,jw-in-1-calcul.cmd,jw-in-1-menu.cmd,jw-in-1-msedge.cmd,jw-in-1-tv.cmd,jw-in-1-variable.cmd,jw-in-1-update.cmd,readme.txt
set FJ=jw-scripts-master
set LJ=jwb-index
set FJJ=jwlib
set LJJ=common.py,download.py,offline.py,output.py,parse.py
IF EXIST %FJ%\%VERSERF% (DEL %FJ%\%VERSERF%)
wget.exe "%VERSERP%%VERSERF%"  -N --no-verbose -P %FJ%\
set /p VERFILSER=<%FJ%\%VERSERF%
If not "%VERFILSER%"=="%VERSIONLOCAL%" (
	for %%f in (%FU%) do (
	wget -N --quiet  --no-check-certificate https://jw-in-1.com/www-update/%%f
	)
	for %%g in (%LJ%) do (
	wget -N --quiet --no-check-certificate https://jw-in-1.com/www-update/%FJ%/%%g -P %FJ%\
	)
	for %%h in (%LJJ%) do (
	wget -N --quiet --no-check-certificate https://jw-in-1.com/www-update/%FJ%/%FJJ%/%%h -P %FJ%\%FJJ%\
	)
)