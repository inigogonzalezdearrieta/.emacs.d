;;;; Emacs early_init file
;; Inigo Gonzalez de Arrieta Simple setup for improved garbage
;; collection and pre-loading themes.
;; Started on 2025/09/30
;;;;

;; GARBAGE COLLECTION

;; Temporarily increase GC threshold during startup
(setq gc-cons-threshold most-positive-fixnum)

;; Restore to normal value after startup (e.g. 50MB)
(add-hook 'emacs-startup-hook
          (lambda () (setq gc-cons-threshold (* 50 1024 1024))))

;; FRAME AND THEME CUSTOMIZATION

(setq inhibit-startup-message t)   ; Disable startup screen
; (load-theme 'wombat t) ; Load the built-in wombat theme
;;
; I'm switching to a light theme temporarily.
(load-theme 'modus-operandi t)
;;


;; Default size of Emacs client
(add-to-list 'default-frame-alist '(width . 100))  ; characters
(add-to-list 'default-frame-alist '(height . 40))  ; lines

;; Default location of Emacs client
(add-to-list 'default-frame-alist '(top . 100))
(add-to-list 'default-frame-alist '(left . 450))
