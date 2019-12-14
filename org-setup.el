;; ---------------------- Org! -------------------------------------
(use-package org
  :defer t
  :commands (org-mode org-capture)
  :diminish 'org-indent-mode
  :config
  (evil-define-key 'normal org-mode-map
	(kbd "M-h") 'org-up-element
	(kbd "M-j") 'org-forward-element
	(kbd "M-k") 'org-backward-element
	(kbd "M-l") 'org-down-element
        (kbd "M-p") 'org-pomodoro
        (kbd "M-a") 'org-agenda
	(kbd "M-H") 'org-promote-subtree
	(kbd "M-J") 'org-move-subtree-down
	(kbd "M-K") 'org-move-subtree-up
	(kbd "M-L") 'org-demote-subtree
	(kbd "C-M-H") 'org-do-promote
	(kbd "C-M-L") 'org-do-demote
	(kbd "M-o") 'org-insert-heading-after-current
	(kbd "M-O") 'org-insert-heading))

 (setq org-startup-indented 1)
 (setq org-blank-before-new-entry (quote ((heading) (plain-list-item))))
 (setq org-export-with-section-numbers nil)
 (setq org-export-with-toc nil)
 (add-hook 'org-export-before-parsing-hook (lambda (x) (untabify (point-min) (point-max))))
 (add-hook 'org-mode-hook 'turn-on-flyspell)
 (setq org-log-done (quote time))
 (setq org-checkbox-hierarchical-statistics nil)

(use-package evil-org
  :ensure t
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (evil-org-set-key-theme '(textobject insert navigation shift todo)))

(use-package org-ref
  :commands (org-ref-helm-insert-label-link org-ref-helm-insert-ref-link org-ref-helm-insert-cite-link)
  :after (org))

;; org-bullets
;;
;; Show bullets in org-mode as UTF-8 characters
;;
;; Source: https://github.com/emacsorphanage/org-bullets

(use-package org-bullets
  :disabled t
  :diminish
  :after org)

;; org-pomodoro
;;
;; Pomodoro implementation for org-mode.
;;
;; Source: https://github.com/lolownia/org-pomodoro

(use-package org-pomodoro
  :commands 'org-pomodoro
  :diminish
  :after org)

(provide 'org-setup)
;; end of file