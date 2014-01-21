emacs-lisp
==========

./install-emacs-config.sh  to install the config

configs
===========

## flymake ##

If you'd like to user flymake , pls add below to Makefile.

```
check-syntax:
     gcc -o nul -S ${CHK_SOURCES}

 ```

And in emacs, run ```M-x flymake-mode <RET>```
