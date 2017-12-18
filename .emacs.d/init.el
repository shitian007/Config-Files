;;;; package --- Emacs configuration file
;;; Commentary:
;;; Code:

(tool-bar-mode -1) ; Remove top toolbar
(toggle-scroll-bar -1) ; Remove scrollbar
(desktop-save-mode 1) ; Save session
(add-hook 'prog-mode-hook 'linum-mode) ; Line numbers for programming modes
(show-paren-mode) ; Match parenthesis under cursor

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
  (setq sml/no-confirm-load-theme t)
  (setq sml/theme 'dark)
  (sml/setup))

;; Misc
(use-package which-key :ensure t
  :init (which-key-mode)
  :config
  (which-key-add-key-based-replacements
    "SPC c" "COMMENT"
    "SPC i" "INDENT"
    "SPC r" "REGISTERS"
    "SPC f" "FILES"
    "SPC b" "BUFFERS"
    "SPC w" "WINDOWS"
    "SPC p" "PROJECTILE"
    "SPC g" "GIT"))

(use-package smooth-scrolling :ensure t
  :init (smooth-scrolling-mode))

(use-package exec-path-from-shell :ensure t
  :config (exec-path-from-shell-initialize))

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

   ;; basic
   "SPC" '(counsel-M-x :which-key "Counsel Command")
   "ss" '(swiper :which-key "Swiper search")
   "rr" '(counsel-yank-pop :which-key "Kill ring")
   "re" '(counsel-evil-registers :which-key "Evil Registers")
   "U" '(undo-tree-visualize :which-key "Undo Tree")

   ;; Files
   "ff" '(counsel-find-file :which-key "Find file")
   "fe" '(eval-buffer :which-key "Evaluate file")
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

(use-package counsel :ensure t)

(use-package ivy-rich :ensure t
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
  (setq ivy-virtual-abbreviate 'full ivy-rich-switch-buffer-align-virtual-buffer t))

(use-package swiper :ensure t
  :config
  (define-key ivy-minibuffer-map (kbd "C-r") 'swiper-query-replace) ; remap replace
  )

;; Navigation
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

(use-package jedi :ensure t
  :init
  (add-hook 'python-mode-hook 'jedi:setup)
  (add-hook 'python-mode-hook 'jedi:ac-setup))

(use-package flycheck :ensure t
  :init (global-flycheck-mode))

(use-package yasnippet :ensure t
  :config (yas-global-mode))
(use-package yasnippet-snippets :ensure t)

;; Git
(use-package magit :ensure t)
(use-package evil-magit :ensure t)

;; Custom language specific settings

;; Python: Use ipython repl instead of python
(setq python-shell-interpreter "ipython")
(setenv "IPY_TEST_SIMPLE_PROMPT" "1")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("8e4efc4bed89c4e67167fdabff77102abeb0b1c203953de1e6ab4d2e3a02939a" "858a353233c58b69dbe3a06087fc08905df2d8755a0921ad4c407865f17ab52f" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "a27c00821ccfd5a78b01e4f35dc056706dd9ede09a8b90c6955ae6a390eb1c1e" "c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (smartparens exec-path-from-shell jedi flycheck counsel-projectile smart-mode-line evil-magit company magit counsel ivy which-key use-package smooth-scrolling org-bullets hc-zenburn-theme gruvbox-theme spacemacs-theme general evil-escape)))
 '(projectile-mode t nil (projectile))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
