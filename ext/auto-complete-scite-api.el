;;; auto-complete-scite-api.el --- auto-completion source with scite API files

;;
;; Author: Ralph Young <bamanzi@gmail.com>
;; Keyword: complete, scite
;;

;;; Commentary:
;; Features:
;; - A candidates source (scite-api) for auto-complete, baked with
;;   Scite's API files.
;;
;;   Candidates provided by this source would have a symbol 'A' at tail
;;  in the menu.
;;
;; - Document string (if provided in API file) would show in
;;   auto-complete's popup area. After selection (RET), the document
;;   string would be displayed in the echo area.
;;
;;   As a side-effect, you can always press M-F1 to query the document
;;   string for a function/symbol.
;;
;; Requirements:
;; * Auto-Complete package needed
;; 	http://cx4a.org/software/auto-complete/
;;   	(only tested on v1.2, v1.3)
;; * Scite API files
;;   	This library would search API files in folder /usr/share/scite/api/
;;	and ~/.scite/api. You can customize variable `ac-scite-api-directories'.
;;
;; 	If you need more API files, please visit
;;   	http://code.google.com/p/scite-files/wiki/Customization
;;
;;   The following rules are used to search the API file.
;;   1. <major-mode-name>.api  ("-mode" removed.)
;;	e.g:  init.el -> emacs-lisp-mode -> emacs-lisp.api
;;   2. <file-name-extension>.api
;;	e.g:  init.el -> el.api
;;   If both matches found, both would be loaded.
;;
;; Usage:
;; - to enable ac-source-scite-api for all modes
;;    (require 'auto-complete-scite-api")
;;    (setq-default 'ac-sources
;;		(cons 'ac-source-scite-api ac-sources))
;;
;; - to enable ac-source-scite-api for specific modes
;;    (require 'auto-complete-scite-api")
;;    (add-hook 'xahk-mode 'ac-enable-scite-api-source)
;; 
;; Note: remember to turn on auto-complete-mode
;;
;; 
;; Limitations:
;; - Performance is not very well. You'd better delete some
;;   rarely-used APIs if file is bigger than 500k

;;; Code:

(require 'auto-complete)

(defcustom ac-scite-api-directories '("/usr/share/scite/api" "~/.scite/api")
  "Directories of Scite API files."
  :type '(repeat string)
  :group 'auto-complete)


(defvar ac-scite-api-caches (make-hash-table :test 'equal)
  "cache to store scite-apis (for current buffer). func-name -> full-line")

(defun ac-read-scite-api-files()
  "read lines from scite api files.

This would read <major-mode-name>.api ('-mode' removed) and/or <file-name-ext>.api.

ac-read-file-dictionary (from auto-complete.el) used to cache the file concents"
  (apply 'append
           (mapcar 'ac-read-file-dictionary
                 (mapcar (lambda (name)
                           (loop for dir in ac-scite-api-directories
                                 for file = (concat dir "/" name ".api")
                                 if (file-exists-p file)
                                 return file))
                         (list (replace-regexp-in-string "-mode" "" (symbol-name major-mode))
			       (ignore-errors (file-name-extension (buffer-file-name))))))))


(defvar ac-scite-api-major-caches (make-hash-table :test 'equal)
  "caches of candidates for each major mode. major-mode-name -> apis-hash-table")

(defun ac-scite-api-read-apis()
  "get API hash "
  (let ((result (make-hash-table :test 'equal)))
    (progn
	(clrhash result)
	(mapc '(lambda(line)
		 (let ((func-name (replace-regexp-in-string "[ ,\(].*" "" line)))
		   (puthash func-name line result) ))
	      (ac-read-scite-api-files))
	result)))
	  

(defvar ac-scite-api-last-major-mode "")
(defun ac-scite-api-init()
  "parse api lines into hashtable \{ac-scite-api-caches}

called on each completion"
  (let ((cache (gethash (symbol-name major-mode) ac-scite-api-major-caches 'none)))
    (progn
      ;; read file and update major hash table
      (if (or (not cache) (eq cache 'none))
	  (let ((apis (ac-scite-api-read-apis)))		
	    (puthash (symbol-name major-mode) apis ac-scite-api-major-caches)
	    (setq cache apis)))

      ;; copy from major-hash-table to candidates
      (if (not (eq ac-scite-api-last-major-mode (symbol-name major-mode)))
	  (progn
	    (setq ac-scite-api-caches cache)
	    (setq ac-scite-api-candidates nil)
	    (if (and cache (not (eq cache 'none)))		
	      (maphash '(lambda(key value)
		      (if (> (length key) 0)
			  (add-to-list 'ac-scite-api-candidates key)))
		   cache))
               (setq ac-scite-api-last-major-mode (symbol-name major-mode))))))) 
     
     
(defvar ac-scite-api-candidates '())

;; (defun ac-scite-api-candidates()
;;   "get all keys from ac-scite-api-caches"
;;   (let ((candidates '()))
;;       (maphash '(lambda(key value)
;; 	    	(add-to-list 'candidates key))
;; 	     ac-scite-api-caches)
;;       candidates))

(defun ac-scite-api-document(symbol)
  (let ((word (if (symbolp symbol)
		  (symbol-name symbol)
		symbol)))
	(gethash word ac-scite-api-caches)))

(defface ac-scite-api-candidate-face
  '((t (:background "gray20" :foreground "ghost white")))
  "Face for yasnippet candidate."
  :group 'auto-complete)

(defface ac-scite-api-selection-face
  '((t (:background "gray20" :foreground "#ffa0a0")))
  "Face for the yasnippet selected candidate."
  :group 'auto-complete)


(ac-define-source scite-api
  '((init . ac-scite-api-init)
    (candidates . ac-scite-api-candidates)
    (document . ac-scite-api-document)
    (cache . t)
    (action . (lambda() (message (ac-scite-api-document (thing-at-point 'symbol)))))    
    (symbol . "A")
;;    (candidate-face . ac-scite-api-candidate-face)
;;    (selection-face . ac-scite-api-selection-face)  
    ))

(defun ac-enable-scite-api-source ()
  (interactive)
  (add-to-list 'ac-sources 'ac-source-scite-api) )



;;;FIXME: you may want to comment the following code

;; show last API's document in echo area
(global-set-key (kbd "<M-f1>")
		'(lambda()
		   (interactive)
		   (message (ac-scite-api-document (thing-at-point 'symbol)))))

(setq-default ac-sources
  (cons 'ac-source-scite-api ac-sources))


;;TEST
;;(add-hook 'php-mode-hook 'ac-enable-scite-api-source)

