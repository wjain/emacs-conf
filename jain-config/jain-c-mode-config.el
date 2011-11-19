;; quick compile and debug in c-mode
;; write by Jain.


(require 'cc-mode)
;; quick compile
(defun quick-compile ()
    "A quick compile funciton for C"
    (interactive)
    (compile (concat "gcc -c " (buffer-name (current-buffer)) " -g -Wall"))
)
(define-key c-mode-base-map [(C-f5)] 'quick-compile)

;;;;;; ------------------------------------------------;;;;;;;;;;;
;;;;; --------------------Gdb-------------------;;;;;;;;;;;
(require 'gdb-ui)
(defun gdb-or-gud-go ()
  "If gdb isn't running; run gdb, else call gud-go."
  (interactive)
  (if (and gud-comint-buffer
           (buffer-name gud-comint-buffer)
           (get-buffer-process gud-comint-buffer)
           (with-current-buffer gud-comint-buffer (eq gud-minor-mode 'gdba)))
      (gud-call (if gdb-active-process "continue" "run") "")
    (gdb (gud-query-cmdline 'gdb))))
(defun gud-break-remove ()
  "Set/clear breakpoin."
  (interactive)
  (save-excursion
    (if (eq (car (fringe-bitmaps-at-pos (point))) 'breakpoint)
        (gud-remove nil)
      (gud-break nil))))
(defun gud-kill ()
  "Kill gdb process."
  (interactive)
  (with-current-buffer gud-comint-buffer (comint-skip-input))
  (kill-process (get-buffer-process gud-comint-buffer)))
(setq gdb-many-windows t)
;; (add-hook 'gdb-mode-hook 
;;            '(lambda ()
;;               (define-key c-mode-base-map [f5] 'gdb-or-gud-go)
;; (define-key c-mode-base-map [S-f5] '(lambda () (interactive) (gud-call "quit" nil)))
;; (define-key c-mode-base-map [S-f5] 'gud-kill)
;;              ;; (define-key c-mode-base-map [C-f7] '(lambda () (interactive) (compile compile-command)))
;;              (define-key c-mode-base-map [f8] 'gud-print)
;;              (define-key c-mode-base-map [C-f8] 'gud-pstar)
;;              (define-key c-mode-base-map [f9] 'gud-break-remove)
;;              ;; (define-key c-mode-base-map [f9] 'gud-break)
;;              ;; (define-key c-mode-base-map [C-f9] 'gud-remove)
;;              (define-key c-mode-base-map [f10] 'gud-next)
;;              (define-key c-mode-base-map [C-f10] 'gud-until)
;;              (define-key c-mode-base-map [S-f10] 'gud-jump)
;;              (define-key c-mode-base-map [f11] 'gud-step)
;;              (define-key c-mode-base-map [C-f11] 'gud-finish)))
(global-set-key [(f5)] 'gdb-or-gud-go)
(global-set-key [S-f5] 'gud-kill)
(global-set-key [(f6)] 'gud-next)
(global-set-key [(f7)] 'gud-step)
(global-set-key [C-f6] 'gud-until)
(global-set-key [C-f7] 'gud-finish)
(global-set-key [S-f7] 'gud-jump)
(global-set-key [f8] 'gud-cont)
(global-set-key [f9] 'gud-break-remove)

(provide 'jain-c-mode-config)