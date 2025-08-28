;;;; Emacs init file
;; Inigo Gonzalez de Arrieta
;; Started on 2025/07/30
;;;;

;; Basic setup
(setq inhibit-startup-message t)   ; Disable startup screen
(setq make-backup-files nil)       ; No backup~ files
(setq auto-save-default nil)       ; No auto-save files
(global-display-line-numbers-mode) ; Show line numbers
(setq-default major-mode 'text-mode)

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

;; Default Python interpreter (venv instead of default)
(setq python-shell-interpreter "~/venvs/entorno1/bin/python")

;;;;
;; BINDINGS
;;;;

;; Unbind 'C-x f'
(keymap-global-unset "C-x f")

;;;;
;; PACKAGES
;;;;

;; Adapted from https://realpython.com/emacs-the-best-python-editor/
(require 'package)
(add-to-list 'package-archives
	'("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
	(package-refresh-contents))

;; Installs packages
(defvar myPackages
	'(markdown-mode
	corfu
	python-black
    )
)

;; Scans the list in myPackages
;; If the package listed is not already installed, install it
(mapc #'(lambda (package)
          (unless (package-installed-p package)
            (package-install package)))
      myPackages)

;;;;
;; PACKAGE OPTIONS
;;;;

;; Text and org
(add-hook 'text-mode-hook 'turn-on-auto-fill)
(require 'org) ;; Ensure Org is loaded
(require 'ob-python) ;; (Optional) load Python backend explicitly
(require 'org-tempo) ;; Allows starting source blocks with < s TAB
(add-hook 'org-mode-hook 'visual-line-mode) ;; Wrap lines in a pleasing manner in Org mode.
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)))
(setq org-babel-python-command "~/venvs/entorno1/bin/python")
(setq org-confirm-babel-evaluate nil) ;; Avoid being asked for confirmation.


;; Enable corfu globally for autocompletion
(require 'corfu)
(global-corfu-mode)

;; Enable python-black formatting on save
(require 'python-black)
(add-hook 'python-mode-hook #'python-black-on-save-mode)

;; Python autocompletion (make sure to npm install -g pyright)
(add-hook 'python-mode-hook #'eglot-ensure)

;; Added automatically by Customize after package-install
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages nil))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
