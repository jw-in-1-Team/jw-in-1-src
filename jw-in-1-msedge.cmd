Set "WMIC_Command=wmic path Win32_VideoController get VideoModeDescription^,CurrentHorizontalResolution^,CurrentVerticalResolution /format:Value"
Set "H=CurrentHorizontalResolution"
Set "V=CurrentVerticalResolution"
Call :GetResolution %H% HorizontalResolution
Call :GetResolution %V% VerticalResolution
GOTO Next
::****************************************************
:GetResolution
FOR /F "tokens=2 delims==" %%I IN (
  '%WMIC_Command% ^| find /I "%~1" 2^>^nul'
) DO FOR /F "delims=" %%A IN ("%%I") DO SET "%2=%%A"
Exit /b
::****************************************************
:Next

set /a hr3=HorizontalResolution/3
set /a hr2=HorizontalResolution/3*2
set /a vr=VerticalResolution-40
start "SITEWEB" msedge.exe https://www.jw.org/%WebLang% --new-window
start "SITEWOL" msedge.exe https://wol.jw.org/%WebLang% --new-window
TIMEOUT /T 3 /NOBREAK
nircmd cmdwait 2000 win setsize ititle "jw.org"  0 0 %hr2% %vr%
nircmd cmdwait 1000 win setsize ititle "Watchtower" %hr2% 0 %hr3% %vr%

