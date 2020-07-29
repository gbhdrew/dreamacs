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
