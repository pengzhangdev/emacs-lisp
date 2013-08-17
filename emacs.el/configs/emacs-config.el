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
 '(semantic-c-dependency-system-include-path (quote ("/usr/include" "/usr/src/linux-headers-2.6.35-31-generic/include")))
 '(show-paren-mode t)
 '(text-mode-hook (quote (turn-on-auto-fill text-mode-hook-identify))))
 
(add-to-list 'load-path "./emacs.el/")
(add-to-list 'load-path "./emacs.el/cedet1.7/common/")
(add-to-list 'load-path "./emacs.el/cedet1.7/semantic/")
(add-to-list 'load-path "./emacs.el/cedet1.7/speedbar/")
(add-to-list 'load-path "./emacs.el/cedet1.7/cogre/")
(add-to-list 'load-path "./emacs.el/cedet1.7/contrib/")
(add-to-list 'load-path "./emacs.el/cedet1.7/ede/")
(add-to-list 'load-path "./emacs.el/cedet1.7/eieio/")
(add-to-list 'load-path "./emacs.el/cedet1.7/srecode/")
(add-to-list 'load-path "./emacs.el/cedet1.7/")
(add-to-list 'load-path "./emacs.el/color-theme")
(add-to-list 'load-path "./emacs.el/color-theme/themes")
(add-to-list 'load-path "./emacs.el/yasnippet")
(add-to-list 'load-path "./emacs.el/auto-complete-1.3.1")

;; htmlize
;;(require 'htmlize)

;;dictionary
;;(require 'sdcv)

;;config sdcv
;;(defun search-dictionary (&optional word)
;;  "call sdcv-search-pointer and call windmove-left to return left buffer"
;;(interactive)
;; (sdcv-search-pointer word)
;;)
;;(global-set-key "\C-c\C-d" 'search-dictionary)


;; ;; org mode
;; (require 'org)
;; (require 'org-install)
;; (require 'org-publish)
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (add-hook 'org-mode-hook 'turn-on-font-lock)
;; (add-hook 'org-mode-hook
;;           (lambda () (setq truncate-lines nil)))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-set-key "\C-cb" 'org-iswitchb)
;; (setq org-export-with-sub-superscripts '{})

;; (setq org-publish-project-alist
;;       '(("note-org"
;;          :base-directory "/root/Documents/Notes/orgmodeNotes/org"
;;          :publishing-directory "/root/Documents/Notes/orgmodeNotes/publish"
;;       :base-extension "org"
;;          :recursive t
;;          :publishing-function org-publish-org-to-html
;;          :auto-index t
;;          :index-filename "index.org"
;;          :index-title "index"
;;          :link-home "index.html"
;;          :section-numbers nil
;;          :style "<link rel=\"stylesheet\"
;;                 href=\"./css/stylesheet.css\"
;;                 type=\"text/css\"/>")
;; ;;        ("note-static"
;; ;;         :base-directory "/root/Documents/Notes/orgmodeNotes/org"
;; ;;         :publishing-directory "/root/Documents/Notes/orgmodeNotes/publish"
;; ;;         :recursive t
;; ;;         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
;; ;;         :publishing-function org-publish-attachment)
;;         ("note" 
;;          :components ("note-org")
;;          :author "wertherzhang@gmail.com"
;;          )
;; 	  )
;; )

;; (global-set-key (kbd "<f9> p") 'org-publish)


(defconst user-head-file-dir   (list "./" "../hdr" "../include") "usr head file")

;; my custom code style
(load "my_codestyle.el")

;; O_RDONLY
(defun make-some-files-read-only ()
  "when file opened is of a certain mode, make it read only"
  (when (memq major-mode '(c++-mode tcl-mode text-mode python-mode c-mode java-mode))
    (toggle-read-only 1)))

(add-hook 'find-file-hooks 'make-some-files-read-only)

;;;;(setq default-major-mode 'text-mode)

;;;;bind help-command
;;(global-set-key[f1] 'help-command)

;;设置语言风格和缩进
;;(setq c-basic-offset 4)
;;(add-hook 'c-mode-common-hook ( lambda()
;;				( c-set-style "k&r" ) 
;;				(setq c-basic-offset 4) ) ) ;;设置C语言默认格式 
;;(add-hook 'c++-mode-common-hook ( lambda() 
;;				  (c-set-style "stroustrup") 
;;				  (setq c-basic-offset 4) ) ) ;;设置C++语言默认格式 
	  
;;;Tab 转空格
(setq-default indent-tabs-mode  nil)
(setq default-tab-width 4)
(setq tab-width 4)

;;设置自动模式
;;(add-to-list 'magic-mode-alist'("#include" . c++-mode))
;;(add-to-list 'magic-mode-alist'("#ifndef" . c++-mode))

;;; ido-mode
(require 'ido)
(ido-mode t)

;;;speedbar
(global-set-key [(f4)] 'speedbar-get-focus)

;;设置代码跳转
(global-set-key [(control f3)] 'semantic-ia-fast-jump)
(global-set-key [(control f2)]
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

(global-set-key [(control left)] 'windmove-left)
(global-set-key [(control down)] 'windmove-down)
(global-set-key [(control up)] 'windmove-up)
(global-set-key [(control right)] 'windmove-right)


;;;;加载cedet相关

(load "cedet.el")

(setq semanticdb-default-save-directory "~/.emacs.d/semanticdb/")

;;(defvar semanticdb-database-list nil
;;  	"/usr/include/qt4")

;;;w3m
;;(load "w3m_custom.el")

;;;;;;yasnippet
(require 'yasnippet)
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
                             yas/ido-prompt
                             yas/completing-prompt))
 (yas/global-mode 1)
 
;;;;;;auto-complete
(load "auto-complete-settings.el")

(define-key ac-completing-map "\r" nil) 
(define-key ac-completing-map "\t" nil) 
(define-key ac-completing-map "\M-j" 'ac-complete)

;;;;set global key
(global-set-key "\C-w" 'backward-kill-word)
(global-set-key "\C-x\C-k" 'kill-region)
(global-set-key "\C-c\C-k" 'kill-region)
(global-set-key (kbd "<f6>") 'goto-line)

;;;;smart compile
(load "smart-compile.el")
(global-set-key (kbd "<f7>") 'smart-compile)


;;;; M-x auto complete
(icomplete-mode 1)

;;;; ignore auto save
;;(setq auto-save-default nil)
;;(setq backup-inhibited t)

;;;; auto save to ~/.emacs.d/autobakcup
(setq kept-old-versions 2)
(setq kept-new-versions 5)
(setq delete-old-versions t)
(setq backup-directory-alist '(("." . "~/.emacs.d/autobakcup")))
(setq backup-by-copying t)

;;;; show errors in C/Cpp
(global-cwarn-mode 1)
 
;;;;开启行号
(global-linum-mode t)

 

;;;;启动EDE项目管理
;;(global-ede-mode t)

;;;;开启semantic

(load "semantic")
(require 'semantic-ia)
(require 'semantic-gcc)
;;;;;;cscope
(require 'xcscope)

(semantic-load-enable-minimum-features)
(semantic-load-enable-code-helpers)
(global-semantic-idle-summary-mode)
(global-semantic-decoration-mode nil)
(global-semantic-idle-tag-highlight-mode)
(semantic-load-enable-excessive-code-helpers)
;;(semantic-idle-completions-mode -1)
(global-semantic-highlight-func-mode -1)
(global-semantic-idle-completions-mode -1)
;;(semantic-idle-completion-mode)
;;(global-semantic-decoration-mode)
;;(global-semantic-highlight-func-mode)
;;(semantic-load-enable-excessive-code-helpers)

;;(require 'ecb)

;;;;;代码折叠
(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)
(define-key semantic-tag-folding-mode-map (kbd "C--") 'semantic-tag-folding-fold-block)  
(define-key semantic-tag-folding-mode-map (kbd "C-=") 'semantic-tag-folding-show-block)  

;;;;gtags
(autoload 'gtags-mode "gtags" "" t) 
(gtags-mode 1)
(setq gtags-auto-update 1)
(global-set-key [f3] 'gtags-find-tag-from-here)
(global-set-key [f2] 'gtags-pop-stack)
(global-set-key (kbd "C-c g f") 'gtags-find-tag)  
(global-set-key (kbd "C-c g r") 'gtags-find-rtag)
(global-set-key (kbd "C-c g u") 'gtags-pop-stack)  
(global-set-key (kbd "C-c g s") 'gtags-find-symbols)
(global-set-key (kbd "C-c g g") 'gtags-find-with-grep)
(global-set-key (kbd "C-c g o") 'gtags-select-tag) 
(add-hook 'gtags-select-mode-hook
  '(lambda ()
     (setq hl-line-face 'underline)
     (hl-line-mode 1)
))

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


(global-font-lock-mode t);;语法高亮
(setq font-lock-maximum-decoration t)
(setq font-lock-global-modes '(not shell-mode text-mode))
(setq font-lock-verbose t)
(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

;;(global-hl-line-mode 1)

(setq frame-title-format
'("%S" (buffer-file-name "%f"
(dired-directory dired-directory "%b"))))

(setq default-frame-alist
'((height . 33) (width . 80))
)

;;(set-foreground-color "Wheat")
;;(set-background-color "DarkSlateGray")
;;(set-cursor-color "Orchid")
;;(set-mouse-color "Orchid")

(require 'color-theme)
(setq color-theme-is-global t)
(color-theme-initialize)
(color-theme-install-at-point)
(color-theme-dark-laptop)

(setq display-time-day-and-date t)
(setq display-time-24hr-format t)
(display-time)


;;; my-config.el
(if (file-exists-p "my-config.el") 
   (load "my-config.el") 
   (message "No user custom config file found") )
