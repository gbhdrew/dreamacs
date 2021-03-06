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

;; (load (expand-file-name "~/quicklisp/slime-helper.el"))
;; use sbcl as Common Lisp implementation:
(setq inferior-lisp-program "sbcl")

;; Set custom theme and load path:
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") 
(load-theme 'smyx t)

;; Set default font.
(set-face-attribute 'default nil
                    :family "Ubuntu Mono"
                    :height 110
                    :weight 'bold
                    :width 'normal)

;; Use Evil and evil-magit modes.
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

;; Typescript config, based on the Tide package
(load-subconfig "typescript.el")

;; Initialize exec-path-from shell package:
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

;; Registers
(set-register ?e (cons 'file config-dir))
;; work org file (not in this repo)
(set-register ?l (cons 'file "~/sync/orgs/lb.org"))

;; Start a server on launch
(server-start)

;; set chrome as default browser for external links
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")

;; open org-mode links in the same frame
(setq org-link-frame-setup '((file . find-file)))

;; scroll one line at a time (less "jumpy" than defaults)
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate scrolling
(setq mouse-wheel-follow-mouse 't) ;; scroll window under mouse
(setq scroll-step 1) ;; keyboard scroll one line at a time


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
 '(package-selected-packages (quote (shell-pop prettier use-package general bind-key)))
 '(shell-pop-shell-type (quote ("eshell" "*eshell*" (lambda nil (eshell))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
