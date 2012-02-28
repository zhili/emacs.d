;; -*- coding: utf-8; -*-

(global-unset-key "\C-z")
(global-unset-key "\C-o")

;;(global-set-key [mouse-4] 'scroll-up)
;;(global-set-key [mouse-5] 'scroll-down)
(global-set-key [f1] 'cvs-examine)
(global-set-key [C-f4] 'kill-this-buffer)
(global-set-key [M-f4] 'save-buffers-kill-emacs)
(global-set-key [f5] 'eshell)
(global-set-key [f6] 'query-replace-regexp)
(global-set-key [f7] 'speedbar)
(global-set-key [f8] 'calendar)
(global-set-key [f11] 'org-agenda-list)
(global-set-key [f12] 'list-bookmarks)
(global-set-key [C-f12] 'bookmark-set)
(global-set-key [M-f12] 'bookmark-jump)


(global-set-key [M-f5] 'my-insert-char-next-line)
(global-set-key [C-f5] 'my-insert-char-prev-line)
(global-set-key [M-f6] 'my-isearch-region-forward)


(global-set-key "\C-z\C-o" 'occur)
(global-set-key "\C-z\C-f" 'flush-lines)
(global-set-key "\C-z\C-k" 'keep-lines)
(global-set-key "\C-z\C-d" 'delete-region)
(global-set-key "\C-z\C-a" 'ascii-table-show)

(global-set-key (kbd "C-0") 'delete-window)
(global-set-key (kbd "C-1") 'delete-other-windows)
(global-set-key (kbd "C-2") 'split-window-vertically)
(global-set-key (kbd "C-3") 'split-window-horizontally)

;; 类似于 vim 的 C-a，可以支持传递参数
(global-set-key (kbd "C-z a") 'wcy-rotate-text)

(global-set-key (kbd "C-z b") 'browse-url-at-point)

;;统计区域中英文数
(global-set-key (kbd "C-z c") 'my-count-ce-word)


;; 王垠主页上给出的一个命令，类似于 vim 的 f，可以跳到指定的字母。
(global-set-key (kbd "C-z f") 'wy-go-to-char)

;; 这个命令配合 comment-dwim 基本上能满足所有的注释命令
(global-set-key (kbd "C-z g") 'comment-or-uncomment-region)

;;(setq mac-command-modifier 'meta)
(setq mac-option-key-is-meta nil)
(setq mac-command-key-is-meta t)
(setq mac-command-modifier 'meta)
;;(setq mac-option-modifier nil)
(setq mac-option-modifier 'super)
;; http://pablo.rauzy.name/dev/init.el.html
(defun comment-or-uncomment-region-or-line ()
  "Like comment-or-uncomment-region, but if there's no mark \(that means no
region\) apply comment-or-uncomment to the current line"
  (interactive)
  (if (not mark-active)
      (comment-or-uncomment-region
        (line-beginning-position) (line-end-position))
      (if (< (point) (mark))
          (comment-or-uncomment-region (point) (mark))
        (comment-or-uncomment-region (mark) (point)))))

(global-set-key [(super /)] 'comment-or-uncomment-region-or-line)

(global-set-key (kbd "C-c h d") 'my-insert-date)
;; imenu 是一个代码跳转的很好用的命令。这个命令在调用 imenu 同时，显示所有补全
(global-set-key (kbd "C-z i") 'his-imenu)

;; ffap 是一个非常好用的命令。
(global-set-key (kbd "C-z j") 'ffap)

;; switch to ERC with Ctrl+c e
(global-set-key (kbd "C-z e") 'djcb-erc-start-or-switch) ;; ERC             

;; twitter client start
;; (global-set-key (kbd "C-z t") 'twittering-start)


;;;显示菜单
(global-set-key (kbd "C-z m") 'menu-bar-mode)

;;显示行号
(global-set-key (kbd "C-z n") 'linum-mode)

(global-set-key (kbd "C-z o") 'open-line)


(global-set-key (kbd "C-z q") 'ywb-quote-region)


;; 刷新文件。
(global-set-key (kbd "C-z u") 'revert-buffer)

(global-set-key (kbd "C-z v") 'view-mode)

;; w3m 用于浏览本地的 html
(global-set-key (kbd "C-z w") 'w3m)

(global-set-key (kbd "S-SPC") 'set-mark-command)

;; 王垠主页上的一个命令。很好用。类似 vim 的相同命令。
(global-set-key "%" 'his-match-paren)

;; 可以不用选中一个区域，根据括号的匹配来确定缩进的区域。
(global-set-key (kbd "C-M-=") 'ywb-indent-accoding-to-paren)

;; 类似于 shell-command，在一个新的进程中运行命令。
(global-set-key (kbd "M-#") 'ywb-shell-command-background)


;; 在 emacs-wiki 上找到这个命令，可以用超级用户的身分修改文件。
(global-set-key (kbd "C-x C-r") 'find-file-root)

(global-set-key (kbd "M-g g") 'ywb-goto-line)



(global-set-key [(control ?\.)] 'ska-point-to-register)
(global-set-key [(control ?\,)] 'ska-jump-to-register)
(defun ska-point-to-register()
  "Store cursorposition _fast_ in a register.
Use ska-jump-to-register to jump back to the stored
position."
  (interactive)
  ;; (setq emacs-region-stays t)
  (point-to-register 8))

(defun ska-jump-to-register()
  "Switches between current cursorposition and position
that was stored with ska-point-to-register."
  (interactive)
  ;; (setq emacs-region-stays t)
  (let ((tmp (point-marker)))
        (jump-to-register 8)
        (set-register 8 tmp)))

  (add-hook 'view-mode-hook
               '(lambda ()
                  (define-key view-mode-map (kbd "SPC")
                              'scroll-up)
                  (define-key view-mode-map (kbd "<lwindow> SPC")
                              'scroll-down)
                  (define-key view-mode-map "j"
                              'next-line)
                  (define-key view-mode-map "k"
                              'previous-line)))

;; Windmove 是在窗口之间移动的很好用的命令。默认是用 Shift+上下左右键移动。
(require 'windmove nil t)
(when (featurep 'windmove)
  (global-set-key (kbd "C-c n") 'windmove-down)
  (global-set-key (kbd "C-c p") 'windmove-up)
  (global-set-key (kbd "C-c ,") 'windmove-left)
  (global-set-key (kbd "C-c .") 'windmove-right)
  (windmove-default-keybindings))


;; ido
; necessary support function for buffer burial
(defun crs-delete-these (delete-these from-this-list)
  "Delete DELETE-THESE FROM-THIS-LIST."
  (cond
   ((car delete-these)
    (if (member (car delete-these) from-this-list)
        (crs-delete-these (cdr delete-these) (delete (car delete-these)
                                                     from-this-list))
      (crs-delete-these (cdr delete-these) from-this-list)))
   (t from-this-list)))
                                        ; this is the list of buffers I never want to see
(defvar crs-hated-buffers
  '("KILL" "*Compile-Log*"))
                                        ; might as well use this for both
(setq iswitchb-buffer-ignore (append '("^ " "*Buffer") crs-hated-buffers))
(defun crs-hated-buffers ()
  "List of buffers I never want to see, converted from names to buffers."
  (delete nil
          (append
           (mapcar 'get-buffer crs-hated-buffers)
           (mapcar (lambda (this-buffer)
                     (if (string-match "^ " (buffer-name this-buffer))
                         this-buffer))
                   (buffer-list)))))
                                        ; I'm sick of switching buffers only to find KILL right in front of me
(defun crs-bury-buffer (&optional n)
  (interactive)
  (unless n
    (setq n 1))
  (let ((my-buffer-list (crs-delete-these (crs-hated-buffers)
                                          (buffer-list (selected-frame)))))
    (switch-to-buffer
     (if (< n 0)
         (nth (+ (length my-buffer-list) n)
              my-buffer-list)
       (bury-buffer)
       (nth n my-buffer-list)))))
(global-set-key [(control tab)] 'crs-bury-buffer)
(global-set-key [(control shift tab)] (lambda ()
                                       (interactive)
                                       (crs-bury-buffer -1)))
