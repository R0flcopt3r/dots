;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq display-line-numbers-type 'relative)

(setq doom-theme 'srcery)

(add-hook! 'rust-mode (modify-syntax-entry ?_ "w"))

(setq-default indent-tabs-mode t)

(setq-hook!
    (
     'python-mode-hook
     )
  indent-tabs-mode nil
  )


(atomic-chrome-start-server)
