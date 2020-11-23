echo %RECIPE_DIR%

echo current working dir is:
echo %cd%
echo
echo inclue and library:
echo %INCLUDE%
echo %LIBRARY_INC%

REM Build the lib...
nmake /f %RECIPE_DIR%\Makefiletest.vc
nmake /f %RECIPE_DIR%\Makefile.vc check
REM nmake /f %RECIPE_DIR%\Makefile.vc build_libs
if errorlevel 1 exit 1

REM done compiling

REM Install step
copy src\*.h %LIBRARY_INC%\	
if errorlevel 1 exit 1
cd .\gdbuild
copy libgd.dll %LIBRARY_BIN%\
if errorlevel 1 exit 1
copy libgd.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1
copy libgd.lib %LIBRARY_LIB%\gd.lib
if errorlevel 1 exit 1
copy libgd_a.lib %LIBRARY_LIB%\
if errorlevel 1 exit 1