;; -------------------------- Package setup ---------------------------
(require 'package)


;; Package configs
(setq package-enable-at-startup nil)
(setq package-archives
	     '(("org"   . "http://orgmode.org/elpa/"      )
              ( "gnu"   . "http://elpa.gnu.org/packages/" )
              ( "melpa" . "https://melpa.org/packages/"   )))

;; Set load path
(package-initialize)

;; Bootstrap `use-package`
(when (not (package-installed-p 'use-package))
  (package-refresh-contents)
  (package-install 'use-package))

;; --------------------------- Defaults -------------------------------
;; Make startup faster by reducing the frequency of garbage
;; collection.  The default is 0.8MB.  Measured in bytes.
(setq-default

gc-cons-threshold (* 50 1000 1000)

;; Portion of heap used for allocation.  Defaults to 0.1.
gc-cons-percentage 0.6

;; Do not show startup screen
inhibit-startup-message t

;; Keep customized settings in their own file
custom-file "~/.emacs.d/custom.el"

;; Use name in the frame title
frame-title-format (format "%s's Emacs" (capitalize user-login-name))

;; -------------------------- Uncomment if signature issues -----------
;;(setq package-check-signature nil)
;; --------------------------------------------------------------------


;; Do not create lockfiles.
create-lockfiles nil

;; Don't use hard tabs
indent-tabs-mode nil

;; Emacs can automatically create backup files. This tells Emacs to put all backups in
;; ~/.emacs.d/backups. More info:
;; http://www.gnu.org/software/emacs/manual/html_node/elisp/Backup-Files.html
backup-directory-alist `(("." . ,(concat user-emacs-directory "backups")))

;; Do not autosave
auto-save-default nil

;; Allow commands to be run on minibuffers
enable-recursive-minibuffers t)

;; Change all yes/no questions to y/n type
(fset 'yes-or-no-p 'y-or-n-p)

;; Delete whitespace just when a file is saved
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; Enable narrowing commands
(put 'narrow-to-region 'disabled nil)
(put 'narrow-to-page 'disabled nil)

;; Display column number in mode line
(column-number-mode t)

;; Automatically update buffers if file content on the disk has changed
(global-auto-revert-mode t)

;; ---------------------------- MInimal UI ----------------------------
(progn
  ;; No menu bar
  (menu-bar-mode    -1)

  ;; No tool bar
  (tool-bar-mode    -1)

  ;; No scroll bar
  (scroll-bar-mode  -1)

  ;; Highlight line
  (global-linum-mode 1))

;; Show matching parens
(setq show-paren-delay 0)
(show-paren-mode 1)

;;Install fonts
(use-package all-the-icons)

;; Font and frame size
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 80))

;; Vim mode
(use-package evil
  :ensure t
  :config
  (evil-mode 1))

(use-package evil-escape
  :ensure t
  :init
  (setq-default evil-escape-key-sequence "jk")
  :config
  (evil-escape-mode 1))

;; Git integration for Emacs
(use-package magit
  :ensure t
  :commands 'magit-status
  :diminish)

(use-package git-timemachine
  :ensure t)

;; Helm
(use-package helm
  :ensure t
  :init
  (setq helm-M-x-fuzzy-match t
  helm-mode-fuzzy-match t
  helm-buffers-fuzzy-matching t
  helm-recentf-fuzzy-match t
  helm-locate-fuzzy-match t
  helm-semantic-fuzzy-match t
  helm-imenu-fuzzy-match t
  helm-completion-in-region-fuzzy-match t
  helm-candidate-number-list 80
  helm-split-window-in-side-p t
  helm-move-to-line-cycle-in-source t
  helm-echo-input-in-header-line t
  helm-autoresize-max-height 0
  helm-autoresize-min-height 20)
  :config
  (helm-mode 1))

;; Which Key
(use-package which-key
  :ensure t
  :init
  (setq which-key-separator " ")
  (setq which-key-prefix-prefix "+")
  :config
  (which-key-mode 1))

;; Custom keybinding
(use-package general
  :ensure t
  :config (general-define-key
  :states '(normal visual insert emacs)
  :prefix "SPC"
  :non-normal-prefix "M-SPC"
  "TAB" '(switch-to-prev-buffer :which-key "previous buffer")
  "SPC" '(helm-M-x :which-key "M-x")
  "ff"  '(helm-find-files :which-key "find files")
  ;; Buffers
  "bb"  '(helm-buffers-list :which-key "buffers list")
  ;; Window
  "wl"  '(windmove-right :which-key "move right")
  "wh"  '(windmove-left :which-key "move left")
  "wk"  '(windmove-up :which-key "move up")
  "wj"  '(windmove-down :which-key "move bottom")
  "w/"  '(split-window-right :which-key "split right")
  "w-"  '(split-window-below :which-key "split bottom")
  "wx"  '(delete-window :which-key "delete window")
  ;; Others
  "at"  '(ansi-term :which-key "open terminal")
  "ma"  '(org-agenda :which-key "open agenda")
  "mp"  '(org-pomodoro :which-key "start pomodoro")
  ))

;; Completion
(use-package company
  :ensure t
  :bind (:map
         global-map
         ("TAB" . company-complete-common-or-cycle)
         ;; Use hippie expand as secondary auto complete. It is useful as it is
         ;; 'buffer-content' aware (it uses all buffers for that).
         ("M-/" . hippie-expand)
         :map company-active-map
         ("C-n" . company-select-next-or-abort)
         ("C-p" . company-select-previous-or-abort))
  :config
  (setq company-idle-delay 0.3)
  (global-company-mode t)

;; Configure hippie expand as well.
(setq hippie-expand-try-functions-list
      '(try-expand-dabbrev
      try-expand-dabbrev-all-buffers
      try-expand-dabbrev-from-kill
      try-complete-lisp-symbol-partially
      try-complete-lisp-symbol))

:diminish nil)

;; Theme
(use-package doom-themes
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)

  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package doom-modeline
      :ensure t
      :hook (after-init . doom-modeline-mode))

;; Projectile
(use-package projectile
  :ensure t
  :init
  (setq projectile-require-project-root nil)
  :config
  (projectile-mode 1))

;; --------------------------- ORG! -------------------------------
(load-file "~/.emacs.d/org-setup.el")

;; -------------------------- Startup message ---------------------

;; Make gc pauses faster by decreasing the threshold.
(setq gc-cons-threshold (* 2 1000 1000))

;; Use a hook so the message doesn't get clobbered by other messages.
(add-hook 'emacs-startup-hook
	  (lambda ()
	  (message "Emacs ready in %s"
	  (format "%.2f seconds"
       	  (float-time
	  (time-subtract after-init-time before-init-time))))))

(provide 'init)
;;end of file
