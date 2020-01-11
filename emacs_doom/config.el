;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq display-line-numbers-type 'relative)
(setq-default tab-width 4)

(setq doom-theme 'srcery)

(add-hook! 'rust-mode (modify-syntax-entry ?_ "w"))

(setq-default indent-tabs-mode t)

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
