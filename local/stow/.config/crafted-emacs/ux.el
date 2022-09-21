;;; ux.el -*- lexical-binding: t; -*-

;; Author: Tyler Starr

;; Commentary

;; Custom configuration of emacs ux elements

;;; File Management

(crafted-package-install-package 'dirvish)
(dirvish-override-dired-mode)

(crafted-package-install-package 'treemacs)

;;; Window Management

(crafted-package-install-package '(burly :host github
                                         :repo "alphapapa/burly.el"
                                         :branch "master"))
(tab-bar-mode)
(burly-tabs-mode)


(crafted-package-install-package 'projectile)
(projectile-mode +1)
(define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)

(Crafted-package-install-package 'perspective)
(global-set-key (kbd "C-x C-b") 'persp-list-buffers)
(customize-set-variable 'persp-mode-prefix-key (kbd "C-c M-p"))
(persp-mode)

;;; Keybinds

(crafted-package-install-package 'which-key)
(which-key-mode)

;;; Provide the module
(provide 'ux)
