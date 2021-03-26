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
      +format-on-save-enabled-modes '(c++-mode python-mode c-mode latex-mode)
      projectile-enable-caching (not (executable-find doom-projectile-fd-binary)))

(setq lsp-clients-clangd-args '("-j=3"
                                "--background-index"
                                "--clang-tidy"
                                "--completion-style=detailed"
                                "--suggest-missing-includes"
                                "--header-insertion=never"))

(add-hook! 'prog-mode-hook
           #'rainbow-delimiters-mode
           #'evil-quickscope-always-mode)

(setq-hook! 'python-mode-hook +format-with-lsp nil)

(after! rainbow-delimiters
  (setq rainbow-delimiters-max-face-count 9))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)


(after! company
  (setq company-idle-delay 0
        company-tooltip-idle-delay 0
        company-minimum-prefix-length 1)
  (setq-default history-length 1000)
  (setq-default prescient-history-length 1000))

;; Amount of memory used before garbage collection
(setq gcmh-high-cons-threshold (* 1024 1024 1024))

(after! projectile
  (setq projectile-project-search-path '("~/Git" "~/Git/School" "~/Git/School/bachelor")))

(after! lsp-mode
  (setq lsp-ui-doc-use-webkit t
        lsp-java-java-path "/opt/jdk-15.0.1/bin/java"
        lsp-clients-clangd-args '("-j=3"
                                  "--background-index"
                                  "--clang-tidy"
                                  "--completion-style=detailed"
                                  "--suggest-missing-includes"
                                  "--header-insertion=never")
        lsp-file-watch-threshold 100000))
(after! lsp-clangd (set-lsp-priority! 'clangd 2))

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
  (setq dap-python-executable "python3"
        dap-python-debugger 'debugpy
        dap-auto-configure-features '(breakpoints expressions controls tooltip repl locals)
        dap-ui-buffer-configurations '(("*dap-ui-locals*" (side . right) (slot . 1) (window-width . 0.3))
                                       ("*dap-ui-expressions*" (side . right) (slot . 2) (window-width . 0.3))
                                       ("*dap-ui-sessions*" (side . right) (slot . 3) (window-width . 0.3))
                                       ("*dap-ui-breakpoints*" (side . left) (slot . 2) (window-width . 35))
                                       ("*debug-window*" (side . bottom) (slot . 3) (window-width . 0.2))
                                       ("*dap-ui-repl*" (side . bottom) (slot . 1) (window-height . 0.45))))
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
        :desc "remove expression"   "d" #'dap-ui-expressions-remove

        :prefix ("db" . "Breakpoint")
        :desc "dap breakpoint toggle"      "b" #'dap-breakpoint-toggle
        :desc "dap breakpoint condition"   "c" #'dap-breakpoint-condition
        :desc "dap breakpoint hit count"   "h" #'dap-breakpoint-hit-condition
        :desc "dap breakpoint log message" "l" #'dap-breakpoint-log-message))




(after! circe

  (load! "~/.doom.d/irc.el")

  (set-irc-server! "znc"
                   `(:port 5003
                     :nick "R0flcopt3r"
                     :host "irc.rflcptr.me"
                     :pass (lambda (&rest _) (+pass-get-secret "irc/zncSnoo"))))

  (set-irc-server! "Freenode"
                   '(:tls t
                     :host "irc.freenode.net"
                     :nick "R0flcopt3r"
                     :nickserv-password (lambda (&rest _) (+pass-get-secret "irc/freenode"))
                     :channels ("#emacs-circe")))

  (setq circe-format-server-rejoin nil
        circe-new-day-notifier-format-message nil
        circe-format-server-quit nil
        circe-notifications-notify-function #'irc/highlight-buffer
        circe-notifications-check-window-focus nil
        circe-notifications-wait-for 0)

  (add-hook! circe-server-connected-hook 'enable-circe-notifications)

  (defun circe-command-SHRUG (&rest form)
    (circe-command-SAY (shrug)))

  (defun crice-command-LENNY (&rest form)
    (circe-command-SAY (lenny)))

  (map! :map circe-chat-mode-map
        :localleader
        :prefix ("s" . "shitposting")
        :desc "SAY shrug" "s" #'shrug
        :desc "SAY lenny" "l" #'lenny))

(defun r0fl/python-args-to-docstring (&optional arguments)
  "return docstring format for the python arguments in yas-text or in ARGUMENTS"
  (let* ((indent  "\n" )
         (args (if arguments
                   (python-split-args arguments)
                 (python-split-args yas-text)))
         (formatted-args (mapconcat
                          (lambda (x)
                            (let ((arg (nth 0 x)))
                              (concat arg (if (string-match-p ":" arg) "\n" " :\n")))) args indent)))
    (unless (string= formatted-args "")
      (mapconcat 'identity (list "Parameter\n---------" formatted-args) indent))))

(defun r0fl/python-return-to-docstring (&optional type)
  "Return docstring format for the python return type in yas-text or in TYPE"
  (let ((type-intern (or type yas-text)))
    (when (not (equal "None" type-intern))
      (concat "Return\n------\n" type-intern " :\n"))))

(defun r0fl/py-args-to-doc (beg end)
  "Convert python arguments between BEG and END to docstring."
  (interactive "r")
  (let ((args (buffer-substring beg end)))
    (setq mark-active nil)
    (end-of-line)
    (yas-expand-snippet
     (concat "\n\"\"\"\n"
             (r0fl/python-args-to-docstring args)
             "\n\"\"\""))))

(defun r0fl/py-def-to-doc (beg end)
  (interactive "r")
  (let ((def (buffer-substring beg end)))
    (setq mark-active nil)
    (end-of-line)
    (yas-expand-snippet (concat
                         "\n\"\"\""
                         (replace-regexp-in-string "_" " " def)
                         ".\"\"\"\n"))))

(defvar r0fl/linx-url "linx.rflcptr.me/upload")

(defun r0fl/linx (beg end)
  "Upload buffer or region to linx and puts the url in your kill-ring."
  (interactive "r")
      (request r0fl/linx-url
        :type "PUT"
        :sync t
        :data (if (region-active-p)
                  (buffer-substring beg end)
                (buffer-string))
        :success (cl-function
                  (lambda (&key data &allow-other-keys)
                    (kill-new (string-trim data))))))
