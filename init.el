(defconst user-home (concat (getenv "HOME") "/"))
(defconst user-emacs-dir   (concat user-home ".emacs.d/"))

(add-to-list 'load-path
	     "~/.emacs.d/plugins")
(add-to-list 'load-path
	     "~/.emacs.d/vendor/yasnippet")
(add-to-list 'load-path
	     "~/.emacs.d/vendor/magit")
(add-to-list 'load-path
	     "~/.emacs.d/vendor/emacs-smartchr")
(add-to-list 'load-path "~/.emacs.d/vendor/auto-complete")
(add-to-list 'load-path "~/.emacs.d/vendor/tabbar")
;;(setq custom-file "~/.emacs.d/cfg/b.sys.el")
;;(add-to-list 'load-path "~/.emacs.d/site-lisp")
(mapc 'load (directory-files "~/.emacs.d/cfg/" t "\\.el$"))


;; Set this if your emacs cannot find your git path.
;; And keep annoying "There is no Git repository..."
(setenv "PATH" (concat (getenv "PATH") ":/usr/local/git/bin")) 
(setq exec-path (append exec-path '("/usr/local/git/bin"))) 
(autoload 'magit-status "magit" "Show status of git repository." t)
