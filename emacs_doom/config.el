;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;
(setq-default tab-width 4
              indent-tabs-mode t)

(setq-hook! 'c-mode
  indent-tabs-mode f)

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

(atomic-chrome-start-server)
