:: -----------------------------------------------------------------
:: File:   build.bat
:: Author: (c) 2024 Jens Kallup - paule32
:: All rights reserved
::
:: only for education, and non-profit usage !
::
:: This batch file is optimized for a 64-Bit compilation, only.
:: I did not test other tools for 32-Bit or operating systems other
:: than Microsoft Windows 10/11 64-Bit Professional.
::
:: For compile this project you must have a minimum of:
:: - a copy of FPC 3.2.0 64-Bit Microsoft Windows 10/11 64-Bit
:: - a copy of NASM for Windows 10/11 (netwide assembler)
:: - a copy of MSYS2 64-Bit with installed gcc.exe MinGW-64 Bit
:: - a copy of msys2 tools like awk, sed, ...
:: - a copy of Python3 for the filter.py script
::
:: You have to start the build.ps1 script, firstly. PowerShell will
:: call this script with all the setting parameters.
:: So, dont touch a running system - I give no warantees of damages
:: or other fees.
:: !!! YOU USE IT AT YOUR OWN RISK !!!
:: -----------------------------------------------------------------
@echo off
echo Compile help documentation. This can take awhile...

:: -----------------------------------------------------------------
:: first, delete old doxgen + filter.py output content ...
:: -----------------------------------------------------------------
echo =[ remove old data files...      ]=   10 %%
rm -rf ./dox/html
rm -rf ./dox/chm

:: -----------------------------------------------------------------
:: first step, generate the html files depend on the source files...
:: -----------------------------------------------------------------
echo =[ create doxygen html files...  ]=   12 %%
E:\doxygen\bin\doxygen.exe Doxyfile.Server.chm.ini >nul 2>nul
if errorlevel 1 (goto error_doxygen)

:: -----------------------------------------------------------------
:: second step, generate the html dot images files...
:: -----------------------------------------------------------------
echo =[ create dot tool files...      ]=   14 %%
E:\Graphviz\bin\dot.exe -Tpng .\doc\dot\datentypen.dot -o .\doc\dot\img\datentypen.png

:: -----------------------------------------------------------------
:: if no error, create/parse the compiled help HTML files ...
:: -----------------------------------------------------------------
set PYTHONHOME=
python filter.py .\dox\html .\dox\chm
if errorlevel 1 (goto error_filter)

copy .\doc\img\license.png .\dox\chm\license.png

:: -----------------------------------------------------------------
:: third step, copy the doxygen generated HTML workshop files...
:: -----------------------------------------------------------------
echo =[ copy project files...         ]=   10 %%
copy .\dox\html\index.hhc .\dox\chm\index.hhc >nul 2>nul
copy .\dox\html\index.hhk .\dox\chm\index.hhk >nul 2>nul
copy .\dox\html\index.hhp .\dox\chm\index.hhp >nul 2>nul

:: -----------------------------------------------------------------
:: copy the used media files to the output directory ...
:: -----------------------------------------------------------------
echo =[ copy style data files...      ]=   20 %%
copy .\dox\html\*.css .\dox\chm >nul 2>nul
copy .\dox\html\*.map .\dox\chm >nul 2>nul

echo =[ copy script data files...     ]=   60 %%
copy .\dox\html\*.js  .\dox\chm >nul 2>nul
copy .\dox\html\*.md5 .\dox\chm >nul 2>nul

copy .\doc\dot\img\*.png .\dox\chm
:: -----------------------------------------------------------------
:: fourth step, create the compiled .chm file ...
:: -----------------------------------------------------------------
echo =[ create help.chm file...       ]=   80 %%
"C:\Program Files (x86)\HTML Help Workshop\hhc.exe" .\dox\chm\index.hhp
copy .\dox\chm\server.chm .\server1.chm

:: -----------------------------------------------------------------
:: if no error, then all is done ...
:: -----------------------------------------------------------------
echo =[ done.                         ]=  100 %%
goto eof
:: -----------------------------------------------------------------
:: error section ...
:: -----------------------------------------------------------------
:error_filter
echo filter.py report a error level.
goto eof
:error_hhc
echo HTML Help Workshop compile failed.
goto eof
:error_doxygen
echo doxygen translation failed.
:eof
:: -----------------------------------------------------------------
:: E O F  -  End Of File.
:: -----------------------------------------------------------------
