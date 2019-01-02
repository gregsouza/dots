;; Added by Package.el.  This must come before configurations of
;; installed packages.  Don't delete this line.  If you don't want it,
;; just comment it out by adding a semicolon to the start of the line.
;; You may delete these explanatory comments.
(package-initialize)




(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-color-names-vector
   ["#2d3743" "#ff4242" "#74af68" "#dbdb95" "#34cae2" "#008b8b" "#00ede1" "#e1e1e0"])
 '(custom-enabled-themes (quote (cyberpunk)))
 '(custom-safe-themes
   (quote
	("d1cc05d755d5a21a31bced25bed40f85d8677e69c73ca365628ce8024827c9e3" default)))
 '(inhibit-startup-screen t)
 '(package-selected-packages
   (quote
	(monokai-theme color-theme-sanityinc-tomorrow cyberpunk-theme ## flycheck-irony irony-eldoc irony flycheck company auto-complete-c-headers yasnippet-snippets yasnippet auto-complete))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;Hooks
(global-linum-mode t)

(add-to-list 'auto-mode-alist '("\\.h\\'" . c++-mode))

; start package.el with emacs
(require 'package)

; add melpa to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))

(require 'auto-complete)
(ac-config-default)
; initialize package.el
(package-initialize)

;;company
(require 'company)
  ;;config
(add-hook 'after-init-hook 'global-company-mode)
;;Sets company mode as default in all buffers
(global-set-key (kbd "M-/") 'company-complete-common-or-cycle)
;;set company complete as shortcut on M /

;;flycheck
(require 'flycheck)
(global-flycheck-mode)

;;Irony
(require 'irony)

(add-hook 'c++-mode-hook 'irony-mode)
(add-hook 'c-mode-hook 'irony-mode)

(add-hook 'irony-mode-hook 'irony-cdb-autosetup-compile-options)

;; Use compilation database first, clang_complete as fallback.
(setq-default irony-cdb-compilation-databases '(irony-cdb-libclang
						irony-cdb-clang-complete))

  ;; I use irony with company to get code completion.

(require 'company-irony)
(eval-after-load 'company '(add-to-list 'company-backends 'company-irony))

  ;; I use irony with flycheck to get real-time syntax checking.
(require 'flycheck-irony)
(eval-after-load 'flycheck '(add-hook 'flycheck-mode-hook #'flycheck-irony-setup))


(require 'irony-eldoc)
(add-hook 'irony-mode-hook #'irony-eldoc)


;; Auto-c-header
(defun my:ac-c-headers-init ()
  (require 'auto-complete-c-headers)
  (add-to-list 'ac-sources 'ac-source-c-headers))

(add-hook 'c++-mode-hook 'my:ac-c-headers-init)
(add-hook 'c-mode-hook 'my:ac-c-headers-init)
