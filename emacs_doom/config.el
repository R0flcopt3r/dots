;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
(setq display-line-numbers-type 'relative)
(load-theme 'srcery t)

(map! :map elpy-mode-map
      :n "g d" 'anaconda-mode-find-definitions
      )
(map! :map evil-normal-state-map
      :n "c" 'evil-substitute
      )


(require 'company)
(setq company-idle-delay 0.2
      company-minimum-prefix-length 3)
