;;; .doom.d/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here
;;
(setq-default tab-width 4
              indent-tabs-mode t)

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
