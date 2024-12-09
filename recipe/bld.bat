REM Build the lib...
nmake /F %RECIPE_DIR%\Makefile.vc build_libs
if errorlevel 1 exit 1

REM done compiling

REM Install step
copy src\gd*.h %LIBRARY_INC%\
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

if not exist %LIBRARY_LIB%\pkgconfig mkdir %LIBRARY_LIB%\pkgconfig
if errorlevel 1 exit 1
sed "s/@VERSION@/%PKG_VERSION%/g" %RECIPE_DIR%\gdlib.pc.in | sed "s#@prefix@#%LIBRARY_PREFIX%#g" > %LIBRARY_LIB%\pkgconfig\gdlib.pc.in
if errorlevel 1 exit 1
