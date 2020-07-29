;; Initially based on this guide:
;; https://sam217pa.github.io/2016/09/02/how-to-build-your-own-spacemacs/

(setq config-dir "~/.emacs.d")
(setq config-path (concat config-dir "/init.el"))

;; Function to load subconfig files:
(setq subconfigs-dir (concat config-dir "/subconfigs"))
(defun load-subconfig (name) 
  (load-file (concat subconfigs-dir "/" name)))

;; Set some sane defaults.
(load-subconfig "sane-defaults.el")

;; Load and initialize packages.
(load-subconfig "packages.el")

;; Set custom theme and load path:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(load-theme 'smyx t)

;; Set default font.
(set-face-attribute 'default nil
                    :family "Ubuntu Mono"
                    :height 110
                    :weight 'bold
                    :width 'normal)

;; Use Evil evil-magit modes.
(require 'evil)
(evil-mode 1)
(require 'evil-magit)

;; Use ESC instead of C-g for `keyboard-quit`.
(define-key key-translation-map (kbd "ESC") (kbd "C-g"))

;; Hide dired details that you don't need.
(add-hook 'dired-mode-hook
          (lambda ()
            (dired-hide-details-mode)))

;; Open new buffers in new windows
(setq pop-up-frames t)

;; Don't edit below this line:
;; ---------------------------

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
