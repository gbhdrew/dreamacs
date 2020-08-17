;; Typescript config with tide and company-mode.
(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; initialize tide when using typescript-mode and js-mode
(add-hook 'typescript-mode-hook #'setup-tide-mode)

;; Support for .tsx files
(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . web-mode))
(add-hook 'web-mode-hook
          (lambda ()
            (when (string-equal "tsx" (file-name-extension buffer-file-name))
              (setup-tide-mode))))

;; enable typescript-tslint checker
(flycheck-add-mode 'typescript-tslint 'web-mode)

;; Activate prettier when using typescript-mode.
(add-hook 'typescript-mode-hook 'prettier-js-mode)

;; Use prettier before-safe-hook for typescript-mode.
(defun typescript-prettier-on-save()
  "Run prettier formatting for typescript-mode on save."
  (when (eq major-mode 'typescript-mode)) (prettier-prettify))

(add-hook 'before-save-hook 'typescript-prettier-on-save)
