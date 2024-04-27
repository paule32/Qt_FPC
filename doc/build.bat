@echo off
echo Compile help documentation. This can take awhile...
rm -rf ./dox/html
E:\doxygen\bin\doxygen.exe Doxyfile.Server.chm.ini >nul 2>nul
if errorlevel 1 (goto error)
echo done.
goto eof
:error
echo compile failed.
:eof
