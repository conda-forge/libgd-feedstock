#!/bin/sh
aclocal && autoconf
./configure --prefix=$PREFIX \
            --without-xpm \
            --without-x \
            --disable-werror \
|| { cat config.log; exit 1; }

make && make install

if [ "$(uname)" == "Darwin" ]; then
    make check || failed=1
    grep -rl "DYLD_LIBRARY_PATH=" tests | xargs sed -i.bak "s~DYLD_LIBRARY_PATH=.*~DYLD_LIBRARY_PATH=$PREFIX/lib~g"
fi

# see: https://github.com/libgd/libgd/issues/302
export FREETYPE_PROPERTIES=truetype:interpreter-version=35
make check || { cat tests/test-suite.log; exit 1; }
