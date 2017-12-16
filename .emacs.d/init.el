;; General settings
(setq inhibit-startup-message 1) ; Inhibit startup message
(setq initial-scratch-message "Scratch Buffer") ; print a default message in t
(tool-bar-mode -1) ; Remove top toolbar
(toggle-scroll-bar -1) ; Remove scrollbar
(global-linum-mode 1) ; global linum mode

;; Package setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives
  '("melpa" . "https://melpa.org/packages/")) ; Get list of packages from melpa
(package-initialize)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

;; Themes
;; (load-theme 'hc-zenburn 1)
(load-theme 'gruvbox 1)

;; Productivity Packages

;; Misc
(use-package which-key :ensure t
  :config
  (which-key-add-key-based-replacements
    "SPC f" "FILES"
    "SPC b" "BUFFERS"
    "SPC w" "WINDOWS")
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
    "SPC" '(counsel-M-x :which-key "Meta-X")
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
    "bfl" '(list-buffers :which-key "Buffer Full List")
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

(use-package counsel :ensure t
  :config
  )

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
 '(package-selected-packages
   (quote
    (evil-magit company magit counsel ivy which-key use-package try smooth-scrolling org-bullets hc-zenburn-theme gruvbox-theme general evil-escape))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
