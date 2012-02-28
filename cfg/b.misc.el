;; -*- coding: utf-8; -*-

;; erc
;; joining && autojoing

;; make sure to use wildcards for e.g. freenode as the actual server
;; name can be be a bit different, which would screw up autoconnect
(erc-autojoin-mode t)
(setq erc-autojoin-channels-alist
  '((".*\\.freenode.net" "#emacs" "#git" "#ubuntu" "#go-nuts" "#webkit" "#chromium" "#python")))
;; check channels
(erc-track-mode t)
(setq erc-track-exclude-types '("JOIN" "NICK" "PART" "QUIT" "MODE"

                                 "324" "329" "332" "333" "353" "477"))
;; don't show any of this
(setq erc-hide-list '("JOIN" "PART" "QUIT" "NICK"))

(defun djcb-erc-start-or-switch ()
  "Connect to ERC, or switch to last active buffer"
  (interactive)
  (if (get-buffer "irc.freenode.net:6667") ;; ERC already active?

    (erc-track-switch-buffer 1) ;; yes: switch to last active
    ;; (when (y-or-n-p "Start ERC? ") ;; no: maybe start ERC
      ;; nick:user's nick name
      ;; full-name: user's full name
      (erc :server "irc.freenode.net" :port 6667 :nick "karpar" :full-name "zhili_hu")
      ));;)


(add-hook 'erc-after-connect
          '(lambda (SERVER NICK)
             (cond
              ((string-match "freenode\\.net" SERVER)
               (erc-message "PRIVMSG" "NickServ identify a39335125"))
              ;; password1 nickname server's password
             ;; ((string-match "oftc\\.net" SERVER)
             ;;  (erc-message "PRIVMSG" "NickServ identify xxxxxx"))
             ))) 

;; kill buffer on quit.
(setq erc-kill-buffer-on-part t)             
(setq erc-kill-queries-on-quit t)
(setq erc-kill-server-buffer-on-quit t)
;; set-up quit reason.
(setq erc-part-reason 'erc-part-reason-zippy)
(setq erc-quit-reason 'erc-quit-reason-zippy)
;; (autoload 'twitter-get-friends-timeline "twitter" nil t)
;; (autoload 'twitter-status-edit "twitter" nil t)
;; (add-hook 'twitter-status-edit-mode-hook 'longlines-mode)

;;(twitter-user-name-face ((t (:bold t :foreground "white"  :background "blue"))))
;;(twitter-time-stamp-face ((t (:bold nil :foreground "white" :background "blue"))))
(setq browse-url-browser-function 'browse-url-generic
      browse-url-generic-program "google-chrome")