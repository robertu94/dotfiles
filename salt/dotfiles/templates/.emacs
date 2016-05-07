;; Configure package management
(require 'package)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

;; Create Package Repos if they do not exist
(or (file-exists-p package-user-dir)
	(package-refresh-contents)
	)

;; Install Use-package if it is not installed which will be used to bootstrap the rest
(if (package-installed-p 'use-package)
	nil
  (package-install 'use-package)
  )

;; Display Settings

(setq inhibit-splash-screen t
	  inhibit-startup-message t
	  inhibit-startup-echo-area-message t
	  )
(menu-bar-mode -1)
(tool-bar-mode -1)
(when (boundp 'scroll-bar-mode)
  (scroll-bar-mode -1))
(show-paren-mode 1)

;; Language Settings
(setq linum-format "%4d \u2502")
(global-linum-mode t)
(setq default-tab-width 4)
(setq tab-width 4)

;; C
(setq c-default-style "linux"
	  c-basic-offset 4
	  )

;; TeX
(setq TeX-newline-function 'newline-and-indent
	  LaTeX-indent-level 4
	  LaTex-item-indent 0)



;; Packages Configuration
(require 'use-package)
(use-package evil 
  :ensure t
  :config
  (evil-mode 1)

  (use-package evil-magit
	:ensure t
	)
  )

(use-package magit ;;Git Interaction
  :ensure t
  :config
  (global-set-key (kbd "C-x g") 'magit-status)
  )

(use-package helm
  :ensure t
  :diminish helm-mode
  :config
  (helm-mode 1)
  (setq helm-buffers-fuzzy-matching t)
  (define-key helm-find-files-map (kbd "C-k") 'helm-find-files-up-one-level)
  )

(use-package solarized-theme
  :ensure t
  :config
  (load-theme 'solarized-dark t)
  )
(use-package markdown-mode
  :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))
  )

(use-package org
  :ensure t
  )
