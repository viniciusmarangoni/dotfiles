(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(setq custom-file "~/.emacs.d/custom.el")    ; Avoid writing in this file (.emacs.el)
(toggle-frame-fullscreen)                    ; Full Screen
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

(setq myPackages
      '(doom-themes
        rainbow-delimiters
        powerline
        autopair
        neotree))

;; Install myPackages if not installed
(dolist (package myPackages)
  (unless (package-installed-p package)
    (package-install package)))

;; Theme
(require 'doom-themes)
(setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
      doom-themes-enable-italic t) ; if nil, italics is universally disabled

(load-theme 'doom-one t)
(doom-themes-visual-bell-config)
(doom-themes-org-config)

;; Custom configs
(setq-default c-basic-offset 4)                ; Use tab-width for C offset
(global-linum-mode 1)                          ; Show line numbers on buffers
(setq inhibit-startup-message t)               ; No message at startup
(setq-default indent-tabs-mode nil)            ; Use spaces instead of tabs
(setq-default tab-width 4)                     ; Length of tab is 4 spaces
(setq blink-matching-paren-distance nil)       ; Blinking parenthesis
(setq echo-keystrokes 0.1)                     ; Echo Keystroke Delay
(setq visible-bell t)                          ; Removes audible warnings
(setq line-number-mode t)                      ; Display current line
(global-hl-line-mode 1)                        ; highlight current line
(tool-bar-mode -1)                             ; Disable toolbar
(scroll-bar-mode -1)                           ; Disable scrollbar
(menu-bar-mode -1)                             ; Disable menubar
(show-paren-mode 1)                            ; Highlight parenthesis pairs
(set-face-background 'show-paren-match-face "#ffffff") ; Color of parenthesis pairs
(set-face-attribute 'show-paren-match-face nil         ;;
                    :weight 'bold :underline nil :overline nil :slant 'normal)

;; Little piece of black magic to highlight the open parenthesis when
;; the cursor is on closing parenthesis, instead of "one character after"

;; -------------------[ Start Black Magic ]-------------------
(defadvice show-paren-function 
  (around show-paren-closing-before
          activate compile)
  (if (eq (syntax-class (syntax-after (point))) 5)
      (save-excursion
        (forward-char)
        ad-do-it)
    ad-do-it))
;; -------------------[ End Black Magic ]-------------------

(setq-default show-paren-style 'mixed)         ; Set highlight (exp/mixed/paren)
(fset 'yes-or-no-p 'y-or-n-p)                  ; y/n instead of yes/no

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook                      ; Programming modes only
  'rainbow-delimiters-mode)

(require 'powerline)
(powerline-center-theme)

(require 'autopair)                            ; Automagically pair braces and quotes
(autopair-global-mode)                         ; to enable in all buffers

(require 'neotree)
(global-set-key [f8] 'neotree-toggle)
(setq neo-theme (if (display-graphic-p) 'nerd))
