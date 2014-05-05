(setq load-path (append load-path '("~/my-lisps/csharp/CsharpToolsForEmacs.2011may13/")))

;; Basic code required for C# mode
(require 'csharp-mode)
(defun my-csharp-mode-fn ()
  "function that runs when csharp-mode is initialized for a buffer."
  (turn-on-auto-revert-mode)
  (setq indent-tabs-mode nil)
  (require 'flymake)
  (flymake-mode 1)
  (require 'yasnippet)
  (yas/minor-mode-on)
  (require 'rfringe)
)

;; Custom code to use a default compiler string for all C# files
(defvar my-csharp-default-compiler nil)
(setq my-csharp-default-compiler "c:/Windows/Microsoft.NET/Framework64/v4.0.30319/csc.exe @@FILE@@")

(defun my-csharp-get-value-from-comments (marker-string line-limit)
  my-csharp-default-compiler)

(add-hook 'csharp-mode-hook (lambda ()
                              (if my-csharp-default-compiler
                                  (progn
                                    (fset 'orig-csharp-get-value-from-comments
                                          (symbol-function 'csharp-get-value-from-comments))
                                    (fset 'csharp-get-value-from-comments
                                          (symbol-function 'my-csharp-get-value-from-comments))))
                              (flymake-mode)))


(add-hook  'csharp-mode-hook 'my-csharp-mode-fn t)

(provide 'jain-csharp-config)

