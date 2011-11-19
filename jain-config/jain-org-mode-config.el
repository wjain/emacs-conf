;;;;; ------------------------------------------------;;;;;;;;;;;
;;;;; ------------------- org-mode --------------------------;;;;;;;;;;;
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

(setq org-publish-project-alist
      '(("note-org"
         :base-directory "~/emacs/org/org"
         :publishing-directory "~/emacs/org/publish"
         :base-extension "org"
         :recursive t
         :publishing-function org-publish-org-to-html
         :auto-index nil
         :index-filename "index.org"
         :index-title "index"
         :link-home "index.html"
         :section-numbers nil
         :style "<link rel=\"stylesheet\"
    href=\"./wheer.css\"
    type=\"text/css\"/>")
        ("note-static"
         :base-directory "~/emacs/org/org"
         :publishing-directory "~/emacs/org/publish"
         :recursive t
         :base-extension "css\\|js\\|png\\|jpg\\|gif\\|pdf\\|mp3\\|swf\\|zip\\|gz\\|txt\\|el"
         :publishing-function org-publish-attachment)
        ("note" 
         :components ("note-org" "note-static")
         :author "jain_y@126.com"
         )))

(setq org-tag-alist '((:startgroup . nil)
                      ("@document" . ?d)
                      ("@code" . ?c)
                      ("@test" . ?t)
                      (:endgroup . nil)))

(put 'dired-find-alternate-file 'disabled nil)

(provide 'jain-org-mode-config)