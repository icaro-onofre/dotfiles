(setq display-line-numbers-type 'relative)
(setq doom-theme 'doom-tokyo-night
    doom-themes-enable-bold t
    doom-font (font-spec :family "Inconsolata" :size 15 )
    doom-themes-enable-italic t)

(setq org-roam-directory "~/baum/baum")

(setq user-full-name "Icaro"
      user-mail-address "icaro.onofre.s@gmail.c")
(setq org-hide-emphasis-markers t)
(setq org-agenda-files "~/baum/baum/20220912112741-agenda.org")

(setq org-superstar-headline-bullets-list '("🌸" "🌼" "🌺"))

(setq mu4e-maildir "~/.mail/gmail" )
(setq mu4e-get-mail-command "mbsync -a" )
(add-hook 'dired-mode-hook (lambda () (org-roam-mode -1)))

(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)

(add-hook 'dired-mode-hook 'org-roam-mode -1)

;; (require 'dap-python)
;; (dap-register-debug-template "Python"
;;   (list :type "python"
;;         :args "-i"
;;         :cwd nil
;;         :env '(("DEBUG" . "1"))
;;         :target-module (expand-file-name "~/src/myapp/.env/bin/myapp")
;;         :request "launch"
;;         :name "My App"))
