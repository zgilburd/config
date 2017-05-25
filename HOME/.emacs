;; initial package setup
(require 'package)
(setq package-enable-at-startup nil)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/"))
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'package-archives '("melpa-stable" . "http://stable.melpa.org/packages/"))
(setq package-enable-at-startup nil)
(package-initialize)

(column-number-mode t)
(show-paren-mode t)
(setq tab-width 2)
(setq indent-tabs-mode nil)

(unless (window-system)
  (menu-bar-mode -1)
  (tool-bar-mode -1))

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))
(eval-when-compile
  (require 'use-package))

(use-package color-theme-sanityinc-tomorrow
  :ensure t)
(use-package color-theme
  :ensure t
  :config 
  (setq custom-safe-themes t)
  (color-theme-sanityinc-tomorrow-night))

(define-key global-map (kbd "C-c a") 'org-agenda)

(use-package evil
  :ensure t
  :config
(evil-mode t)
(eval-after-load "evil"
  '(progn
    (define-key evil-normal-state-map (kbd "C-h") 'evil-window-left)
    (define-key evil-normal-state-map (kbd "C-j") 'evil-window-down)
    (define-key evil-normal-state-map (kbd "C-k") 'evil-window-up)
    (define-key evil-normal-state-map (kbd "C-l") 'evil-window-right)
    (define-key evil-insert-state-map (kbd "M-x") 'execute-extended-command)
    (global-set-key (kbd "M-x") 'execute-extended-command))))


(setq org-agenda-files '("~/git/notes"))

;; allow vim navigation in agenda mode
(add-hook 'org-agenda-mode-hook
  (lambda ()
    (define-key org-agenda-mode-map "\C-n" 'evil-next-buffer)
    (define-key org-agenda-mode-map "\C-p" 'evil-prev-buffer)
    (define-key org-agenda-mode-map "b" 'evil-backward-word-begin)
    (define-key org-agenda-mode-map "h" 'evil-backward-char)
    (define-key org-agenda-mode-map "j" 'evil-next-line)
    (define-key org-agenda-mode-map "k" 'evil-previous-line)
    (define-key org-agenda-mode-map "l" 'evil-forward-char)
    (define-key org-agenda-mode-map "n" 'evil-forward-word-begin)
    (define-key org-agenda-mode-map "p" 'evil-forward-word-begin)
    (define-key org-agenda-mode-map "w" 'evil-forward-word-begin)))

(use-package org
  :ensure t
  :ensure org-plus-contrib
  :config
  (require 'ox-md)
  (require 'ox-confluence)
  (setq org-todo-keywords
    '((sequence "TODO" "IN-PROGRESS" "ASSIGNED" "WAITING" "|" "DONE" "CANCELLED")))
  (setq org-enforce-todo-dependencies t)
  (setq org-log-done (quote time))
  (setq org-log-redeadline (quote time))
  (setq org-log-reschedule (quote time))
  ;; Shortcut for adding comment blocks
  (add-to-list 'org-structure-template-alist'
    ("C" "#+BEGIN_COMMENT\n?\n#+END_COMMENT"))
  ;; What languages can be evaluated from src blocks?
  (org-babel-do-load-languages 'org-babel-load-languages'
    ((python . t) (shell . t) (awk . t)))
  ;; Improve source block appearance in orgmode
  (setq org-edit-src-content-indetation 0
    org-src-tab-acts-natively t
    org-src-fontify-natively t
    org-src-preserve-indentation t
    org-confirm-babel-evaluate nil)
  ;; Syntax hilighting for exported code
  (add-to-list 'org-latex-packages-alist '("" "minted"))
  (setq org-latex-listings 'minted)
  (setq org-latex-pdf-process
    '("pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
      "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f"
      "pdflatex -shell-escape -interaction nonstopmode -output-directory %o %f")))

(use-package expand-region
  :bind ("C-=" . er/expand-region))

(use-package dockerfile-mode
  :defer t)

(use-package go-mode
  :defer t)

(use-package json-mode
  :defer t)

(use-package markdown-mode
  :ensure t
  :mode ("\\.\\(m\\(ark\\)?down\\|md\\)$" . markdown-mode)
  :config)

(use-package pandoc-mode
  :defer t)

(use-package powershell
  :ensure t)

(use-package puppet-mode
  :defer t)

(use-package yaml-mode
  :defer t)

;; disable help text
(setq inhibit-splash-screen t
  inhibit-startup-message t
  inhibit-startup-echo-area-message t)

