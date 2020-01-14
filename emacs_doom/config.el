;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq-default tab-width 4
							indent-tabs-mode t)

(+global-word-wrap-mode '(1))

(setq
	display-line-numbers-type 'relative
	doom-theme 'srcery
	company-idle-delay -.2
	company-minimum-prefix-length 10
	projectile-project-search-path '("~/Git")
			)

(map! :map rust-mode-map
			:n "g d" 'racer-find-definition
			)

(add-hook! 'rust-mode (modify-syntax-entry ?_ "w"))
(add-hook! 'latex-mode-hook (magic-latex-buffer '(1)))




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
