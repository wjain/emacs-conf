;;;;; ------------------------------------------------;;;;;;;;;;;
;;;;; -------------------- Ecb -------------------;;;;;;;;;;;
;;;; load ecb
(setq load-path (append load-path '("~/my-lisps/ecb-2.40")))
(require 'ecb)

;(setq ecb-auto-activate t
;;     ecb-tip-of-the-day nil)

 

(define-key global-map [(control f1)] 'ecb-hide-ecb-windows)
(define-key global-map [(control f2)] 'ecb-show-ecb-windows)
 
(define-key global-map "\C-c1" 'ecb-maximize-window-directories)
(define-key global-map "\C-c2" 'ecb-maximize-window-sources)
(define-key global-map "\C-c3" 'ecb-maximize-window-methods)
(define-key global-map "\C-c4" 'ecb-maximize-window-history)

(define-key global-map "\C-c`" 'ecb-restore-default-window-sizes)

(provide 'jain-ecb-config)