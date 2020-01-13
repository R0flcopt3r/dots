;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq display-line-numbers-type 'relative)
(setq-default tab-width 4)
(setq-default indent-tabs-mode t)

(setq
      display-line-numbers-type 'relative
      doom-theme 'srcery
      company-idle-delay -.2
      company-minimum-prefix-length 10
			projectile-project-search-path '("~/Git")
			org-agenda-files (apply 'append
												(mapcar
												(lambda (directory)
											(directory-files-recursively
												directory org-agenda-file-regexp))
												'("~/org")))
      )


(map! :map rust-mode-map
			:n "g d" 'racer-find-definition
			)

(add-hook! 'rust-mode (modify-syntax-entry ?_ "w"))


;; Use space as indent for certain languages
(setq-hook!
    (
     'python-mode-hook
     )
  indent-tabs-mode nil
  )

;; Makes `s` and `S` work like in Vi
(after! evil-snipe
  (evil-snipe-mode -1))

;;(add-to-list 'load-path "~/.emacs.d/emacs-application-framework")
;;(require 'eaf)

(atomic-chrome-start-server)
