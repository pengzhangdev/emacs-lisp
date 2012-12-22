(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives (quote (("Monospace" "courier" "fixed") ("courier" "CMU Typewriter Text" "fixed") ("Sans Serif" "helv" "helvetica" "arial" "fixed") ("helv" "helvetica" "arial" "fixed"))))
 '(face-font-registry-alternatives (quote (("unicode-bmp" "gb2312.1980" "gb2312.80&gb8565.88" "gbk" "gb18030") ("jisx0208.1990" "jisx0208.1983" "jisx0208.1978") ("ksc5601.1989" "ksx1001.1992" "ksc5601.1987") ("muletibetan-2" "muletibetan-0"))))
 '(scroll-bar-mode (quote right))
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" "/usr/src/linux-headers-2.6.35-31-generic/include")))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))



;;设置语言风格和缩进
(setq c-basic-offset 4)
(add-hook 'c-mode-common-hook ( lambda()
				( c-set-style "k&r" ) 
				(setq c-basic-offset 4) ) ) ;;设置C语言默认格式 
(add-hook 'c++-mode-common-hook ( lambda() 
				  ( c-set-style "k&r" ) 
				  (setq c-basic-offset 4) ) ) ;;设置C++语言默认格式 

;;设置自动模式
;;(add-to-list 'magic-mode-alist'("#include" . c++-mode))
;;(add-to-list 'magic-mode-alist'("#ifndef" . c++-mode))

;;;speedbar
(global-set-key [(f4)] 'speedbar-get-focus)

;;设置代码跳转
(global-set-key [f3] 'semantic-ia-fast-jump)
(global-set-key [S-f3]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;;;;加载cedet相关
;;(load "cedet.elc")
(load "/home/werther/Ubuntu One/cedet1.7/common/cedet.el")

(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb/")

;;(defvar semanticdb-database-list nil
;;  	"/usr/include/qt4")

;;;;;;yasnippet
(add-to-list 'load-path
            "/home/werther/Ubuntu One/yasnippet")
(require 'yasnippet)
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

 (yas/global-mode 1)
 
;;;;;;auto-complete
(add-to-list 'load-path "/home/werther/Ubuntu One/auto-complete-1.3.1")
(load "auto-complete-settings.el")



;;;;set global key
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)

;;;;开启行号
(global-linum-mode t)

 

;;;;启动EDE项目管理
(global-ede-mode t)

;;;;开启semantic

(load "semantic")
(require 'semantic-ia)

;;;;;;cscope
;;(require 'xcscope)

(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(global-semantic-idle-summary-mode)
(global-semantic-decoration-mode)
(global-semantic-highlight-func-mode)
;;(semantic-load-enable-excessive-code-helpers)

;;;;;代码折叠
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C--") 'semantic-tag-folding-fold-block)  
(define-key semantic-tag-folding-mode-map (kbd "C-=") 'semantic-tag-folding-show-block)  

;;;;gtags
;;(autoload 'gtags-mode "gtags" "" t) 
;;(gtags-mode 1)
;;(global-set-key (kbd "C-c g f") 'gtags-find-tag)  
;;(global-set-key (kbd "C-c g p") 'gtags-pop-stack)  
;;(global-set-key (kbd "C-c g s") 'gtags-select-tag) 

;;(semantic-mode)

(semantic-add-system-include "/usr/include/qt4/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtGui/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtXml/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtTest/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtCore/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtDesigner/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtOpenGL/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtScript/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtNetwork/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtUiTools/" 'c++-mode)
(semantic-add-system-include "/usr/include/qt4/QtXmlPatterns/" 'c++-mode)
(semantic-add-system-include "/usr/src/linux-headers-2.6.35-30-generic/include/" 'c-mode)

(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_GUI_EXPORT" . ""))
(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_CORE_EXPORT" . ""))
(setq qt4-base-dir "/usr/include/qt4")
(setq qt4-gui-dir (concat qt4-base-dir "/QtGui"))
(semantic-add-system-include qt4-base-dir 'c++-mode)
(semantic-add-system-include qt4-gui-dir 'c++-mode)
(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-large.h"))
(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))

(setq auto-mode-alist
      (cons '("\\.h$" . c++-mode)
	    auto-mode-alist))

(setq frame-title-format "%b")


(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "white" :foreground "black" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))


(setq default-frame-alist
'((height . 33) (width . 80))
)


