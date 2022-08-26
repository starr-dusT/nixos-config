;;; devel.el -*- lexical-binding: t; -*-

;; Author: Tyler Starr

;; Commentary

;; deve setup for emacs

;;; Nix-mode for editing NixOS config
(crafted-package-install-package 'nix-mode)
(add-to-list 'auto-mode-alist '("\\.nix\\'" . nix-mode))

;;; Provide the module
(provide 'devel)
