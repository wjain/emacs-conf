(add-to-list 'load-path "~/my-lisps/muse-3.20/lisp")

(require 'muse-mode)     ; load authoring mode

(require 'muse-html)     ; load publishing styles I use
(require 'muse-latex)
(require 'muse-texinfo)
(require 'muse-docbook)

(require 'muse-project)  ; publish files in projects

(provide 'jain-muse-config)