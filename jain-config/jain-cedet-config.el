;;;;; http://emacser.com/cedet.htm

;;;;; ------------------------------------------------;;;;;;;;;;;
;;;;; --------------------- Cedet --------------------;;;;;;;;;;;

(when (>= emacs-major-version 24)
    (load-file "~/my-lisps/cedet-1.1/common/cedet.el"))
(if (= emacs-major-version 23)
          (load-file "~/my-lisps/cedet-1.0/common/cedet.el"))


(require 'cedet)

(setq load-path (append load-path '("~/my-lisps/cedet-1.0/eieio")))
(setq load-path (append load-path '("~/my-lisps/cedet-1.0/semantic")))
(setq load-path (append load-path '("~/my-lisps/cedet-1.0/speedbar")))
(setq load-path (append load-path '("~/my-lisps/cedet-1.0/ede")))
(require 'ede)
(global-ede-mode t)

;; (defun my-c-mode-cedet-hook ()
;;   (local-set-key "." 'semantic-complete-self-insert)
;;   (local-set-key ">" 'semantic-complete-self-insert))
;; (add-hook 'c-mode-common-hook 'my-c-mode-cedet-hook)

;; * This enables the database and idle reparse engines
;; (semantic-load-enable-minimum-features)
;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)
;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)
(semantic-load-enable-semantic-debugging-helpers)
;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
(semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)
;; (semantic-idle-completions-mode t)

(require 'semantic-ia)
(require 'semantic-gcc)
(add-hook 'c-mode-common-hook 'semantic-gcc-setup)

;;;; TAGS Menu
(defun my-semantic-hook ()
  (imenu-add-to-menubar "TAGS"))
(add-hook 'semantic-init-hooks 'my-semantic-hook)
(global-set-key [(f4)] 'speedbar)

(defconst user-include-dirs
  (list ".." "../include" "../inc" "../common" "../public"
        "../.." "../../include" "../../inc" "../../common" "../../public"
        "../../../interinc"))

(defconst win32-include-dirs
  (list "E:/MinGw/include"
        ;; "E:/MinGw/lib/gcc/mingw32/4.5.0/include"
        ;; "E:/MinGw/lib/gcc/mingw32/4.5.0/include/c++"
        ;; "E:/msys_link/gtk+2.0/include/"
        ;; "E:/msys_link/gtk+2.0/include/gtk-2.0"
        ;; "E:/msys_link/gtk+2.0/include/gdk-2.0"
        ;; "E:/Program Files (x86)/Microsoft Visual Studio/VC98/Include"
        ;; "E:/Program Files (x86)/Microsoft Visual Studio/VC98/MFC/Include"
        ;; "E:/Program Files (x86)/Microsoft Visual Studio .NET 2003/Vc7/include"
        ))
(require 'semantic-c nil 'noerror)
(let ((include-dirs user-include-dirs))
  ;; (when (eq system-type 'windows-nt)
  ;;   (setq include-dirs (append include-dirs win32-include-dirs)))
  (mapc (lambda (dir)
          (semantic-add-system-include dir 'c++-mode)
          (semantic-add-system-include dir 'c-mode))
        include-dirs))

(setq semanticdb-project-roots 
      (list 
       (expand-file-name "./")
       (expand-file-name "../")
       (expand-file-name "../include")
       (expand-file-name "../inc")
       (expand-file-name "../common")
       (expand-file-name "../public")
       (expand-file-name "../..")
       (expand-file-name "../../include")
       (expand-file-name "../../inc")
       (expand-file-name "../../common")
       (expand-file-name "../../public")
       (expand-file-name "../../../interinc")
;;       (expand-file-name "F:/iSM_ALL/source/interinc")
       ))

;; (global-set-key [(meta n)] 'senator-completion-menu-popup)
(global-set-key [(meta n)] 'semantic-ia-complete-symbol-menu)
(global-set-key [M-f1] 'semantic-ia-show-summary)
;; (define-key c-mode-base-map (kbd "M-n") 'semantic-ia-complete-symbol-menu)

(defadvice push-mark (around semantic-mru-bookmark activate)
  "Push a mark at LOCATION with NOMSG and ACTIVATE passed to `push-mark'.
If `semantic-mru-bookmark-mode' is active, also push a tag onto
the mru bookmark stack."
  (semantic-mrub-push semantic-mru-bookmark-ring
                      (point)
                      'mark)
  ad-do-it)

(defun semantic-ia-fast-jump-back ()
  (interactive)
  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
      (error "Semantic Bookmark ring is currently empty"))
  (let* ((ring (oref semantic-mru-bookmark-ring ring))
         (alist (semantic-mrub-ring-to-assoc-list ring))
         (first (cdr (car alist))))
    (if (semantic-equivalent-tag-p (oref first tag) (semantic-current-tag))
        (setq first (cdr (car (cdr alist)))))
    (semantic-mrub-switch-tags first)))

;;;;; -------------------- F12 ------------------------------;;;;;;;;;;;
;;;;; -------------http://emacser.com/cedet.htm--------;;;;;;;;;;;
(global-set-key [f12] 'semantic-ia-fast-jump)
(global-set-key [S-f12]
                (lambda ()
                  (interactive)
                  (if (ring-empty-p (oref semantic-mru-bookmark-ring ring))
                      (error "Semantic Bookmark ring is currently empty"))
                  (let* ((ring (oref semantic-mru-bookmark-ring ring))
                         (alist (semantic-mrub-ring-to-assoc-list ring))
                         (first (cdr (car alist))))
                    (if (semantic-equivalent-tag-p (oref first tag)
                                                   (semantic-current-tag))
                        (setq first (cdr (car (cdr alist)))))
                    (semantic-mrub-switch-tags first))))

;;;;; ------------------------------------------------;;;;;;;;;;;
;;;;; -------------------- EDE ------------------------;;;;;;;;;;;
;; C++ Root project
;;(setq libutil-project
;;      (ede-cpp-root-project "libutil"
;;                            :file "~/projects/libutil/configure.in"
;;                            :system-include-path '("/home/meteor1113/projects/include"
;;                                                   "/home/meteor1113/projects/common"
;;                                                   "/home/meteor1113/projects/libutil/pub")))


;;;;; --------------------  F2 ------------------------------;;;;;;;;;;;
;; F2 current
;; C-F2 next
;; S-F2 previous
;; C-S-F2  clear all
(enable-visual-studio-bookmarks)


;;h/cpp switch
(require 'eassist nil 'noerror)
(global-set-key [M-f12] 'eassist-switch-h-cpp)
(setq eassist-header-switches
      '(("h" . ("cpp" "cxx" "c++" "CC" "cc" "C" "c" "mm" "m"))
        ("hh" . ("cc" "CC" "cpp" "cxx" "c++" "C"))
        ("hpp" . ("cpp" "cxx" "c++" "cc" "CC" "C"))
        ("hxx" . ("cxx" "cpp" "c++" "cc" "CC" "C"))
        ("h++" . ("c++" "cpp" "cxx" "cc" "CC" "C"))
        ("H" . ("C" "CC" "cc" "cpp" "cxx" "c++" "mm" "m"))
        ("HH" . ("CC" "cc" "C" "cpp" "cxx" "c++"))
        ("cpp" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("cxx" . ("hxx" "hpp" "h++" "HH" "hh" "H" "h"))
        ("c++" . ("h++" "hpp" "hxx" "HH" "hh" "H" "h"))
        ("CC" . ("HH" "hh" "hpp" "hxx" "h++" "H" "h"))
        ("cc" . ("hh" "HH" "hpp" "hxx" "h++" "H" "h"))
        ("C" . ("hpp" "hxx" "h++" "HH" "hh" "H" "h"))
        ("c" . ("h"))
        ("m" . ("h"))
        ("mm" . ("h"))))

(require 'semantic-tag-folding nil 'noerror)
(global-semantic-tag-folding-mode 1)

(global-set-key (kbd "C-?") 'global-semantic-tag-folding-mode)
(define-key semantic-tag-folding-mode-map (kbd "C-c -") 'semantic-tag-folding-fold-block)
(define-key semantic-tag-folding-mode-map (kbd "C-c +") 'semantic-tag-folding-show-block)
;; (define-key semantic-tag-folding-mode-map (kbd "C-_") 'semantic-tag-folding-fold-all)
;; (define-key semantic-tag-folding-mode-map (kbd "C-+") 'semantic-tag-folding-show-all)

(provide 'jain-cedet-config)

