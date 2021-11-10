;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;; Fixes error in tumbleweed for emacs 27.1
;; (assq-delete-all 'mouse-wheel-down-event load-history)

(setq doom-font (font-spec
                 :family "IBM Plex Mono"
                 :size 14)
      doom-theme 'doom-gruvbox
      display-line-numbers-type 'relative
      +format-on-save-enabled-modes '(c++-mode python-mode c-mode latex-mode rust-mode)
      projectile-enable-caching 't
      display-time-24hr-format 't
      window-divider-default-right-width 6)

(display-time)

(defun my/apply-theme (appearance)
  "Load theme, taking current system APPEARANCE into consideration."
  (mapc #'disable-theme custom-enabled-themes)
  (pcase appearance
    ('light (load-theme 'tango t))
    ('dark (load-theme 'doom-gruvbox t))))

(when IS-MAC
  (add-hook 'ns-system-appearance-change-functions #'my/apply-theme))

(add-hook! 'prog-mode-hook
           #'rainbow-delimiters-mode
           #'evil-quickscope-always-mode)
(after! tex
  (setq +latex-viewers '(pdf-tools zathura))
  (setq-default TeX-master nil)
  (require 'doc-view))

(setq-hook! 'python-mode-hook +format-with-lsp nil)

(after! rainbow-delimiters
  (setq rainbow-delimiters-max-face-count 9))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)


(after! company
  (setq company-idle-delay 0
        company-tooltip-idle-delay 0
        company-minimum-prefix-length 2)
  (setq-default history-length 1000)
  (setq-default prescient-history-length 1000)

  (map! :map company-active-map
   :g "<tab>" 'company-complete-selection
   :g "TAB" 'company-complete-selection
   :g "<return>" 'nil
   :g "RET" 'nil))

;; Amount of memory used before garbage collection
(setq gcmh-high-cons-threshold (* 1024 1024 1024))

(after! projectile
  (setq projectile-project-search-path '("~/Git" "~/Git/School" "~/Git/School/bachelor")))

(after! lsp-mode
  (setq lsp-ui-doc-use-webkit t
        lsp-java-java-path "/opt/jdk-15.0.1/bin/java"
        lsp-clients-clangd-args '("-j=7"
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


(after! poetry
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


;; Make workspace show
(after! persp-mode
  (defun display-workspaces-in-minibuffer ()
    (with-current-buffer " *Minibuf-0*"
      (erase-buffer)
      (insert (+workspace--tabline))))
  (run-with-idle-timer 1 t #'display-workspaces-in-minibuffer)
  (+workspace/display))

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

(defun r0fl/toggle-pyright-type ()
  (interactive)
  (if (string-match-p "basic" lsp-pyright-typechecking-mode)
      (setq lsp-pyright-typechecking-mode "strict")
    (setq lsp-pyright-typechecking-mode "basic"))
  (lsp-restart-workspace)
  (message "typechecking is: " lsp-pyright-typechecking-mode))


(defun r0fl/fix_img ()
  (interactive)
  (while (re-search-forward
          (concat "^image:\\(Pictures.*$\\)\n"
                  "\n"
                  "_*Figur\\(e\\|a\\) \\([0-9]+.?\\)+\\( *- *\\)\\(.*$\\)")
          nil t)
    (replace-match (concat
                    "[#img-ANCHOR_ID]\n"
                    "." (s-trim (or (match-string 5)
                                    "")) "\n"
                    "image::" (match-string 1)))))

(defun r0fl/fix_img_region (beg end)
  (interactive "r")
  (save-excursion
    (narrow-to-region beg end)
    (set-mark nil)
    (goto-char (point-min))
    (r0fl/fix_img)
    (widen)))
