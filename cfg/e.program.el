;; -*- coding: utf-8; -*-

;; 让 etags 在当前目录和上级目录中搜索 TAGS 文件
(setq tags-table-list '("." ".." "../.."))

;;=============================================================
;; C & C++
;;=============================================================
;; (defun my-c-mode()
;;     (define-key c-mode-map [return] 'newline-and-indent)
;;     (interactive)
;;     (c-set-style "k&r")
;;     (c-toggle-auto-newline)
;;     (c-toggle-hungry-state)
;;     (imenu-add-menubar-index)
;;     (which-function-mode)
;;     )
;; (add-hook 'c-mode-hook 'my-c-mode)
(add-hook 'c-mode-common-hook 'google-set-c-style)
(add-hook 'c-mode-common-hook 'google-make-newline-indent)

;; autocomplete
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/vendor/auto-complete/dict")
(ac-config-default)
;; yasnippet.
(require 'yasnippet)
(yas/initialize)
(setq yas/root-directory "~/.emacs.d/vendor/yasnippet/snippets")
(yas/load-directory yas/root-directory)
;; smartchr
(require 'smartchr)

;;_+ cpp-mode


;; python-mode
;; (setq auto-mode-alist (cons '(".py$" . python-mode) auto-mode-alist))
;; (setq interpreter-mode-alist 
;;       (cons '("python" . python-mode) interpreter-mode-alist))
;; (autoload 'python-mode "python-mode" "Python editing mode." t)

;; http://sakito.jp/emacs/emacsobjectivec.html
;; for ff-find-other-file
(setq ff-other-file-alist
     '(("\\.mm?$" (".h"))
       ("\\.cc$"  (".hh" ".h"))
       ("\\.hh$"  (".cc" ".C"))

       ("\\.c$"   (".h"))
       ("\\.h$"   (".c" ".cc" ".C" ".CC" ".cxx" ".cpp" ".m" ".mm"))

       ("\\.C$"   (".H"  ".hh" ".h"))
       ("\\.H$"   (".C"  ".CC"))

       ("\\.CC$"  (".HH" ".H"  ".hh" ".h"))
       ("\\.HH$"  (".CC"))

       ("\\.cxx$" (".hh" ".h"))
       ("\\.cpp$" (".hpp" ".hh" ".h"))

       ("\\.hpp$" (".cpp" ".c"))))

(add-hook 'c-mode-common-hook
  (lambda() 
    (local-set-key  (kbd "C-c o") 'ff-find-other-file)))

;; smartchr.
(defun smartchr-custom-keybindings ()
  (local-set-key (kbd "=") (smartchr '(" = " " == "  "=")))
  ;; !! がカーソルの位置
  (local-set-key (kbd "(") (smartchr '("(`!!')" "(")))
  (local-set-key (kbd "[") (smartchr '("[`!!']" "[ [`!!'] ]" "[")))
  (local-set-key (kbd "{") (smartchr '("{\n`!!'\n}" "{`!!'}" "{")))
  (local-set-key (kbd "`") (smartchr '("\``!!''" "\`")))
  (local-set-key (kbd "\"") (smartchr '("\"`!!'\"" "\"")))
  (local-set-key (kbd ">") (smartchr '(">" " => " " => '`!!''" " => \"`!!'\"")))
  )

(defun smartchr-custom-keybindings-objc ()
  (local-set-key (kbd "@") (smartchr '("@\"`!!'\"" "@")))
  )

(add-hook 'c-mode-common-hook 'smartchr-custom-keybindings)
(add-hook 'objc-mode-hook 'smartchr-custom-keybindings-objc)


;; slime.
;;(add-to-list 'load-path "/opt/local/share/emacs/slime")     ; tell emacs where slime is
;;(require 'slime)
;; sbcl
;;(setq inferior-lisp-program "/opt/local/bin/sbcl")
;;(slime-setup '(slime-fancy))
