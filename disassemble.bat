@echo off
setlocal

rem Set path to tools
set unzipexe=PATH_TO_UNZIP_EXE
set apktoolbat=PATH_TO_APKTOOL_BAT
set dex2jarbat=PATH_TO_DEX2JAR_BAT
set jadexe=PATH_TO_JAD_EXE


for %%A in (*.apk) do (
echo %%A
call :DA %%A
rem echo
)


:DA
set target=%1
set targetdir=%target:.apk=%

if not "%1" == "" (
call %apktoolbat% d -f %target%
%unzipexe% -o -d %targetdir% %target% "classes.dex"
cd %targetdir%
call %dex2jarbat% classes.dex
%unzipexe% -d class classes_dex2jar.jar
%jadexe% -o -s java -r -d src class\**\*.class
cd ..\
)

exit /b

endlocal
