;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here


(setq doom-font
      (font-spec
       :family "JetBrains Mono"
       :size 13))

;; (setq-default tab-width 4
;;               indent-tabs-mode t)

(setq
 +format-on-save-enabled-modes '(python-mode)
 python-shell-completion-native-enable nil
 )

;; (add-hook 'after-init-hook 'global-company-mode)

(+global-word-wrap-mode '(1))

(setq display-line-numbers-type 'visual
      doom-theme 'srcery)

(add-to-list 'auto-mode-alist '("\\.service\\'" . conf-toml-mode))

(after! rustic
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

(after! which-key
  :config
  (setq which-key-idle-delay 0.5))

(after! evil
  (map! :nvi
        "C-h" 'evil-window-left
        "C-l" 'evil-window-right
        "C-k" 'evil-window-up
        "C-j" 'evil-window-down)
  ;; Resizing
  (map! :nvi
        "C-S-h" 'evil-window-decrease-width
        "C-S-l" 'evil-window-increase-width
        "C-S-j" 'evil-window-decrease-height
        "C-S-k" 'evil-window-decrease-height)
  (map! (:map evil-org-mode-map
         :i
         "RET" 'evil-ret))
  (map! (:map ein:notebook-mode-map
         :ni
         "C-RET" 'ein:worksheet-insert-cell-below)))

(after! atomic-chrome
  (atomic-chrome-start-server)
  (setq atomic-chrome-buffer-open-style 'frame))

(autoload 'dired-async-mode "dired-async.el" nil t)
(dired-async-mode 1)

(after! projectile
  (setq projectile-project-search-path '("~/Git")))

(after! eshell
  (setq eshell-cmpl-cycle-completions nil))

(use-package! elcord
  :hook (after-init . elcord-mode))


(setq gdscript-godot-executable "/opt/Godot/godot_current")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(fci-rule-color "#767676")
 '(jdee-db-active-breakpoint-face-colors (cons "#0F1019" "#D85F00"))
 '(jdee-db-requested-breakpoint-face-colors (cons "#0F1019" "#79D836"))
 '(jdee-db-spec-breakpoint-face-colors (cons "#0F1019" "#767676"))
 '(objed-cursor-color "#D83441")
 '(package-selected-packages (quote (exwm)))
 '(pdf-view-midnight-colors (cons "#0D0E16" "#CEDBE5"))
 '(vc-annotate-background "#0D0E16")
 '(vc-annotate-color-map
   (list
    (cons 20 "#79D836")
    (cons 40 "#98cd39")
    (cons 60 "#b8c33d")
    (cons 80 "#D8B941")
    (cons 100 "#d89b2b")
    (cons 120 "#d87d15")
    (cons 140 "#D85F00")
    (cons 160 "#ba5548")
    (cons 180 "#9d4b90")
    (cons 200 "#8041D8")
    (cons 220 "#9d3ca5")
    (cons 240 "#ba3873")
    (cons 260 "#D83441")
    (cons 280 "#bf444e")
    (cons 300 "#a7555b")
    (cons 320 "#8e6568")
    (cons 340 "#767676")
    (cons 360 "#767676")))
 '(vc-annotate-very-old-color nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(highlight-indentation-face ((t (:background "gray15")))))
