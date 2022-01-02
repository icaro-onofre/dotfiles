;My theme
(load-theme 'melancholy)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/") ;; My Themes directory  

;Evil mode
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)

;Ui customization
(menu-bar-mode -1)
(toggle-scroll-bar -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)

;Org mode
(setq inhibit-splash-screen t)
(transient-mark-mode 1)
(require 'org)


;Treemacs
(global-set-key [f8] 'treemacs)
(require 'treemacs)

;Web mode
(add-to-list 'auto-mode-alist '("\\.jsx?$" . web-mode)) ;;
(setq web-mode-content-types-alist '(("jsx" . "\\.js[x]?\\'")))




;(global-display-line-numbers-mode)
(display-line-numbers-mode)
(setq display-line-numbers 'relative)



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(wombat))
 '(custom-safe-themes
   '("f58a93ce89fe82c77da6c44b88a1ca1a1d5b3e741ce6ad5877acb4ef9c76c451" "f47a7e08d0dc9b0e069cec223c4b044647f3b6f26881698f1a4a39e2adce012b" "2aa073a18b2ba860d24d2cd857bcce34d7107b6967099be646d9c95f53ef3643" default))
 '(package-selected-packages
   '(dired-rainbow web-mode evil-org pdf-tools fzf treemacs-evil treemacs markdown-mode ht org)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(window-divider ((t (:foreground "DodgerBlue4")))))

;Enabiling melpa
(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org"."https://orgmode.org/elpa/")
                         ("elpa"."https://melpa.org/packages/")))
