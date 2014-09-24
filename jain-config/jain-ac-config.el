(add-to-list 'load-path "~/my-lisps/auto-complete-1.3.1/")
(require 'auto-complete)  
(add-to-list 'ac-dictionary-directories "~/my-lisps/auto-complete-1.3.1/dict")
(require 'auto-complete-config)
(ac-config-default)

(setq ac-auto-start nil)
;; (setq ac-show-menu-timer 0.5)
(setq ac-quick-help-delay 0.5)

;; (require 'auto-complete-clang-async)
(require 'auto-complete-clang)

(defun my-ac-config ()
  (setq ac-clang-flags (list "-I/mingw/include" 
                             "-I/mingw/lib/gcc/mingw32/4.8.1/include/c++"
                             "-I/mingw/lib/gcc/mingw32/4.8.1/include/c++/backward"
                             "-I/mingw/lib/gcc/mingw32/4.8.1/include/c++/migw32"
                             "-I/mingw/lib/gcc/mingw32/4.8.1/include-fixed"
                             "-ID:/Program Files/Microsoft Visual Studio/VC98/Include"
                             "-ID:/Program Files/Microsoft Visual Studio/VC98/ATL/Include"
                             "-ID:/Program Files/Microsoft Visual Studio/VC98/MFC/Include"))
  (setq-default ac-sources '(ac-source-abbrev
                             ac-source-dictionary
                             ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  (add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))


(defun my-ac-clang-async-mode-setup ()
   (setq ac-clang-complete-executable "~/.emacs.d/clang-complete")
   (setq ac-sources '(ac-source-clang-async))
   (ac-clang-launch-completion-process)
)

(defun my-ac-clang-mode-setup ()
  (setq ac-sources (append '(ac-source-clang ac-source-yasnippet) ac-sources))
)

;;(add-hook 'c-mode-common-hook 'my-ac-clang-async-mode-setup)
(add-hook 'c-mode-common-hook 'my-ac-clang-mode-setup)

;; ac-source-gtags  
(my-ac-config)

(define-key ac-mode-map  (kbd "M-/") 'auto-complete)

(defun ac-complete-semantic-self-insert (arg)
    (interactive "p")
    (self-insert-command arg)
    (ac-complete))
(local-set-key "." 'ac-complete-semantic-self-insert)
(local-set-key ">" 'ac-complete-semantic-self-insert)

;; (ac-set-trigger-key ".")

(provide 'jain-ac-config)
