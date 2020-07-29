;; Initially based on this guide:
;; https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/

(setq config-dir "~/.emacs.d")
(setq subconfigs-dir (concat config-dir "/subconfigs"))
(setq config-path (concat config-dir "/init.el"))
(defun load-subconfig (name) 
  (load-file (concat subconfigs-dir "/" name)))

;; Some sane defaults.
(load-subconfig "sane-defaults.el")

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

;; Add evil mode.
(use-package evil :ensure t)

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
      "'" 'eshell
      "b" 'ivy-switch-buffer
      "/" 'counsel-git-grep   ; Find a string in the current git project.
      "TAB" 'switch-to-other-buffer
      "SPC" 'avy-goto-word-or-subword-1
      "ad" 'dired-jump
      "f"   '(:ignore t :which-key "files")
      "ff" 'counsel-find-file ; Find a file using Ivy.
      "fr" 'counsel-recentf   ; Find recently-edited files.
      "p"   '(:ignore t :which-key "project")
      "pf" 'counsel-git     
  ))

(use-package which-key :ensure t)

(use-package avy :ensure t
  ;; These commands trigger the loading of the 'avy' package:
  :commands (avy-goto-word-1))

;; Display dired subtrees with tab key
(use-package dired-subtree :ensure t
  :after dired
  :config
  (bind-key "<tab>" #'dired-subtree-toggle dired-mode-map)
  (bind-key "<backtab>" #'dired-subtree-cycle dired-mode-map))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("f3f85a358dc6c3642bc6e0ca335c8909a2210814e5a7d4301993822bbf7db4e6" default)))
 '(package-selected-packages (quote (use-package general bind-key))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;; Disable the menu and tool bars.
(menu-bar-mode -1)
(tool-bar-mode -1)

;; Set custom theme load path.
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(load-theme 'smyx t)

;; Set default font.
(set-face-attribute 'default nil
                    :family "Ubuntu Mono"
                    :height 110
                    :weight 'bold
                    :width 'normal)

;; Use Evil mode.
(require 'evil)
(evil-mode 1)

;; Use ESC instead of C-g for `keyboard-quit`.
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Hide dired details that you don't need.
(add-hook 'dired-mode-hook
          (lambda ()
            (dired-hide-details-mode)))

