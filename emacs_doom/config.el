;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;; Fixes error in tumbleweed for emacs 27.1
;; (assq-delete-all 'mouse-wheel-down-event load-history)

(setq doom-font
      (font-spec
       :family "IBM Plex Mono"
       :size 13)
      doom-theme 'srcery
      display-line-numbers-type 'relative
      +format-on-save-enabled-modes '(c++-mode c-mode python-mode latex-mode))



(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)


(after! company
  (setq company-idle-delay 0
        company-tooltip-idle-delay 0
        company-minimum-prefix-length 1))

;; Amount of memory used before garbage collection
(setq gc-cons-threshold 100000000)

(after! projectile
  (setq projectile-project-search-path '("~/Git")))

(after! lsp-mode
  (setq lsp-ui-doc-use-webkit t
        lsp-java-java-path "/opt/jdk-15.0.1/bin/java"
        lsp-clients-clangd-args '("--header-insertion=never" "--suggest-missing-includes")))

(after! evil
  (require 'evil-textobj-anyblock)
  (evil-define-text-object my-evil-textobj-anyblock-inner-quote
    (count &optional beg end type)
    "Select the closest outer quote."
    (let ((evil-textobj-anyblock-blocks
           '(("'" . "'")
             ("\"" . "\"")
             ("`" . "`")
             ("“" . "”"))))
      (evil-textobj-anyblock--make-textobj beg end type count nil)))

  (evil-define-text-object my-evil-textobj-anyblock-a-quote
    (count &optional beg end type)
    "Select the closest outer quote."
    (let ((evil-textobj-anyblock-blocks
           '(("'" . "'")
             ("\"" . "\"")
             ("`" . "`")
             ("“" . "”"))))
      (evil-textobj-anyblock--make-textobj beg end type count t)))
  (map! :n "j" #'evil-next-visual-line
        :n "k" #'evil-previous-visual-line))

(define-key evil-inner-text-objects-map "q" 'my-evil-textobj-anyblock-inner-quote)
(define-key evil-outer-text-objects-map "q" 'my-evil-textobj-anyblock-a-quote)

(use-package! elcord
  :hook (after-init . elcord-mode))


(load! "~/.doom.d/mail.el")

(after! poetry
 (map! :map python-mode-map
      :leader
      :desc "poetry run" "pc"
      #'poetry-run)
 (map! :map python-mode-map
       :localleader
       :desc "poetry" "p"
       #'poetry))

(after! magit
  (add-hook! 'magit-mode-hook #'magit-delta-mode))

;; Found on random website
;; (after! (python flycheck)
;;     (add-hook 'flycheck-mode-hook #'flycheck-pycheckers-setup)
;;     (setq flycheck-pycheckers-checkers '(mypy pyflakes)))

(after! dap-mode
 (require 'dap-python)
 (setq dap-python-executable "python3"
       dap-python-debugger 'debugpy)
 (map! :map dap-mode-map
       :leader
       :prefix ("d" . "dap")
       ;; basics
       :desc "dap next"          "n" #'dap-next
       :desc "dap step in"       "i" #'dap-step-in
       :desc "dap step out"      "o" #'dap-step-out
       :desc "dap continue"      "c" #'dap-continue
       :desc "dap hydra"         "h" #'dap-hydra
       :desc "dap debug restart" "r" #'dap-debug-restart
       :desc "dap debug"         "s" #'dap-debug

       ;; debug
       :prefix ("dd" . "Debug")
       :desc "dap debug recent"  "r" #'dap-debug-recent
       :desc "dap debug last"    "l" #'dap-debug-last

       ;; eval
       :prefix ("de" . "Eval")
       :desc "eval"                "e" #'dap-eval
       :desc "eval region"         "r" #'dap-eval-region
       :desc "eval thing at point" "s" #'dap-eval-thing-at-point
       :desc "add expression"      "a" #'dap-ui-expressions-add

       ;; breakpoints
       :prefix ("db" . "Breakpoint")
       :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
       :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
       :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
       :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message))


;;;;;;; ORG MODE ;;;;;;;;;
(after! org
  (setq org-ellipsis " ▾"

  org-agenda-start-with-log-mode t
  org-log-done 'time
  org-log-into-drawer t

  org-agenda-files
        '("~/org/Tasks.org"
          "~/org/Habits.org"
          "~/org/Birthdays.org")
  org-todo-keywords
    '((sequence "TODO(t)" "NEXT(n)" "STRT(s)" "|" "DONE(d!)")
      (sequence "BACKLOG(b)" "PLAN(p)" "READY(r)" "ACTIVE(a)" "REVIEW(v)" "WAIT(w@/!)" "HOLD(h)" "|" "COMPLETED(c)" "CANC(k@)"))

 org-refile-targets
    '(("Archive.org" :maxlevel . 1)
      ("Tasks.org" :maxlevel . 1)))

  ;; Save Org buffers after refiling!
  (advice-add 'org-refile :after 'org-save-all-org-buffers)

  (setq org-tag-alist
    '((:startgroup)
       ; Put mutually exclusive tags here
       (:endgroup)
       ("@errand" . ?E)
       ("@home" . ?H)
       ("@work" . ?W)
       ("agenda" . ?a)
       ("planning" . ?p)
       ("publish" . ?P)
       ("batch" . ?b)
       ("note" . ?n)
       ("idea" . ?i)))

  ;; Configure custom agenda views
  (setq org-agenda-custom-commands
   '(("d" "Dashboard"
     ((agenda "" ((org-deadline-warning-days 7)))
      (todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))
      (tags-todo "agenda/ACTIVE" ((org-agenda-overriding-header "Active Projects")))))

    ("n" "Next Tasks"
     ((todo "NEXT"
        ((org-agenda-overriding-header "Next Tasks")))))

    ("W" "Work Tasks" tags-todo "+work-email")

    ;; Low-effort next actions
    ("e" tags-todo "+TODO=\"NEXT\"+Effort<15&+Effort>0"
     ((org-agenda-overriding-header "Low Effort Tasks")
      (org-agenda-max-todos 20)
      (org-agenda-files org-agenda-files)))

    ("w" "Workflow Status"
     ((todo "WAIT"
            ((org-agenda-overriding-header "Waiting on External")
             (org-agenda-files org-agenda-files)))
      (todo "REVIEW"
            ((org-agenda-overriding-header "In Review")
             (org-agenda-files org-agenda-files)))
      (todo "PLAN"
            ((org-agenda-overriding-header "In Planning")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "BACKLOG"
            ((org-agenda-overriding-header "Project Backlog")
             (org-agenda-todo-list-sublevels nil)
             (org-agenda-files org-agenda-files)))
      (todo "READY"
            ((org-agenda-overriding-header "Ready for Work")
             (org-agenda-files org-agenda-files)))
      (todo "ACTIVE"
            ((org-agenda-overriding-header "Active Projects")
             (org-agenda-files org-agenda-files)))
      (todo "COMPLETED"
            ((org-agenda-overriding-header "Completed Projects")
             (org-agenda-files org-agenda-files)))
      (todo "CANC"
            ((org-agenda-overriding-header "Cancelled Projects")
             (org-agenda-files org-agenda-files)))))))

  (setq org-capture-templates
    `(("t" "Tasks / Projects")
      ("tt" "Task" entry (file+olp "~/org/Tasks.org" "Inbox")
           "* TODO %?\n  %U\n  %a\n  %i" :empty-lines 1)

      ("j" "Journal Entries")
      ("jj" "Journal" entry
           (file+olp+datetree "~/org/Journal.org")
           "\n* %<%I:%M %p> - Journal :journal:\n\n%?\n\n"
           ;; ,(dw/read-file-as-string "~/Notes/Templates/Daily.org")
           :clock-in :clock-resume
           :empty-lines 1)
      ("jm" "Meeting" entry
           (file+olp+datetree "~/org/Journal.org")
           "* %<%I:%M %p> - %a :meetings:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1)
      ("jt" "Systememne" entry
           (file+olp+datetree "~/org/TOL_log.org")
           "* %<%I:%M %p> - %a :TOL:\n\n%?\n\n"
           :clock-in :clock-resume
           :empty-lines 1))))



