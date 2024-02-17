;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Murali Krishna Patteboyina"
      user-mail-address "murali.patteboyina@entaingroup.com.au")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))
;;(setq doom-font (font-spec :family "Fira Code Retina" :size 12 :weight 'light))
;; (setq doom-font (font-spec :family "Fira Code Retina" :size 12 :weight 'light)
;;      doom-variable-pitch-font (font-spec :family "Fira Code Retina" :size 13)
;;      doom-big-font (font-spec :family "Fira Code Retina" :size 20 :weight 'light))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-city-lights)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
(setq org-roam-directory "~/roam")

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
(add-hook 'vue-mode-hook #'lsp!)
(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-mode))

(setq
 projectile-project-search-path '("~/go/src/git.neds.sh/")
 )

;; Set Indentation for CSS files to 2 spaces
(after! css-mode
  (setq css-indent-offset 2))

;; Set Indentation for JS files to 2 spaces
(after! javascript-mode
  (setq javascript-indentation 2
        js-indent-level 2))

(after! typescript
  (setq typescript-indent-level 2))

(after! json-mode
  (setq javascript-indentation 2
        js-indent-level 2))

;; Set Indentation for all web related pages
(after! web-mode
  (setq web-mode-engines-alist '(("django"."\\.html\\.tera\\'")))
  (add-hook! web-mode
             (setq web-mode-markup-indent-offset 2
                   web-mode-css-indent-offset 2
                   web-mode-code-indent-offset 2)))

;; lsp mode for auto completion
(use-package lsp-mode)
(add-hook 'prog-mode-hook #'lsp)

;; DAP mode for debugging
(use-package dap-mode
  :config
  (dap-auto-configure-mode)

  :bind
  (("<f7>" . dap-step-in)
   ("<f8>" . dap-next)
   ("<f9>" . dap-continue)))

;; Go Debugging
(require 'dap-dlv-go)

;; Go - lsp-mode
;; Set up before-save hooks to format buffer and add/delete imports.
(defun lsp-go-install-save-hooks ()
  (add-hook 'before-save-hook #'lsp-format-buffer t t)
  (add-hook 'before-save-hook #'lsp-organize-imports t t))
(add-hook 'go-mode-hook #'lsp-go-install-save-hooks)

;; accept completion from copilot and fallback to company
(use-package! copilot
  :hook (prog-mode . copilot-mode)
  :bind (:map copilot-completion-map
              ("<tab>" . 'copilot-accept-completion)
              ("TAB" . 'copilot-accept-completion)
              ("C-TAB" . 'copilot-accept-completion-by-word)
              ("C-<tab>" . 'copilot-accept-completion-by-word)))

(use-package doom-themes
  :ensure t
  :config
  ;; Global settings (defaults)
  (setq doom-themes-enable-bold t    ; if nil, bold is universally disabled
        doom-themes-enable-italic t) ; if nil, italics is universally disabled
  (load-theme 'doom-one t)

  ;; Enable flashing mode-line on errors
  (doom-themes-visual-bell-config)
  ;; Enable custom neotree theme (all-the-icons must be installed!)
  ;;(doom-themes-neotree-config)
  ;; or for treemacs users
  (setq doom-themes-treemacs-theme "doom-atom") ; use "doom-colors" for less minimal icon theme
  (doom-themes-treemacs-config)
  ;; Corrects (and improves) org-mode's native fontification.
  (doom-themes-org-config))

(use-package treemacs-nerd-icons
        :after treemacs
        :config
        (treemacs-load-theme "nerd-icons"))


(use-package activity-watch-mode
  :config
  (setq activity-watch-api-host "http://localhost:5600"))

(global-activity-watch-mode)
