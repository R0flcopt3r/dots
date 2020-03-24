;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;
(setq-default tab-width 4
              indent-tabs-mode t)

(setq-hook! 'c-mode
  indent-tabs-mode f)

;; (add-hook 'after-init-hook 'global-company-mode)

(+global-word-wrap-mode '(1))

(setq display-line-numbers-type 'relative
				doom-theme 'srcery)

;; (map! :map rust-mode-map
;; 			:n "g d" 'racer-find-definition
;; 			)

;; (add-hook! 'rust-mode (modify-syntax-entry ?_ "w"))

(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-toml-mode))

(use-package! rustic
	:config
	(setq rustic-lsp-server 'rls
				lsp-rust-clippy-preference "on"))


(use-package! company
  :commands (company-mode global-company-mode company-complete
             company-complete-common company-manual-begin company-grab-line)
  :config
	(setq company-idle-delay 0
				company-minimum-prefix-length 3)
	(add-to-list 'company-backends #'company-files)
	(company-tng-configure-default)
	(unbind-key "ESC ESC ESC" company-active-map))

(use-package! mu4e
	:config
	;; mbsync, IMAP ingoing
	(setq mu4e-maildir "~/Mail"
				mu4e-sent-folder   "/NTNUSent"
				mu4e-drafts-folder "/NTNUDrafts"
				mu4e-trash-folder  "/NTNUDeleted\ Items"
				mu4e-refile-folder "/NTNUArchive")

	;; MSMTP, SMTP outgoing
	(setq mu4e-compose-reply-to-address "eiriklav@stud.ntnu.no"
				user-mail-address "eiriklav@stud.ntnu.no"
				user-full-name  "Eirik Osland Lavik"
				mu4e-compose-signature "Med vennleg helsing,\nEirik Osland Lavik"
				message-send-mail-function   'message-send-mail-with-sendmail
				user-mail-address "eiriklav@stud.ntnu.no"
				sendmail-program             "msmtp")

  ;; General
	(setq message-kill-buffer-on-exit t))

(use-package! atomic-chrome
	:config
	(atomic-chrome-start-server)
  (setq atomic-chrome-buffer-open-style 'frame))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

(use-package! projectile
	:config
	(setq projectile-project-search-path '("~/Git")))

(use-package! circe
	:config
	(setq circe-network-options '(("ZNC"
																 :host "irc.rflcptr.me"
																 :port 5003))
				circe-realname "Roflcopter"
				circe-nick "R0flcopt3r"
				circe-default-nick "R0flcopt3r"
				circe-default-realname "Roflcopter"
				tracking-ignored-buffers '((("#gnulag$" circe-highlight-nick-face)
																	("#linuxmasterrace$" circe-highlight-nick-face)))))

(use-package! eshell
	:config
	(setq eshell-cmpl-cycle-completions nil))

(eval-after-load 'circe
  '(progn
     (defadvice circe-command-SAY (after jjf-circe-unignore-target)
       (let ((ignored (tracking-ignored-p (current-buffer) nil)))
         (when ignored
           (setq tracking-ignored-buffers
                 (remove ignored tracking-ignored-buffers))
           (message "This buffer will now be tracked."))))
     (ad-activate 'circe-command-SAY)))
