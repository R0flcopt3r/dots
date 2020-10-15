;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


;; Fixes error in tumbleweed for emacs 27.1
;; (assq-delete-all 'mouse-wheel-down-event load-history)

(setq doom-font
      (font-spec
       :family "JetBrains Mono"
       :size 13)
      doom-theme 'srcery
      display-line-numbers-type 'relative
      +format-on-save-enabled-modes '(c++-mode c-mode))



(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)


(after! company
  (setq company-idle-delay 0
        company-tooltip-idle-delay 0
        company-minimum-prefix-length 1
        company-auto-complete nil))

(after! projectile
  (setq projectile-project-search-path '("~/Git")))

(setq-hook! (c-mode
             c++-mode)
  tab-width 2)

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

(set-email-account! "NTNU"
                    '((mu4e-sent-folder   . "/NTNUSent Items")
                      (mu4e-drafts-folder . "/NTNUDrafts")
                      (mu4e-trash-folder  . "/NTNUTrash")
                      (smtpmail-smtp-user . "eiriklav@ntnu.no")
                      (user-mail-address  . "eiriklav@stud.ntnu.no"))
                    t)

(setq mu4e-compose-reply-to-address "eiriklav@stud.ntnu.no"
      user-mail-address "eiriklav@stud.ntnu.no"
      user-full-name  "Eirik Osland Lavik"
      mu4e-compose-signature "---\nEirik Osland Lavik"
      message-send-mail-function   'message-send-mail-with-sendmail
      user-mail-address "eiriklav@stud.ntnu.no"
      sendmail-program             "msmtp")

