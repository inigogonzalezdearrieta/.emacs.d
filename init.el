;;;; Emacs init file
;; Inigo Gonzalez de Arrieta
;; Minimalist setup for Python, Markdown and org-mode.
;; Python packages installed via guix for reproducibility.
;; Emacs installed through apt and packages via use-package.
;; Started on 2025/07/30.
;;;;

;; Basic setup
;; Some basic stuff is loaded in early-init.el to avoid flickering
(setq make-backup-files nil)       ; No backup ~ files
(setq auto-save-default nil)       ; No auto-save files
(global-display-line-numbers-mode) ; Show line numbers
(setq ring-bell-function 'ignore) ; Disable the annoying bell sound

;; Set UTF-8 encoding
(set-language-environment "UTF-8")

;; Set default font
(set-face-attribute 'default nil :font "DejaVu Sans Mono-12")

;; Define a separate custom.el file for Customize to use.
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file 'noerror) ; No error message if not available.

;;;;
;; BINDINGS
;;;;

;; Unbind 'C-x f'
(keymap-global-unset "C-x f")

;;;;
;; PACKAGES
;;;;

;; Basic package initialization.
(require 'package)
(add-to-list 'package-archives
     '("melpa" . "http://melpa.org/packages/") t)

;; Set priorities (MELPA only if necessary)
(setq package-archive-priorities
      '(("gnu" . 10)
	("nongnu" . 5)
	("melpa"   . 1)))

(package-initialize)
(when (not package-archive-contents)
	(package-refresh-contents))

;; Set use-package up (the most up-to-date method)
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(require 'use-package)

;; LIST OF PACKAGES

;; Markdown support
;; Requires: pandoc
(use-package markdown-mode
  :ensure t
  :mode ("\\.md\\'" . markdown-mode)
  :init (setq markdown-command "pandoc"))

;; Denote for quick note generation
(use-package denote
  :ensure t)
(setq denote-file-type 'markdown-yaml) ; Markdown instead of org

;; Magit for Git integration
;; Requires: git
(use-package magit
  :ensure t
  :bind (("C-x g" . magit-status)
         ("C-x C-g" . magit-status)))

;; Blacken for Python formatting
;; Requires: python-black
(use-package blacken
  :ensure t
  :hook (python-mode . blacken-mode)
  :config
  (setq blacken-line-length 80))

;; Vterm for proper terminal compatibility.
;; Requires: cmake, libtool-bin, libvterm(-dev)
(use-package vterm
  :ensure t)

;; Company for autocompletion.
(use-package company
  :ensure t
  :init
  (global-company-mode)  ;; Enable company mode globally
  :config
  (setq company-idle-delay 0.2)  ;; Delay before suggestions pop up
  (setq company-minimum-prefix-length 2))  ;; Minimum characters before suggestions

;; Company-jedi for Python autocompletion
;; Requires: python-jedi, python-epc
(use-package company-jedi
  :ensure t
  :after company
  :config
  (add-to-list 'company-backends 'company-jedi))

;;;;
;; PACKAGE OPTIONS (ONLY FOR BUILT-IN ONES)
;;;;

;; Default Python interpreter (guix one instead of system Python)
;; Requires: python-wrapper (to equate python to python3 in guix)
(setq python-shell-interpreter "~/.guix-profile/bin/python")
(setq python-indent-offset 4)

;; Text
(setq-default major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Org
(require 'org) ;; Ensure Org is loaded
(require 'ob-python) ;; (Optional) load Python backend explicitly
(require 'org-tempo) ;; Allows starting source blocks with < s TAB
(org-babel-do-load-languages
 'org-babel-load-languages
 '((python . t)
   (emacs-lisp . t)
   (shell . t)))
(setq org-babel-python-command "~/.guix-profile/bin/python") ; Requires python-wrapper
(setq org-confirm-babel-evaluate nil) ;; Avoid being asked for confirmation.

; Default values to be loaded on new .org files.
(defun my-org-insert-header ()
  "Insert default header if a .org file is new/empty."
  (when (and buffer-file-name
            (= (buffer-size) 0))
    (insert "#+AUTHOR: Iñigo González de Arrieta\n"
            "#+OPTIONS: toc:nil\n"
            "#+TITLE: \n"
            "\n")))
(add-hook 'org-mode-hook 'my-org-insert-header)
(add-hook 'org-mode-hook 'visual-line-mode) ;; Wrap lines in a pleasing manner in Org mode.

;;;;
;; END OF USER-GENERATED CODE
;;;;
