;; -------------------------- Package setup ---------------------------
(require 'package)

(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/"))

(package-initialize)

(when (not package-archive-contents)
    (package-refresh-contents))

(unless (package-installed-p 'use-package)
  (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)

(add-to-list 'load-path "~/.emacs.d/setup")

(require 'setup-general)
(require 'setup-helm)
(require 'setup-helm-gtags)
;;(require 'setup-ggtags)
(require 'setup-cedet)
(require 'setup-editing)
(require 'setup-org)

;; -------------------------- Uncomment if signature issues -----------
;;(setq package-check-signature nil)
;; --------------------------------------------------------------------

;; Chess
(use-package chess
  :ensure t
  :config
  (customize-set-variable 'chess-default-display '(chess-ics1 chess-plain)))

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
