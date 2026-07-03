@echo off
set VCVARS="G:\Program Files\Microsoft Visual Studio\2022\Community\VC\Auxiliary\Build\vcvars64.bat"
if exist %VCVARS% (
    call %VCVARS%
) else (
    echo "vcvars64.bat bulunamadi, lutfen Visual Studio 2022 kurulum yolunuzu kontrol edin."
    exit /b 1
)

if not exist build mkdir build
cd build

echo "Derleniyor..."
cl.exe /nologo /O2 /MD /EHsc /I..\Include /I..\Src ..\Src\binkace.c ..\Src\popmal.c ..\Src\varbits.c ..\Src\binka_ue_encode.cpp ..\Src\radfft.cpp ..\Src\ranged_log.cpp ..\Src\binka_encode_main.cpp ..\Src\x86_cpu.c /DWRAP_PUBLICS=BACEUE /D__RADINSTATICLIB__ /Febinka_encode.exe

if %ERRORLEVEL% equ 0 (
    echo "Derleme basarili! build\binka_encode.exe olusturuldu."
) else (
    echo "Derleme hatasi!"
)
cd ..
