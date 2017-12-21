;;;; package --- Emacs configuration file
;;; Commentary:
;;; Code:

(tool-bar-mode -1) ; Remove top toolbar
(toggle-scroll-bar -1) ; Remove scrollbar
(desktop-save-mode 1) ; Save session
(add-hook 'prog-mode-hook 'linum-mode) ; Line numbers for programming modes
(show-paren-mode) ; Match parenthesis under cursor
(global-hl-line-mode) ; Soft highlighting on current line

;; Removes *messages* from the buffer.
(setq message-log-max nil)
(kill-buffer "*Messages*")

(setq show-trailing-whitespace t) ; Highlight trailing whitespace
(setq save-interprogram-paste-before-kill t) ; Save clipboard content to kill-ring

;; Package setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/")) ; Get list of packages from melpa
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Appearance

;; (load-theme 'hc-zenburn 1)
;; (load-theme 'spacemacs-dark 1)
(load-theme 'gruvbox 1)
;; (load-theme 'wombat 1)

(use-package smart-mode-line :ensure t
  :init
  (setq sml/no-confirm-load-theme t) ; Do not show confirmation message
  (sml/setup)
  :config
  (setq sml/theme 'dark)
  (add-to-list 'mode-line-front-space '("" (:eval (format "%s " (line-number-at-pos (point-max)))))) ; Show total number of lines
  )

;; Misc
(use-package which-key :ensure t
  :init (which-key-mode)
  :config
  (which-key-add-key-based-replacements
    "SPC c" "COMMENT"
    "SPC i" "INDENT"
    "SPC r" "REGISTERS"
    "SPC s" "SEARCH"
    "SPC t" "TOGGLES"
    "SPC w" "WINDOWS"
    "SPC p" "PROJECTILE"
    "SPC g" "GIT"))

(use-package smooth-scrolling :ensure t
  :init (smooth-scrolling-mode))

(use-package exec-path-from-shell :ensure t
  :config (exec-path-from-shell-initialize))

(use-package smartparens :ensure t
  :init (smartparens-global-mode))

;; Evil
(use-package evil :ensure t
  :init
  (setq evil-want-C-u-scroll t) ; Override C-u to scroll up
  (evil-mode)
  :config
  (setq evil-insert-state-map nil) ; Emacs controls in insert mode
  (setq evil-emacs-state-modes (delq 'ibuffer-mode evil-emacs-state-modes))) ; Evil in Ibuffer mode

(use-package evil-escape :ensure t
  :init (evil-escape-mode)
  :config
  (setq-default evil-escape-delay 0.5)
  (setq evil-escape-excluded-major-modes '(dired-mode))
  (setq-default evil-escape-key-sequence "fd"))

;; General kbd
(use-package general :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

   ;; Misc.
   "SPC" '(counsel-M-x :which-key "Counsel Command")
   "rr" '(counsel-yank-pop :which-key "Kill ring")
   "re" '(counsel-evil-registers :which-key "Evil Registers")
   "U" '(undo-tree-visualize :which-key "Undo Tree")

   ;; Toggles
   "tt" '(toggle-truncate-lines :which-key "Toggle truncate lines")

   ;; Search
   "ss" '(swiper :which-key "Swiper search")
   "sd" '(dumb-jump-go :which-key "Search jump definition")
   "sb" '(dumb-jump-back :which-key "Search jump back")

   ;; Files
   "ff" '(counsel-find-file :which-key "Find file")
   "fe" '(eval-buffer :which-key "Evaluate file")
   "fr" '(revert-buffer :which-key "Reload buffer")
   "fs" '(save-buffer :which-key "Save current")
   "fS" '(save-some-buffers :which-key "Save all")
   "ft" '(treemacs-toggle :which-key "Treemacs")

   ;; Indentation and Commenting
   "cl" '(comment-line :which-key "comment line")
   "cr" '(comment-or-uncomment-region :which "(un)comment region")
   "ir" '(indent-region :which-key "indent-region")

   ;; Buffers
   "bn" '(switch-to-next-buffer :which-key "Next Buffer")
   "bp" '(switch-to-prev-buffer :which-key "Prev Buffer")
   "bd" '(kill-this-buffer :which-key "Kill this buffer")
   "bfl" '(ibuffer :which-key "Buffer Full List")
   "bl" '(ivy-switch-buffer :which-key "List Buffers")

   ;; Windows
   "wh" '(split-window-horizontally :which-key "Split horizontal")
   "wv" '(split-window-vertically :which-key "Split vertical")
   "wd" '(delete-window :which-key "Delete Window")
   "wo" '(delete-other-windows :which-key "Delete Other Windows")
   "h"  '(windmove-left :which-key "Switch Left")
   "j"  '(windmove-down :which-key "Switch Down")
   "k"  '(windmove-up :which-key "Switch Up")
   "l"  '(windmove-right :which-key "Switch Right")
   "wH"  '(evil-window-move-far-left :which-key "Move Window Left")
   "wJ"  '(evil-window-move-very-bottom :which-key "Move Window Down")
   "wK"  '(evil-window-move-very-top :which-key "Move Window Up")
   "wL"  '(evil-window-move-far-right :which-key "Move Window Right")

   ;; Projectile
   "pb" '(projectile-ibuffer :which-key "Project buffers")
   "pp" '(counsel-projectile-switch-project :which-key "Switch project")
   "pf" '(counsel-projectile-find-file :which-key "Project file")
   "pd" '(counsel-projectile-find-dir :which-key "Project dir")
   "ps" '(counsel-projectile-ag :which-key "Project ag")

   ;; Git
   "gs" '(magit :which-key "magit")
   "gb" '(magit-blame :which-key "Git blame")

   ))

;; abo-abo awesomeness
(use-package ivy :ensure t
  :init (ivy-mode)
  :config
  (setq ivy-use-virtual-buffers t ; recent files and bookmarks
	ivy-count-format "%d/%d " ; current/total in collection of prompt
	))
(use-package ivy-rich :ensure t ; enriched descriptions within ivy buffers
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
  (setq ivy-virtual-abbreviate 'full ivy-rich-switch-buffer-align-virtual-buffer t))
(use-package counsel :ensure t)

(use-package swiper :ensure t
  :config
  (define-key ivy-minibuffer-map (kbd "C-r") 'swiper-query-replace) ; remap replace
  )

;; File Navigation
(use-package projectile :ensure t)
(use-package counsel-projectile :ensure t)

(use-package treemacs :ensure t
  :config
  (setq treemacs-never-persist t))
(use-package treemacs-evil :ensure t)

;; Autocompletion and Syntax checking
(use-package company :ensure t
  :init (global-company-mode)
  :config
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

(use-package flycheck :ensure t
  :init (add-hook 'prog-mode-hook 'flycheck-mode))

;; Snippets and Dumb Jump
(use-package yasnippet :ensure t
  :config (yas-global-mode))
(use-package yasnippet-snippets :ensure t)

(use-package dumb-jump :ensure t)

;; Git
(use-package magit :ensure t)
(use-package evil-magit :ensure t)
(use-package diff-hl :ensure t
  :init (global-diff-hl-mode))

;; Org and PDF
(use-package org-bullets :ensure t
  :init (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(use-package pdf-tools :ensure t)

;; Language specific packages and configurations

;; Python
(use-package jedi :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))
(use-package company-jedi :ensure t
  :init (add-to-list 'company-backends 'company-jedi))
;; Python: Use ipython repl instead of python
(setq python-shell-interpreter "ipython")
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")

;; Javascript
(use-package js2-mode :ensure t
  :config (add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode)))
(use-package web-mode :ensure t
  :config
  (add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))

(use-package tern :ensure t
  :config
  (add-hook 'js2-mode-hook 'tern-mode)
  (add-hook 'web-mode-hook 'tern-mode))
(use-package company-tern :ensure t
  :init (add-to-list 'company-backends 'company-tern))

;; Definition
(use-package indium :ensure t
  :commands (indium-interaction-mode indium-eval-buffer)
  :bind (
	 :map indium-interaction-mode-map
	      ("C-c e" . indium-eval-buffer))
  )

(setq js-indent-level 2)

;; Custom variables

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c63a789fa2c6597da31f73d62b8e7fad52c9420784e6ec34701ae8e8f00071f6" "b67cb8784f6a2d1a3f605e39d2c376937f3bf8460cb8a0d6fc625c0331c00c83" default)))
 '(package-selected-packages
   (quote
    (indium js-comint company-jedi company-tern js2-mode web-mode yasnippet-snippets which-key use-package try treemacs-evil spacemacs-theme smooth-scrolling smartparens smart-mode-line-powerline-theme pdf-tools org-bullets jedi ivy-rich gruvbox-theme git-gutter-fringe git-gutter-fringe+ general flycheck exec-path-from-shell evil-magit evil-escape dumb-jump diff-hl counsel-projectile company))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:inherit nil :stipple nil :background "#292b2e" :foreground "#b2b2b2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 130 :width normal :foundry "nil" :family "Monaco")))))

;;; init.el ends here
