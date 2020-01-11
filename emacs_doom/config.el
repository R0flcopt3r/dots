;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here

(setq display-line-numbers-type 'relative)

(setq doom-theme 'srcery)

(add-hook! 'rust-mode (modify-syntax-entry ?_ "w"))
(setq-hook!
    (
     'rust-mode-hook
     'c-mode-hook
     'c++-mode-hook
     'sh-mode-hook
     'go-mode-hook
     )
  indent-tabs-mode t
  )

(setq-hook!
    (
     'python-mode-hook
     )
  indent-tabs-mode nil
  )


(atomic-chrome-start-server)
