;;;; Emacs early_init file
;; Inigo Gonzalez de Arrieta
;; Simple setup for improved garbage collection
;; Started on 2025/09/30
;;;;

;; GARBAGE COLLECTION

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 50MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 50 1024 1024))))

;; OTHER OPTIONS

(setq inhibit-startup-message t)   ; Disable startup screen
(load-theme 'wombat t) ; Load the built-in wombat theme

;; Default size of Emacs client
(add-to-list 'default-frame-alist '(width . 100))  ; characters
(add-to-list 'default-frame-alist '(height . 40))  ; lines

;; Default location of Emacs client
(add-to-list 'default-frame-alist '(top . 100))
(add-to-list 'default-frame-alist '(left . 450))
