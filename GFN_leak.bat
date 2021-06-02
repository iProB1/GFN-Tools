cls
@ECHO OFF
CALL :INIT_VARIABLES
CALL :INIT_BATCH

EXIT

:INIT_VARIABLES:
SET DL="%PROGRAMFILES(X86)%\Steam\steamapps\gfntools\app_304930\item_2250811147\files\rdl.exe"
SET EXTRACT="B:\GFNTools\7.exe"

GOTO :eof

:INIT_BATCH:
CLS
COLOR 04
TITLE GFNTools v6.0

CALL :IS_ON_PC
CALL :INIT

GOTO :eof

:INIT:
B:
MKDIR B:\GFNTools\Apps >NUL 2>&1
MKDIR B:\GFNTools\Downloads >NUL 2>&1
ICACLS B:\GFNTools /grant kiosk:(OI)(CI)F /T >NUL 2>&1
ICACLS B:\GFNTools /grant Users:(OI)(CI)F /T >NUL 2>&1
REG DELETE HKCR\CLSID\{5FF6E100-3F93-437D-8779-C0409CB4855A} /f >NUL 2>&1

CALL :PATCH_USG
CALL :WRITE_OPENING_TEXT
CALL :GET_RDL
CALL :GET_SEVENZIP
CALL :GET_FAKE_STEAM
CALL :GET_GFNTOOLS_ZIP
CALL :GET_GFNTOOLS_PROGRAM
CALL :EXTRACT_CUSTOM_WALLPAPER
CALL :EXTRACT_APP_CONFIG
CALL :DELETE_STUFF
CALL :LAUNCH_WINXSHELL
CALL :LAUNCH_GFNTOOLS_PROGRAM

GOTO :eof

:PATCH_USG:
C:
ECHO Patching Unsupported Games for Steam...
DEL /f /q "C:\Users\kiosk\AppData\Local\NVIDIA Corporation\GfnRuntimeSdk\GFNSDK_Steam.json" >NUL 2>&1
TASKKILL /F /IM steam* >NUL 2>&1
CD "%PROGRAMFILES(X86)%\Steam"
REN steamapps GRIDsteamapps >NUL 2>&1
MKDIR steamapps >NUL 2>&1
MKDIR steamapps\content >NUL 2>&1
ICACLS steamapps /grant kiosk:(OI)(CI)F /T >NUL 2>&1
ICACLS steamapps /grant Users:(OI)(CI)F /T >NUL 2>&1
MKLINK /J steamapps\common GRIDsteamapps\common >NUL 2>&1
START "" steam.exe >NUL 2>&1

CLS
GOTO :eof

:WRITE_OPENING_TEXT:
ECHO ___________________________________________________________
ECHO.
ECHO [93m		        GFNTools![31m
ECHO ___________________________________________________________
ECHO.
ECHO NOTE : If anyone uploads videos on GFNTools without
ECHO our consent, we have all rights to take your video down!
ECHO.
ECHO For permissions contact \o^>.
ECHO.
ECHO Credits to SoftwareRat for the USG Patch!
ECHO ___________________________________________________________
ECHO.

GOTO :eof

:GET_RDL:
C:
CD "%PROGRAMFILES(X86)%\Steam"
START "" steam.exe "steam://install/304930" >NUL 2>&1
START "" steam.exe "steam://nav/console" >NUL 2>&1
ECHO download_item 304930 2250811147|clip
ECHO Press CTRL + V in the console box.
CALL :CHECK_RDL_EXIST
CALL :PREPARE_RDL

GOTO :eof

:PREPARE_RDL:
TIMEOUT 6 /NOBREAK >NUL 2>&1
REN "%PROGRAMFILES(X86)%\Steam\steamapps\content" gfntools >NUL 2>&1

GOTO :eof

:GET_SEVENZIP:
B:
CD B:\GFNTools
%DL% -LJOk "http://gg.gg/7exegfn" >NUL 2>&1
%DL% -LJOk "http://gg.gg/7dllgfn" >NUL 2>&1

GOTO :eof

:GET_FAKE_STEAM:
B:
CD B:\GFNTools\Apps
%DL% -LJOk "http://gg.gg/fakesteam" >NUL 2>&1
START "" steam.exe >NUL 2>&1

GOTO :eof

:GET_GFNTOOLS_ZIP:
B:
ECHO Downloading GFNTools Essentials...
CD B:\GFNTools
%DL% -LJOk "http://gg.gg/gfntoolszip" >NUL 2>&1
TIMEOUT 1 /NOBREAK >NUL 2>&1
%EXTRACT% x GFNTools.7z >NUL 2>&1
DEL /f /q GFNTools.7z >NUL 2>&1

GOTO :eof

:GET_GFNTOOLS_PROGRAM:
B:
ECHO Downloading GFNTools App...
CD B:\GFNTools
%DL% -LJOk "http://gg.gg/gfntools6exe" >NUL 2>&1
%EXTRACT% x B:\GFNTools\GFNTools.zip -pGFNTools >NUL 2>&1
DEL /f /q GFNTools.zip >NUL 2>&1

GOTO :eof

:EXTRACT_CUSTOM_WALLPAPER:
IF EXIST C:\Fake\Wallpaper.zip (
	ECHO Extracting saved custom wallpaper...
	CD B:\GFNTools\Apps\yEQ2-win-GQEr-xsh-y46G-ell\bin\shell
	DEL /f /q 123.jpg >NUL 2>&1
	%EXTRACT% x C:\Fake\Wallpaper.zip >NUL 2>&1
)

GOTO :eof

:EXTRACT_APP_CONFIG:
IF EXIST C:\Fake\GFNTools_config.zip (
	ECHO Extracting saved GFNTools config...
	CD B:\GFNTools
	%EXTRACT% x C:\Fake\GFNTools_config.zip >NUL 2>&1
)

GOTO :eof

:DELETE_STUFF:
B:
ECHO Deleting unnecessary tools...
CD B:\GFNTools
DEL /f /q 7.exe >NUL 2>&1
DEL /f /q 7z.dll >NUL 2>&1
DEL /f /q %DL% >NUL 2>&1

GOTO :eof

:LAUNCH_WINXSHELL:
B:
ECHO Launching WinXShell...
ECHO GFNTools downloaded! Launching...
CD B:\GFNTools\Apps\yEQ2-win-GQEr-xsh-y46G-ell
START /WAIT "" start.bat >NUL 2>&1

GOTO :eof

:LAUNCH_GFNTOOLS_PROGRAM:
B:
ECHO Launching GFNTools...
CD B:\GFNTools
START "" GFNTools.exe >NUL 2>&1

GOTO :eof

:CHECK_RDL_EXIST:
IF EXIST "%PROGRAMFILES(X86)%\Steam\steamapps\content\app_304930\item_2250811147\files\rdl.exe" (
	GOTO CHECK_RDL_EXIST2
	GOTO :eof
)
GOTO CHECK_RDL_EXIST

:CHECK_RDL_EXIST2:
IF EXIST "%PROGRAMFILES(X86)%\Steam\steamapps\content\app_304930\item_2250811147\files\rdl.exe" (
	FOR %%F IN ("C:\Program Files (x86)\Steam\steamapps\content\app_304930\item_2250811147\files\rdl.exe") DO SET "file_size=%%~zF"
)
CLS
IF DEFINED file_size (
	IF %file_size% EQU 4222464 (
		GOTO :eof
	)
)

GOTO CHECK_RDL_EXIST2

:IS_ON_PC:
IF NOT EXIST "%PROGRAMFILES(X86)%\nxlog" (
	ECHO You are running GFNTools on your own computer. That is not how this works. Please run this file on GeForce NOW.
	PAUSE
	EXIT
)

GOTO :eof
