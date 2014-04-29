
(add-to-list 'load-path "~/my-lisps/auto-complete-1.3/")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/my-lisps/auto-complete-1.3/dict")
(ac-config-default)

(setq ac-auto-start nil)
;; (setq ac-show-menu-timer 0.5)
(setq ac-quick-help-delay 0.5)

(defun my-ac-config ()
  ;; (setq ac-clang-flags (split-string "-I/mingw/include 
  ;;                                              -I/mingw/lib/gcc/mingw32/4.5.0/include/c++ 
  ;;                                              -I/mingw/lib/gcc/mingw32/4.5.0/include/c++/backward                                                
  ;;                                              -I/mingw/lib/gcc/mingw32/4.5.0/include/c++/mingw32
  ;;                                              -I/mingw/lib/gcc/mingw32/4.5.0/include-fixed"))
  (setq-default ac-sources '(ac-source-abbrev
                             ac-source-dictionary
                             ac-source-words-in-same-mode-buffers))
  (add-hook 'emacs-lisp-mode-hook 'ac-emacs-lisp-mode-setup)  
  (add-hook 'c-mode-common-hook 'ac-cc-mode-setup)  
  (add-hook 'ruby-mode-hook 'ac-ruby-mode-setup)  
  (add-hook 'css-mode-hook 'ac-css-mode-setup)  
  (add-hook 'auto-complete-mode-hook 'ac-common-setup)
  (global-auto-complete-mode t))

(defun my-ac-cc-mode-setup ()  
  (setq ac-sources (append ac-sources
;;  (setq ac-sources
                           '(ac-source-semantic
                             ac-source-semantic-raw
                             ac-source-yasnippet))))

(add-hook 'c-mode-common-hook 'my-ac-cc-mode-setup)
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
















