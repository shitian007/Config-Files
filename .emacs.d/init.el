;; General settings
(setq inhibit-startup-message 1) ; Inhibit startup message
(setq initial-scratch-message "Scratch Buffer") ; print a default message in t
(tool-bar-mode -1) ; Remove top toolbar
(toggle-scroll-bar -1) ; Remove scrollbar
(global-linum-mode 1) ; global linum mode
(show-paren-mode 1) ; Matching braces

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
(use-package smart-mode-line :ensure t
  :config
  (sml/setup)
  (setq sml/theme 'respectful)
  )
(use-package rainbow-delimiters :ensure t
  :config (rainbow-delimiters-mode 1))
;; (load-theme 'hc-zenburn 1)
(load-theme 'gruvbox 1)

;; Misc
(use-package which-key :ensure t
  :config
  (which-key-add-key-based-replacements
    "SPC c" "COMMENT"
    "SPC i" "INDENT"
    "SPC f" "FILES"
    "SPC b" "BUFFERS"
    "SPC w" "WINDOWS"
    "SPC p" "PROJECTILE"
    "SPC g" "GIT")
  (which-key-mode 1))

(use-package smooth-scrolling :ensure t
  :config
    (smooth-scrolling-mode 1))

;; Evil
(use-package evil :ensure t
  :init
  (setq evil-want-C-u-scroll t) ; Override C-u to scroll up
  :config
  (setcdr evil-insert-state-map nil) ; Emacs controls in insert mode 
  (evil-mode 1))

(use-package evil-escape :ensure t
  :config
  (setq-default evil-escape-delay 0.5)
  (setq evil-escape-excluded-major-modes '(dired-mode))
  (setq-default evil-escape-key-sequence "fd")
  (evil-escape-mode 1))

;; General kbd
(use-package general :ensure t
  :config
  (general-define-key
   :states '(normal visual insert emacs)
   :prefix "SPC"
   :non-normal-prefix "C-SPC"

    ;; basic
    "SPC" '(counsel-M-x :which-key "Counsel Command")
    "s" '(swiper :which-key "Swiper search")

    ;; Files
    "ff" '(counsel-find-file :which-key "Find file")
    "fe" '(eval-buffer :which-key "Evaluate file")
    "fs" '(save-buffer :which-key "Save current")
    "fS" '(save-some-buffers :which-key "Save all")

    ;; Indentation and Commenting
    "cl" '(comment-line :which-key "comment line")
    "cr" '(comment-or-uncomment-region :which "(un)comment region")
    "ir" '(indent-region :which-key "indent-region")

    ;; Buffers
    "TAB" '(switch-to-next-buffer :which-key "Next Buffer")
    "bfl" '(ibuffer :which-key "Buffer Full List")
    "bl" '(ivy-switch-buffer :which-key "List Buffers")
    "bd" '(kill-this-buffer :which-key "Kill Buffer")

    ;; Windows
    "wh" '(split-window-horizontally :which-key "Split horizontal")
    "wv" '(split-window-vertically :which-key "Split vertical")
    "wd" '(delete-window :which-key "Delete Window")
    "k"  '(windmove-up :which-key "Switch Up")
    "j"  '(windmove-down :which-key "Switch Down")
    "h"  '(windmove-left :which-key "Switch Left")
    "l"  '(windmove-right :which-key "Switch Right")

    ;; Projectile
    "pb" '(projectile-ibuffer :which-key "Project buffers")
    "pp" '(counsel-projectile-switch-project :which-key "Switch project")
    "pf" '(counsel-projectile-find-file :which-key "Project file")
    "pd" '(counsel-projectile-find-dir :which-key "Project dir")
    "ps" '(counsel-projectile-ag :which-key "Project ag")

    ;; Git
    "gs" '(magit :which-key "magit")

    ))

;; abo-abo awesomeness
(use-package ivy :ensure t
  :config
  (setq ivy-use-virtual-buffers t ; recent files and bookmarks
	ivy-count-format "%d/%d " ; current/total in collection of prompt
	)
  (ivy-mode 1))

(use-package counsel :ensure t)

(use-package ivy-rich :ensure t
  :config
  (ivy-set-display-transformer 'ivy-switch-buffer 'ivy-rich-switch-buffer-transformer)
  (setq ivy-virtual-abbreviate 'full ivy-rich-switch-buffer-align-virtual-buffer t))

;; Projectile
(use-package projectile :ensure t)
(use-package counsel-projectile :ensure t)

;; Autocompletion
(use-package company :ensure t
  :init (global-company-mode 1)
  :config
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous))

;; Git
(use-package magit :ensure t)

(use-package evil-magit :ensure t)

;; Auto-generated

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("c74e83f8aa4c78a121b52146eadb792c9facc5b1f02c917e3dbb454fca931223" "3c83b3676d796422704082049fc38b6966bcad960f896669dfc21a7a37a748fa" default)))
 '(package-selected-packages
   (quote
    (rainbow-delimiters counsel-projectile smart-mode-line evil-magit company magit counsel ivy which-key use-package try smooth-scrolling org-bullets hc-zenburn-theme gruvbox-theme general evil-escape)))
 '(projectile-mode t nil (projectile))
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
