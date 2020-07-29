;; Initially based on this guide:
;; https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/

;; Some sane defaults.
(setq delete-old-versions -1 )        ; Delete excess backup versions silently.
(setq version-control t )             ; Use version control.
(setq vc-make-backup-files t )        ; Make a backups file even when in version-controlled dir.
(setq backup-directory-alist `(("." . "~/.emacs.d/backups")) ) ;; Put the backups file here.
(setq vc-follow-symlinks t )          ; Don't ask for confirmation when opening a symlinked file.
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)) ) ; Transform the backups file name.
(setq inhibit-startup-screen t )      ; Inhibit the useless and old-school startup screen.
(setq ring-bell-function 'ignore )    ; Don't ring a bell when you make a mistake.
(setq coding-system-for-read 'utf-8 ) ; Use utf-8 by default.
(setq coding-system-for-write 'utf-8 )
(setq sentence-end-double-space nil)  ; Don't use two spaces after a period. 
(setq default-fill-column 100)	      ; Toggle text-wrapping at the 100th character.
(setq initial-scratch-message "Welcome to Dreamacs") ;; Print a default message in the empty scratch buffer opened at startup.

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

;; Evil mode.
(use-package evil :ensure t)

;; Use the 'general' package to assign keybindings.
(use-package general :ensure t
  :config
  (general-define-key 
    :states '(normal visual insert emacs)
    "C-s" 'swiper             ; Search for a string in the current buffer.
    "M-x" 'counsel-M-x        ; Replace the default M-x with ivy backend.
    :prefix "SPC"
    :non-normal-prefix "C-SPC"
      "'" 'eshell
      "b" 'ivy-switch-buffer
      "/" 'counsel-git-grep   ; Find a string in the current git project.
      "TAB" '(switch-to-other-buffer :which-key "prev buffer")
      "SPC" '(avy-goto-word-or-subword-1 :which-key "go to char")
      "f"   '(:ignore t :which-key "files")
      "ff" 'counsel-find-file ; Find a file using Ivy.
      "fr" 'counsel-recentf   ; Find recently-edited files.
      "p"   '(:ignore t :which-key "project")
      "pf" '(counsel-git :which-key "find file in git dir")     
  ))

(use-package avy :ensure t
  ;; These commands trigger the loading of the 'avy' package:
  :commands (avy-goto-word-1))

(use-package which-key :ensure t)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages (quote (use-package general bind-key))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(require 'evil)
(evil-mode 1)

;; Use ESC instead of C-g for `keyboard-quit`.
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))
