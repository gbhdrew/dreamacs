;; Make all commands available from the 'package' module.
(require 'package)
;; Don't load any packages at startup.
(setq package-enable-at-startup nil)
;; Set package sources:
(setq package-archives '(("org"       . "http://orgmode.org/elpa/")
                         ("gnu"       . "http://elpa.gnu.org/packages/")
                         ("melpa"     . "https://melpa.org/packages/")))
(package-initialize)

;; Bootstrap 'use-package':
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)
 
;; Counsel comes with Ivy and provides some useful commands,
;; such as counsel-M-x and counsel-find-file. 
(use-package counsel :ensure t)

;; Add magit
(use-package magit :ensure t)

;; Add evil mode, and evil-magit.
(use-package evil :ensure t)
(use-package evil-magit :ensure t)

;; Use the 'general' package to assign keybindings.
(use-package general :ensure t
  :config
  (general-define-key 
    :states '(normal visual insert emacs)
    :keymaps 'override
    "C-s" 'swiper             ; Search for a string in the current buffer.
    "M-x" 'counsel-M-x        ; Replace the default M-x with ivy backend.
    :prefix "SPC"
    :non-normal-prefix "C-SPC"
      "'" 'shell-pop
      "b" 'ivy-switch-buffer
      "/" 'counsel-git-grep   ; Find a string in the current git project.
      "TAB" 'my-switch-to-previous-buffer
      "SPC" 'avy-goto-word-or-subword-1
      "ad" 'dired-jump
      "fy" 'my-put-file-name-on-clipboard
      ;; files
      "f"   '(:ignore t :which-key "files")
      "ff" 'counsel-find-file ; Find a file using Ivy.
      "fr" 'counsel-recentf   ; Find recently-edited files.
      ;; projects
      "p"   '(:ignore t :which-key "project")
      "pf" 'counsel-git     
      ;; magit
      "gs" 'magit-status-here
      ;; tide (typescript)
      "hf" 'tide-jump-to-definition
  ))

(use-package which-key :ensure t)

(use-package avy :ensure t
  ;; These commands trigger the loading of the 'avy' package:
  :commands (avy-goto-word-1))

;; add SLIME repl for Lisp
(use-package slime :ensure t)

;; Display dired subtrees with tab key
(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

;; Typescript support with Tide, flycheck syntax checking, and company auto-completion
(use-package tide
  :ensure t
  :after (typescript-mode company flycheck)
  :hook ((typescript-mode . tide-setup)
	 (typescript-mode . tide-hl-identifier-mode)))
(use-package company :ensure t)
(use-package flycheck
  :ensure t
  :init (global-flycheck-mode))

;; library to ensure environment variables inside Emacs
;; look the same as in the user's shell.
(use-package exec-path-from-shell :ensure t)

;; web-mode for html, tsx files
(use-package web-mode :ensure t)

;; Use prettier, for typescript auto-formatting.
(use-package prettier-js :ensure t)

;; Add support for org-mode
(use-package org :ensure t)

;; graphql support
(use-package graphql-mode :ensure t)

;; pop-up shell.
;; Use M-x customize-variable RET `shell-pop-shell-type' RET to
;; customize the shell to use.
(use-package shell-pop :ensure t)

;; auto-completion
(use-package auto-complete :ensure t)

;; JSX support
(use-package rjsx-mode :ensure t)

;; Some helper functions
;; ---------------------

(defun my-switch-to-previous-buffer ()
  "Switch to previously open buffer.
Repeated invocations toggle between the two most recently open buffers."
  (interactive)
  (switch-to-buffer (other-buffer (current-buffer) 1)))

(defun my-put-file-name-on-clipboard ()
  "Put the current file name on the clipboard."
  (interactive)
  (let ((filename (if (equal major-mode 'dired-mode)
                      default-directory
                    (buffer-file-name))))
    (when filename
      (with-temp-buffer
        (insert filename)
        (clipboard-kill-region (point-min) (point-max)))
      (message filename))))
