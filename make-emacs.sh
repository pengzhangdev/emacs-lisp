cd emacs
./autogen.sh
./configure --without-makeinfo --with-x-toolkit=no --with-xpm=no --with-jpeg=no --with-png=no --with-gif=no --with-tiff=no
make bootstrap
