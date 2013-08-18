;;; This file define the start function and also some configs( key map, etc )
;;; for all the plugins.
;;; All the plugins is enabled in emacs-config.el

(defun enable-codestype()
  "load codestyle file and enable codestyle"
  (load "my_codestyle.el")
  )

(defun enable-speedbar()
  "enable speedbar and bind to key F4"
  (local-set-key [(f4)] 'speedbar-get-focus)
  )

(defun enable-semantic()
  "enable semantic"
  ;; remember load cedet.el
  (load "semantic")
  (require 'semantic-ia)
  (require 'semantic-gcc)
  (semantic-load-enable-minimum-features)
  (semantic-load-enable-code-helpers)
  ;; (global-semantic-idle-summary-mode)
  ;; (global-semantic-decoration-mode nil)
  ;; (global-semantic-idle-tag-highlight-mode)
  (semantic-idle-summary-mode)
  (semantic-decoration-mode nil)
  (semantic-idle-tag-highlight-mode)
  (semantic-load-enable-excessive-code-helpers)
  ;; (global-semantic-highlight-func-mode -1)
  ;; (global-semantic-idle-completions-mode -1)
  (semantic-highlight-func-mode -1)
  (semantic-idle-completions-mode -1)

  ;; code folder
  (require 'semantic-tag-folding nil 'noerror)
  (global-semantic-tag-folding-mode 1)
  (define-key semantic-tag-folding-mode-map (kbd "C--") 'semantic-tag-folding-fold-block)  
  (define-key semantic-tag-folding-mode-map (kbd "C-=") 'semantic-tag-folding-show-block)  

  ;; set semantic db location
  (setq semanticdb-default-save-directory "~/.emacs.d/semanticdb/")

  ;; bind key to semantic-ia-fast-jump
  (local-set-key [(control f3)] 'semantic-ia-fast-jump)
  (local-set-key [(control f2)]
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
  )


(defun enable-yasnippet()
  "enable yasnippet"
  (require 'yasnippet)
  (require 'dropdown-list)
  (setq yas/prompt-functions '(yas/dropdown-prompt
			       yas/ido-prompt
			       yas/completing-prompt))
  (yas/global-mode 1)
 
  )

(defun enable-autocomplete()
  "enable autocomplete"
  (load "auto-complete-settings.el")
  (icomplete-mode 1)
  (define-key ac-completing-map "\r" nil) 
  (define-key ac-completing-map "\t" nil) 
  (define-key ac-completing-map "\M-j" 'ac-complete)
  )

(defun enable-smartcompile()
  "enable smart-compile"
  (load "smart-compile.el")
  (local-set-key (kbd "<f7>") 'smart-compile)
  )

(defun config-emacs-autosave()
  "set autosave path"
  (setq kept-old-versions 2)
  (setq kept-new-versions 5)
  (setq delete-old-versions t)
  (setq backup-directory-alist '(("." . "~/.emacs.d/autobakcup")))
  (setq backup-by-copying t)
  )

(defun enable-cwarn()
  "enable cwarn mode"
  (cwarn-mode 1)
  )

(defun enable-gtags()
  "enable gtags"
  (autoload 'gtags-mode "gtags" "" t) 
  (gtags-mode 1)
  (setq gtags-auto-update 1)
  (local-set-key [f3] 'gtags-find-tag-from-here)
  (local-set-key [f2] 'gtags-pop-stack)
  (local-set-key (kbd "C-c g f") 'gtags-find-tag)  
  (local-set-key (kbd "C-c g r") 'gtags-find-rtag)
  (local-set-key (kbd "C-c g u") 'gtags-pop-stack)  
  (local-set-key (kbd "C-c g s") 'gtags-find-symbols)
  (local-set-key (kbd "C-c g g") 'gtags-find-with-grep)
  (local-set-key (kbd "C-c g o") 'gtags-select-tag) 
  (add-hook 'gtags-select-mode-hook
	    '(lambda ()
	       (setq hl-line-face 'underline)
	       (hl-line-mode 1)
	       ))
  )


