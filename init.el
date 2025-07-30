;; Basic setup
(setq inhibit-startup-message t)   ; Disable startup screen
(setq make-backup-files nil)       ; No backup~ files
(setq auto-save-default nil)       ; No auto-save files
(global-display-line-numbers-mode) ; Show line numbers

;; Set UTF-8 encoding
(set-language-environment "UTF-8")

;; Set default font
(set-face-attribute 'default nil :font "DejaVu Sans Mono-12")

;; Theme: wombat (built-in)
(load-theme 'wombat t)

;; Default size of Emacs client
(add-to-list 'default-frame-alist '(width . 100))  ; characters
(add-to-list 'default-frame-alist '(height . 40))  ; lines

;; Default location of Emacs client
(add-to-list 'default-frame-alist '(top . 100))
(add-to-list 'default-frame-alist '(left . 450))

;; Default Python interpreter
(setq python-shell-interpreter "~/venvs/entorno1/bin/python")

