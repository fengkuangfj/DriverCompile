@echo off

rem %1 Debug\Release
rem %2 Win32\x64
rem %3 makefile所在目录
rem %4 希望Debug\Release所在目录
rem %5 目标文件名
rem ..\..\Compile\MyCompile.bat $(Configuration) $(Platform) $(ProjectDir) $(SolutionDir) $(TargetName)

if "Debug"=="%1" (
set CHK_OR_FRE=chk
) else (
set CHK_OR_FRE=fre
)

if "Win32"=="%2" (
set X86_OR_X64=x86
set WXP_OR_WIN7=wxp
set X86_OR_AMD64=x86
set I386_OR_AMD64=i386
) else (
set X86_OR_X64=x64
set WXP_OR_WIN7=win7
set X86_OR_AMD64=amd64
set I386_OR_AMD64=amd64
)

cd /d "%WINDDK7ROOT%\bin"
call "setenv.bat" %WINDDK7ROOT% %CHK_OR_FRE% %X86_OR_X64% %WXP_OR_WIN7%
cd /d "%3"
build

if not "1"=="%errorlevel%" (
cd /d "%4"
if not exist "%4\%1\%X86_OR_X64%" (
mkdir "%4\%1\%X86_OR_X64%"
)
copy /y "%3\obj%CHK_OR_FRE%_%WXP_OR_WIN7%_%X86_OR_AMD64%\%I386_OR_AMD64%\%5.sys" "%4\%1\%X86_OR_X64%\%5.sys"
copy /y "%3\obj%CHK_OR_FRE%_%WXP_OR_WIN7%_%X86_OR_AMD64%\%I386_OR_AMD64%\%5.pdb" "%4\%1\%X86_OR_X64%\%5.pdb"
)
