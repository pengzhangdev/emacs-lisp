(custom-set-variables
  ;; custom-set-variables was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(face-font-family-alternatives (quote (("Monospace" "courier" "fixed") ("courier" "CMU Typewriter Text" "fixed") ("Sans Serif" "helv" "helvetica" "arial" "fixed") ("helv" "helvetica" "arial" "fixed"))))
 '(face-font-registry-alternatives (quote (("unicode-bmp" "gb2312.1980" "gb2312.80&gb8565.88" "gbk" "gb18030") ("jisx0208.1990" "jisx0208.1983" "jisx0208.1978") ("ksc5601.1989" "ksx1001.1992" "ksc5601.1987") ("muletibetan-2" "muletibetan-0"))))
 '(scroll-bar-mode (quote right))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))


;; add load path
(add-to-list 'load-path "/home/werther/emacs.el/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/cogre/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/semantic/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/speedbar/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/contrib/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/eieio/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/srecode/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/common/")
(add-to-list 'load-path "/home/werther/emacs.el/cedet-1.0pre7/ede/")
(add-to-list 'load-path "/home/werther/emacs.el/yasnippet/")
(add-to-list 'load-path "/home/werther/emacs.el/auto-complete-1.3.1")
(add-to-list 'load-path "/home/werther/emacs.el/ecb-2.40/")
(add-to-list 'load-path "/home/werther//emacs.el/color-theme")
(add-to-list 'load-path "/home/werther//emacs.el/color-theme/themes")
(add-to-list 'load-path "/home/werther/emacs.el/org/lisp")

;; htmlize
(require 'htmlize)

;; org mode
(require 'org)
(require 'org-install)
(require 'org-publish)
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(add-hook 'org-mode-hook
          (lambda () (setq truncate-lines nil)))
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(setq org-export-with-sub-superscripts '{})

(setq org-publish-project-alist
      '(("note-org"
         :base-directory "/root/tmp/Notes/org"
         :publishing-directory "/root/tmp/Notes/publish"
      :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index t
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
                href=\"./css/stylesheet.css\"
                type=\"text/css\"/>")
;;        ("note-static"
;;         :base-directory "/root/Documents/Notes/orgmodeNotes/org"
;;         :publishing-directory "/root/Documents/Notes/orgmodeNotes/publish"
;;         :recursive t
;;         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
;;         :publishing-function org-publish-attachment)
;;        ("note" 
;;         :components ("note-org" "note-static")
;;         :author "wertherzhang@gmail.com"
;;         )
	  )
)

(global-set-key (kbd "<f9> p") 'org-publish)

;; shell
(ansi-color-for-comint-mode-on)

;;Create MyCppStyle
(defconst lttCppStyle
'((c-tab-always-indent . t)
(c-comment-only-line-offset . 0)
(c-hanging-braces-alist . ((substatement-open after)
(brace-list-open)))
(c-cleanup-list . (comment-close-slash
compact-empty-funcall))

(c-offsets-alist . ((substatement-open . 0)
(innamespace . 0)
(case-label . *)
(access-label . /)
(inline-open . 0)
(block-open . 0)))

(setq comment-start "/*"
        comment-end "*/"))
"ltt cpp style")
(c-add-style "lttCppStyle" lttCppStyle)


;;设置语言风格和缩进
(setq-default indent-tabs-mode nil)
(setq c-basic-offset 4)
(add-hook 'c-mode-common-hook ( lambda()
				( c-set-style "lttCppStyle" ) 
				(setq c-basic-offset 4) ) ) ;;设置C语言默认格式 
(add-hook 'c++-mode-common-hook ( lambda() 
				  ( c-set-style "lttCppStyle" ) 
				  (setq c-basic-offset 4) ) ) ;;设置C++语言默认格式 


(defun make-some-files-read-only ()
  "when file opened is of a certain mode, make it read only"
    (when (memq major-mode '(c++-mode c-mode java-mode))
        (toggle-read-only 1)))

(add-hook 'find-file-hooks 'make-some-files-read-only)


;;设置自动模式
;;(add-to-list 'magic-mode-alist'("#include" . c++-mode))
;;(add-to-list 'magic-mode-alist'("#ifndef" . c++-mode))

;;;speedbar
(global-set-key [(f4)] 'speedbar-get-focus)

;;设置代码跳转
(global-set-key [f3] 'semantic-ia-fast-jump)
(global-set-key [f2]
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
;; highligth
(require 'highlight-symbol)
(global-set-key [f5] 'highlight-symbol-at-point)
(global-set-key [(control f5)] 'highlight-symbol-next)
(global-set-key [(shift f5)] 'highlight-symbol-prev)
(global-set-key [(meta f5)] 'highlight-symbol-prev)
(global-set-key [(control meta f5)] 'highlight-symbol-query-replace)

;; ecb codebrowser
;;(require 'ecb)
;;(require 'ecb-autoloads)

;;;;加载cedet相关
;;(load "cedet.elc")
(load "/home/werther/emacs.el/cedet-1.0pre7/common/cedet.el")
(require 'eassist nil 'noerror)
(global-set-key [(f2)] 'eassist-switch-h-cpp)

(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb/")

;;(defvar semanticdb-database-list nil
;;  	"/usr/include/qt4")


;;;;;;yasnippet
(require 'yasnippet)
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))

(yas/global-mode 1)

(load "/home/werther/emacs.el/smart-compile.el")
(global-set-key (kbd "<f7>") 'smart-compile)

;;;;auto-complete
(load "auto-complete-settings")
(define-key ac-completing-map "\r" nil) 
(define-key ac-completing-map "\t" nil) 
(define-key ac-completing-map "\M-j" 'ac-complete)

(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "<f6>") 'goto-line)

;;;;开启行号
(global-linum-mode t)

 

;;;;启动EDE项目管理
(global-ede-mode t)

;;;;开启semantic

(load "semantic")
(require 'semantic-ia)

;;;;;;cscope
(load "/home/werther/emacs.el/cscope-15.7a/contrib/xcscope/xcscope.el")
(require 'xcscope)

(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(global-semantic-idle-summary-mode)
(global-semantic-decoration-mode)
(global-semantic-highlight-func-mode)
;;(global-semantic-idle-tag-highlight-mode)
;;(semantic-idle-tag-highlight-mode)
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

;;(semantic-add-system-include "/usr/include/qt4/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtGui/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtXml/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtTest/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtCore/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtDesigner/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtOpenGL/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtScript/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtNetwork/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtUiTools/" 'c++-mode)
;;(semantic-add-system-include "/usr/include/qt4/QtXmlPatterns/" 'c++-mode)
;;(semantic-add-system-include "/usr/src/linux-headers-2.6.35-30-generic/include/" 'c-mode)
(semantic-add-system-include "/work/cos-ocn-patch/frameworks_gaia/base/include/" 'c++-mode)
(semantic-add-system-include "/work/cos-ocn-patch/common/frameworks/base/include/" 'c++-mode)
(semantic-add-system-include "/work/cos-ocn-patch/pdk/frameworks/base/include/" 'c++-mode)
(semantic-add-system-include "/work/cos-ocn-patch/common/system/core/include/" 'c++-mode)

;;(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_GUI_EXPORT" . ""))
;;(add-to-list 'semantic-lex-c-preprocessor-symbol-map '("Q_CORE_EXPORT" . ""))
;;(setq qt4-base-dir "/usr/include/qt4")
;;(setq qt4-gui-dir (concat qt4-base-dir "/QtGui"))
;;(semantic-add-system-include qt4-base-dir 'c++-mode)
;;(semantic-add-system-include qt4-gui-dir 'c++-mode)
;;(add-to-list 'auto-mode-alist (cons qt4-base-dir 'c++-mode))
;;(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig.h"))
;;(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qconfig-large.h"))
;;(add-to-list 'semantic-lex-c-preprocessor-symbol-file (concat qt4-base-dir "/Qt/qglobal.h"))

(setq auto-mode-alist
      (cons '("\\.h$" . c++-mode)

	    auto-mode-alist))

(setq frame-title-format "%b")



(custom-set-faces
  ;; custom-set-faces was added by Custom.
  ;; If you edit it by hand, you could mess it up, so be careful.
  ;; Your init file should contain only one such instance.
  ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "black" :foreground "white" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :foundry "unknown" :family "DejaVu Sans Mono")))))
 
;;(set-foreground-color "Wheat")
;;(set-background-color "DarkSlateGray")
(set-cursor-color "Orchid")
(set-mouse-color "Orchid")

(setq frame-title-format
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))


(setq default-frame-alist
'((height .40 ) (width . 100))
)

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-install-at-point)
(color-theme-dark-laptop)

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)

(defun max-window()
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
(x-send-client-message nil 0 nil "_NET_WM_STATE" 32
'(2 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
)
(run-with-idle-timer 1 nil 'max-window)

(tool-bar-mode nil)

