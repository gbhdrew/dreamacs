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

;; Disable the menu and tool bars.
(menu-bar-mode -1)
(tool-bar-mode -1)
