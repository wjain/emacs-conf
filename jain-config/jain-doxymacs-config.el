;;--------------------------doxymacs--------------------------
;##doxymacs;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(add-to-list 'load-path "~/my-lisps/doxymacs-1.8.0/no-autoconf")
(require 'doxymacs) ;;    doxymacs
;;            E   lC++ I?
(defun my-doxymacs-font-lock-hook ()
  (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
      (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(doxymacs-mode);doxymacs-mode  true
(add-hook 'c-mode-common-hook 'doxymacs-mode) ;;    doxymacs-mode
(add-hook 'c++-mode-common-hook 'doxymacs-mode) ;;    doxymacs-mode

;;---C-c d i
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(defconst doxymacs-C++-file-comment-template
 '(
   "////////////////////////////////////////////////////////////////////////////" > n
   "/// " > n
   "/// " (doxymacs-doxygen-command-char) "file   "
   (if (buffer-file-name)
       (file-name-nondirectory (buffer-file-name))
     "") > n
   "/// " > n
   "/// " (doxymacs-doxygen-command-char) "author " (user-full-name)   > n
   "/// " > n
   "/// " (doxymacs-doxygen-command-char) "date   " (current-time-string) > n
   "/// " > n
   "/// " (doxymacs-doxygen-command-char) "brief  " > n
   "/// " > n
   "/// " "    "> n
   "/// " "    "> n
   "/// " > n
   "/// " (doxymacs-doxygen-command-char) "version"> n
   "/// " > n
   "/// " > n
   "/// " "        Copyright (c) 2010, Xi'an NPU CoThink Software Co. Ltd."> n
   "/// " > n
   "////////////////////////////////////////////////////////////////////////////"> n)
 "Default C++-style template for file documentation.")
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(provide 'jain-doxymacs-config)