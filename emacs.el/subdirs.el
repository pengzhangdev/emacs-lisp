(defun emacs-add-subdirs-to-load-path (dir) 
(let ((default-directory (concat dir "/"))) 
  (setq load-path (cons dir load-path))
  (if (fboundp 'normal-top-level-add-subdirs-to-load-path)
  (normal-top-level-add-subdirs-to-load-path))))

