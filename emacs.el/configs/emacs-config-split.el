(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(display-time-mode t)
 '(face-font-family-alternatives (quote (("YaHei Consolas Hybrid" "courier" "fixed") ("courier" "CMU Typewriter Text" "fixed") ("Sans Serif" "helv" "helvetica" "arial" "fixed") ("helv" "helvetica" "arial" "fixed"))))
 '(face-font-registry-alternatives (quote (("unicode-bmp" "gb2312.1980" "gb2312.80&gb8565.88" "gbk" "gb18030") ("jisx0208.1990" "jisx0208.1983" "jisx0208.1978") ("ksc5601.1989" "ksx1001.1992" "ksc5601.1987") ("muletibetan-2" "muletibetan-0"))))
 '(scroll-bar-mode (quote right))
 '(semantic-c-dependency-system-include-path (quote ("/usr/include")))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))


(defun make-some-files-read-only ()
  "when file opened is of a certain mode, make it read only"
  (when (memq major-mode '(c++-mode tcl-mode text-mode python-mode c-mode java-mode))
    (toggle-read-only 1)))

(add-hook 'find-file-hooks 'make-some-files-read-only)

(require 'ido)
(ido-mode t)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "<f6>") 'goto-line)

(global-set-key [(control left)] 'windmove-left)
(global-set-key [(control down)] 'windmove-down)
(global-set-key [(control up)] 'windmove-up)
(global-set-key [(control right)] 'windmove-right)

(require 'highlight-symbol)
(global-set-key [f5] 'highlight-symbol-at-point)
(global-set-key [(control f5)] 'highlight-symbol-next)
(global-set-key [(shift f5)] 'highlight-symbol-prev)
(global-set-key [(meta f5)] 'highlight-symbol-prev)
(global-set-key [(control meta f5)] 'highlight-symbol-query-replace)


(load "cedet.el")
(load "plugin_config.el")

;;;; c/cpp mode plugins
(dolist (hook '(c-mode-hook c++-mode-hook))
  (add-hook hook
	  '(lambda()
	     (enable-codestype)
	     (enable-speedbar)
	     (enable-semantic)
	     (enable-yasnippet)
	     (enable-autocomplete)
	     (ebabke-smartcompile)
	     (config-emacs-autosave)
	     (enable-cwarn)
	     (enable-gtags)
	     )))

;;;; shell/lisp mode
(dolist (hook '(shell-mode-hook emacs-lisp-mode-hook))
  (add-hook hook
	    '(lambda()
	       (enable-semantic)
	       (enable-yasnippet)
	       (enable-autocomplete)
	       (enable-smartcompile)
	       (config-emacs-autosave)
	       )))

;;;; java plugins



(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


(global-font-lock-mode t)
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))


;;; This if for X window and show file path in title bar
(setq frame-title-format
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))


;; I rember this is for X window.
(setq default-frame-alist
'((height . 33) (width . 80))
)

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-install-at-point)
(color-theme-dark-laptop)

;;;; status bar
(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)


;;; my-config.el
(if (file-exists-p "my-config.el") 
   (load "my-config.el") 
   (message "No user custom config file found") )










