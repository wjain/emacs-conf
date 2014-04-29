;;;;; ------------------------------------------------;;;;;;;;;;;
;;;;; -------------------jde--------------------------;;;;;;;;;;;
;; Set the debug option to enable a backtrace when a
;; problem occurs.
(setq debug-on-error t)
(setq jde-enable-abbrev-mode t)

(setq load-path (append load-path '("~/my-lisps/jdee-2.4.0.1/lisp")))
(setq load-path (append load-path '("~/my-lisps/elib-1.0")))


(setq defer-loading-jde t)

(if defer-loading-jde
    (progn
      (autoload 'jde-mode "jde" "JDE mode." t)
      (setq auto-mode-alist
            (append
             '(("\\.java\\'" . jde-mode))
             auto-mode-alist)))
  (require 'jde)
  (require 'jjar)
  (require 'jmaker)
  (require 'jsee)
  (setq jmaker-end-of-line-format (quote dos))
  (setq jmaker-java-compiler-options "")
  (setq jde-enable-abbrev-mode t))

(provide 'jain-jdee-config)