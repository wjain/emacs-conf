(setq load-path (append load-path '("~/my-lisps/python")))

;; pymacs
(require 'pymacs)
(autoload 'pymacs-apply "pymacs")
(autoload 'pymacs-call "pymacs")
(autoload 'pymacs-eval "pymacs" nil t)
(autoload 'pymacs-exec "pymacs" nil t)
(autoload 'pymacs-load "pymacs" nil t)

;; ropemacs
(pymacs-load "ropemacs" "rope-")
(setq ropemacs-enable-autoimport t)

;; pycomplete
(require 'pycomplete)
(setq auto-mode-alist (cons '("\\.py$" . python-mode) auto-mode-alist))
(autoload 'python-mode "python-mode" "Python editing mode." t)
(setq interpreter-mode-alist(cons '("python" . python-mode)
                                  interpreter-mode-alist))

;; pdb setup, note the python version
;; (setq pdb-path 'e:/python27/Lib/pdb.py
;;       gud-pdb-command-name (symbol-name pdb-path))
;; (defadvice pdb (before gud-query-cmdline activate)
;;   "Provide a better default command line when called interactively."
;;   (interactive
;;    (list (gud-query-cmdline pdb-path
;;                             (file-name-nondirectory buffer-file-name)))))

(provide 'jain-python-config)