;;;;; -------------------------------------------------------;;;;;;;;;;;
;;;;; ------------------- org-mode --------------------------;;;;;;;;;;;
;;;;; -------------------------------------------------------;;;;;;;;;;;

(setq load-path (append load-path '("~/my-lisps/org-7.8.11/lisp/")))
(setq load-path (append load-path '("~/my-lisps/org-7.8.11/contrib/lisp/")))
(require 'org-install)
(require 'org-publish)
(require 'ob-tangle)

(setq load-path (append load-path '("~/my-lisps/epresent/")))
(require 'htmlize)
(require 'epresent)
(require 'org-export-as-s5)
(require 'org-tree-slide)

;; (setq org-hide-leading-stars t)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cc" 'org-capture)

;; publish
(setq org-publish-project-alist
      '(("note-org"
         :base-directory "~/Documents/notes/src"
         :publishing-directory "~/Documents/notes/publish"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index t
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers t
         :style "<link rel=\"stylesheet\" href=\"./wheer.css\" type=\"text/css\"/>")
        ("note-static"
         :base-directory "~/Documents/notes/org/src"
         :publishing-directory "~/Documents/notes/publish"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "jain_y@126.com"
         )))

(setq org-export-htmlize-output-type 'inline-css)

;; org-capture-templates
(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "E:/Company/TODO/gtd.org" "Tasks")
         "* TODO %?\n  %i" :prepend t)

        ("j" "Journal" entry (file+datetree "~/Documents/notes/src/notes/journal.org" "Journal")
         "* %?\nEntered on %U\n %i\n %a" :prepend t :empty-lines 1)

        ("w" "WorkNote" entry (file+headline "~/Documents/notes/src/notes/worknotes.org" "WorkNotes")
         "* %U %?\n\n  %i" :prepend t :empty-lines 1)

        ("l" "LifeNote" entry (file+headline "~/Documents/notes/src/notes/liftnotes.org" "LiftNotes")
         "* %U %?\n\n  %i" :prepend t :empty-lines 1)

        ("s" "StudyNot" entry (file+headline "~/Documents/notes/src/notes/studynotes.org" "StudyNotes")
         "* %U %?\n\n  %i" :prepend t :empty-lines 1)))

(put 'dired-find-alternate-file 'disabled nil)

(setq file-coding-system-alist
      (append (list
               '("\\.tex" . iso-8859-1)
               ) file-coding-system-alist))


(setq org-ditaa-jar-path "~/.emacs.d/plugins/ditaa/ditaa0_9.jar")
                                        ;(setq org-plantuml-jar-path "~/java/plantuml.jar")

(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)

;; active Babel languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (dot . t)
   (ditaa . t)
   (R . t)
   (python . t)
   (C . t)
   (perl . t)
   (ruby . t)
   (gnuplot . t)
   (clojure . t)
   (sh . t)
   (ledger . t)
   (org . t)
   (plantuml . t)
   (latex . t)
   (sql . t)
   (java . t)
   ))

;; GTD
(setq org-agenda-files (list "~/Documents/TODO/gtd.org"))
(setq org-todo-keywords
      '((sequence "TODO(t!)" "|" "DONE(d@/!)" "ABORT(a@/!)")
        )) 

;; org-mode < 8.0
(setq org-latex-to-pdf-process '("xelatex -interaction nonstopmode %f"
                                 "xelatex -interaction nonstopmode %f"))

(setf org-export-latex-default-packages-alist
      (remove '("AUTO" "inputenc" t) org-export-latex-default-packages-alist))

;; Auctex
(setq TeX-auto-save t)
(setq TeX-parse-self t)
(setq-default TeX-master nil)
(defun org-mode-article-modes ()
  (reftex-mode t)
  (and (buffer-file-name)
       (file-exists-p (buffer-file-name))
       (reftex-parse-all)))
(add-hook 'org-mode-hook
          (lambda ()
            (if (member "REFTEX" org-todo-keywords-1)
                (org-mode-article-modes))))
(unless (boundp 'org-export-latex-classes)
  (setq org-export-latex-classes nil))

(add-to-list 'org-export-latex-classes
             '("cn-article"
               "\\documentclass[10pt,a4paper]{article}
                \\usepackage{graphicx}
                \\usepackage{xcolor}
                \\usepackage{xeCJK}
                \\usepackage{lmodern}
                \\usepackage{verbatim}
                \\usepackage{fixltx2e}
                \\usepackage{longtable}
                \\usepackage{float}
                \\usepackage{tikz}
                \\usepackage{wrapfig}
                \\usepackage{soul}
                \\usepackage{textcomp}
                \\usepackage{listings}
                \\usepackage{geometry}
                \\usepackage{algorithm}
                \\usepackage{algorithmic}
                \\usepackage{marvosym}
                \\usepackage{wasysym}
                \\usepackage{latexsym}
                \\usepackage{natbib}
                \\usepackage{fancyhdr}
                \\usepackage[xetex,colorlinks=true,CJKbookmarks=true,
                linkcolor=blue,
                urlcolor=blue,
                menucolor=blue]{hyperref}
                \\usepackage{fontspec,xunicode,xltxtra}
                \\setmainfont[BoldFont=Adobe Heiti Std]{Adobe Song Std}  
                \\setsansfont[BoldFont=Adobe Heiti Std]{AR PL UKai CN}  
                \\setmonofont{Bitstream Vera Sans Mono}  
                \\newcommand\\fontnamemono{AR PL UKai CN}%等宽字体
                \\newfontinstance\\MONO{\\fontnamemono}
                \\newcommand{\\mono}[1]{{\\MONO #1}}
                \\setCJKmainfont[Scale=0.9]{Adobe Heiti Std}%中文字体
                \\setCJKmonofont[Scale=0.9]{Adobe Heiti Std}
                \\hypersetup{unicode=true}
                \\geometry{a4paper, textwidth=6.5in, textheight=10in,
                marginparsep=7pt, marginparwidth=.6in}
                \\definecolor{foreground}{RGB}{220,220,204}%浅灰
                \\definecolor{background}{RGB}{62,62,62}%浅黑
                \\definecolor{preprocess}{RGB}{250,187,249}%浅紫
                \\definecolor{var}{RGB}{239,224,174}%浅肉色
                \\definecolor{string}{RGB}{154,150,230}%浅紫色
                \\definecolor{type}{RGB}{225,225,116}%浅黄
                \\definecolor{function}{RGB}{140,206,211}%浅天蓝
                \\definecolor{keyword}{RGB}{239,224,174}%浅肉色
                \\definecolor{comment}{RGB}{180,98,4}%深褐色
                \\definecolor{doc}{RGB}{175,215,175}%浅铅绿
                \\definecolor{comdil}{RGB}{111,128,111}%深灰
                \\definecolor{constant}{RGB}{220,162,170}%粉红
                \\definecolor{buildin}{RGB}{127,159,127}%深铅绿
                \\punctstyle{kaiming}
                \\title{}
                \\fancyfoot[C]{\\bfseries\\thepage}
                \\chead{\\MakeUppercase\\sectionmark}
                \\pagestyle{fancy}
                \\tolerance=1000
                [NO-DEFAULT-PACKAGES]
                [NO-PACKAGES]"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\subsection{%s}" . "\\subsection*{%s}")
               ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
               ("\\paragraph{%s}" . "\\paragraph*{%s}")
               ("\\subparagraph{%s}" . "\\subparagraph*{%s}")))

;; 使用Listings宏包格式化源代码(只是把代码框用listing环境框起来，还需要额外的设置)
(setq org-export-latex-listings t)
;; Options for \lset command（reference to listing Manual)
(setq org-export-latex-listings-options
      '(
        ("basicstyle" "\\color{foreground}\\small\\mono")           ; 源代码字体样式
        ("keywordstyle" "\\color{function}\\bfseries\\small\\mono") ; 关键词字体样式
        ("identifierstyle" "\\color{doc}\\small\\mono")
        ("commentstyle" "\\color{comment}\\small\\itshape")         ; 批注样式
        ("stringstyle" "\\color{string}\\small")                    ; 字符串样式
        ("showstringspaces" "false")                                ; 字符串空格显示
        ("numbers" "left")                                          ; 行号显示
        ("numberstyle" "\\color{preprocess}")                       ; 行号样式
        ("stepnumber" "1")                                          ; 行号递增
        ("backgroundcolor" "\\color{background}")                   ; 代码框背景色
        ("tabsize" "4")                                             ; TAB等效空格数
        ("captionpos" "t")                                          ; 标题位置 top or buttom(t|b)
        ("breaklines" "true")                                       ; 自动断行
        ("breakatwhitespace" "true")                                ; 只在空格分行
        ("showspaces" "false")                                      ; 显示空格
        ("columns" "flexible")                                      ; 列样式
        ("frame" "single")                                          ; 代码框：阴影盒
        ("frameround" "tttt")                                       ; 代码框： 圆角
        ("framesep" "0pt")
        ("framerule" "8pt")
        ("rulecolor" "\\color{background}")
        ("fillcolor" "\\color{white}")
        ("rulesepcolor" "\\color{comdil}")
        ("framexleftmargin" "10mm")
        ))

;; Make Org use ido-completing-read for most of its completing prompts.
(setq org-completion-use-ido t)
;; 各种Babel语言支持
(org-babel-do-load-languages
 'org-babel-load-languages
 '((R . t)
   (emacs-lisp . t)
   (matlab . t)
   (C . t)
   (perl . t)
   (sh . t)
   (ditaa . t)
   (python . t)
   (haskell . t)
   (dot . t)
   (latex . t)
   (js . t)
   ))

;; 导出Beamer的设置
;; allow for export=>beamer by placing #+LaTeX_CLASS: beamer in org files
;;-----------------------------------------------------------------------------
(add-to-list 'org-export-latex-classes
             ;; beamer class, for presentations
             '("beamer"
               "\\documentclass[11pt,professionalfonts]{beamer}
                \\mode
                \\usetheme{{{{Warsaw}}}}
                %\\usecolortheme{{{{beamercolortheme}}}}
                
                \\beamertemplateballitem
                \\setbeameroption{show notes}
                \\usepackage{graphicx}
                \\usepackage{tikz}
                \\usepackage{xcolor}
                \\usepackage{xeCJK}
                \\usepackage{amsmath}
                \\usepackage{lmodern}
                \\usepackage{fontspec,xunicode,xltxtra}
                \\usepackage{polyglossia}
                \\setmainfont{Times New Roman}
                \\setCJKmainfont{DejaVu Sans YuanTi}
                \\setCJKmonofont{DejaVu Sans YuanTi Mono}
                \\usepackage{verbatim}
                \\usepackage{listings}
                \\institute{{{{beamerinstitute}}}}
                \\subject{{{{beamersubject}}}}"
               ("\\section{%s}" . "\\section*{%s}")
               ("\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}"
                "\\begin{frame}[fragile]\\frametitle{%s}"
                "\\end{frame}")))

(setq ps-paper-type 'a4
      ps-font-size 16.0
      ps-print-header nil
      ps-landscape-mode nil)

(provide 'jain-org-mode-config)
