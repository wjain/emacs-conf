;; linum.el
(require 'linum)
(global-linum-mode 1)

;; tabbar
(require 'tabbar)
(tabbar-mode t)
(global-set-key [(control shift tab)] 'tabbar-backward)
(global-set-key [(control tab)]       'tabbar-forward)

;; buffer name
(setq frame-title-format "emacs@%b")
(setq uniquify-buffer-name-style 'forward) 

(setq user-full-name "Jain")
(setq user-mail-address "Jain_Y@126.com")

;; color theme
(require 'color-theme) 
(require 'color-theme-irblack-2)

;; coursor
(setq-default cursor-type 'bar)
(setq visible-bell t)
(tool-bar-mode -1)
(display-time)
(setq column-number-mode t)
(show-paren-mode t)
(setq kill-ring-max 100)
(setq default-fill-column 60)

;; unset tab
(setq-default indent-tabs-mode nil)
(setq default-tab-width 4)
(setq tab-width 4)

(setq c-basic-offset 4)

(fset 'yes-or-no-p 'y-or-n-p)

(setq sentence-end "\\([¡££¡£¿]\\|¡­¡­\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")
(setq sentence-end-double-space nil)

(setq enable-recursive-minibuffers t)

(setq scroll-margin 3
    scroll-conservatively 10000)

;; major mode text-mode
(setq default-major-mode 'text-mode)

(show-paren-mode t)
(setq show-paren-style 'parentheses)

(mouse-avoidance-mode 'animate)

;; can open image
(auto-image-file-mode)

(global-font-lock-mode t)
(require 'highlight)
(transient-mark-mode t)

(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)

;; version control on backup
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)

;; auto backup
;; (setq-default make-backup-files nil)

;; all backups goto ~/.backups instead in the current directory
(setq backup-directory-alist (quote (("." . "~/.backups"))))

;;   dired recursive copy and delete
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;; chinese coding
(set-language-environment 'Chinese-GB)
(set-keyboard-coding-system 'euc-cn)
(set-clipboard-coding-system 'euc-cn)
(set-terminal-coding-system 'euc-cn)
(set-buffer-file-coding-system 'euc-cn)
(set-selection-coding-system 'euc-cn)
(modify-coding-system-alist 'process "*" 'euc-cn)
(setq default-process-coding-system 
      '(euc-cn . euc-cn))
(setq-default pathname-coding-system 'euc-cn)

;; auto pair
(defun my-c-mode-auto-pair ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist '(
                   (?` ?` _ "''")
                   (?\( _ ")")
                   (?\[ _ "]")
                   (?{ \n > _ \n ?} >)
                   (?\" _ "\"")))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "'") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "\"") 'skeleton-pair-insert-maybe))
(add-hook 'c-mode-hook 'my-c-mode-auto-pair)
(add-hook 'c++-mode-hook 'my-c-mode-auto-pair)

(require 'c-toggle-dot-pointer)
(add-hook 'c-mode-common-hook 'c-toggle-dot-pointer)
(add-hook 'c++-mode-common-hook 'c-toggle-dot-pointer)

(require 'tab-display)

(global-set-key [M-left] 'windmove-left)
(global-set-key [M-right] 'windmove-right)
(global-set-key [M-up] 'windmove-up)
(global-set-key [M-down] 'windmove-down)

(provide 'jain-base-config)

