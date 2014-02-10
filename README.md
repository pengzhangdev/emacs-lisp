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

## emacs + slime + sbcl ##

if you'd like to use slime to debug or write common lisp, pls install `common-lisp-controller` which will install sbcl to /usr/bin/ .

