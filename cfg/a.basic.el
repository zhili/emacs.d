;; -*- coding: utf-8; -*-
  
;;set default mode to text-mode
(setq major-mode 'text-mode)

;;enable clipboard
(setq x-select-enable-clipboard t)


;;highlight selected region
(transient-mark-mode 1)

;;no tool bar
(tool-bar-mode -1)

;;no scroll bar
(scroll-bar-mode nil)

;;no menu
;; (menu-bar-mode -1)

;; ensure abbrev mode is always on
(setq-default abbrev-mode t)

;; save minibuffer history between sessions
(savehist-mode t)

(icomplete-mode 1)
;;y for yes，n for no
(fset 'yes-or-no-p 'y-or-n-p)

;;no warning bell
(setq visible-bell t)

;;no start message
(setq inhibit-startup-message t)

;;display column number
(setq column-number-mode t)

;;不要在鼠标点击的那个地方插入剪贴板内
(setq mouse-yank-at-point t)

;;用一个很大的 kill ring. 这样防止不小心删掉重要的东西
(setq kill-ring-max 200)

;;设置 sentence-end 可以识别中文标点
(setq sentence-end "\\([。！？]\\|……\\|[.?!][]\"')}]*\\($\\|[ \t]\\)\\)[ \t\n]*")

;;Use compressed files as if they were normal
(auto-compression-mode 1)

;;括号匹配时显示另外一边的括号，而不是烦人的跳到另一个括号。
;;(show-paren-mode t)
;;(setq show-paren-style 'parentheses)


;;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;;指针不闪，不恍花眼睛。
(blink-cursor-mode -1)

;; 没有提示音，也不闪屏。
(setq ring-bell-function 'ignore)

;;让 Emacs 可以直接打开和显示图片。
(auto-image-file-mode)

;;语法加亮
(global-font-lock-mode t)

;; fill 相关。
(auto-fill-mode t)
(setq fill-column 64)
(setq default-justification 'full)
(setq adaptive-fill-mode t)
(add-hook 'text-mode-hook 'auto-fill-mode)
(setq adaptive-fill-regexp "[ \t]+\\|[ \t]*\\([0-9]+\\.\\|\\*+\\)[ \t]*")
(setq adaptive-fill-first-line-regexp "^\\* *$")
(setq sentence-end-double-space nil)

;;设置有用的个人信息.这在许多地方有用。
(setq user-full-name "karpar Hu")
(setq user-mail-address "huzhili@gmail.com")


;; 防止不小心按到菜单中的 print 时，emacs 死掉
(fset 'print-buffer 'ignore)
(setq lpr-command "")
(setq printer-name "")

;;自动补全功能
(global-set-key [(meta ?/)] 'hippie-expand)
(setq hippie-expand-try-functions-list
      '(try-expand-line
        try-expand-dabbrev
        try-expand-line-all-buffers
        try-expand-list
        try-expand-list-all-buffers
        try-expand-dabbrev-visible
        try-expand-dabbrev-all-buffers
        try-expand-dabbrev-from-kill
        try-complete-file-name
        try-complete-file-name-partially
        try-complete-lisp-symbol
        try-complete-lisp-symbol-partially
        try-expand-whole-kill))

;; 不用 TAB 来缩进，只用空格。
(setq-default indent-tabs-mode nil)
(setq tab-width 8)
(setq tab-stop-list nil)


(setq-default ispell-program-name "aspell")
;(add-hook 'text-mode-hook 'flyspell-mode)

;; 标题格式化
(setq frame-title-format "GNU emacs %f")


;; 在屏幕边缘 3 行时就滚动
(setq scroll-margin 3
      scroll-conservatively 10000)

;; diary，calendar 的设置
(setq diary-file "~/.emacs.d/diary")
(add-hook 'initial-calendar-window-hook (lambda () (toggle-truncate-lines 1)))


;; 设置时间戳，标识出最后一次保存文件的时间。
;;(setq time-stamp-active t)
;;(setq time-stamp-warn-inactive t)
;;(setq time-stamp-format "%:y-%02m-%02d %3a %02H:%02M:%02S K.T")


(setq display-time-day-and-date t
      display-time-24hr-format t)
(display-time)


;;节日
;; (setq calendar-remove-frame-by-deleting t)
;; (setq calendar-week-start-day 1)

;; ;; Calendar 中 p C 可以看到我们的阴历有中文的天干地支。
;; (setq mark-diary-entries-in-calendar t)
;; (setq appt-issue-message nil)
;; (setq mark-holidays-in-calendar nil)
;; (setq view-calendar-holidays-initially nil)

;; (setq chinese-calendar-celestial-stem
;;       ["甲" "乙" "丙" "丁" "戊" "己" "庚" "辛" "壬" "癸"])
;; (setq chinese-calendar-terrestrial-branch
;;       ["子" "丑" "寅" "卯" "辰" "巳" "午" "未" "申" "酉" "戌" "亥"])

;;设置所在地的经纬度和地名，calendar 可以根据这些信息告知你每天的
;;日出和日落的时间。
;; (setq calendar-latitude +30.15)
;; (setq calendar-longitude +120.10)
;; (setq calendar-location-name "杭州")

;; 启动一些禁用的命令
(put 'scroll-left 'disabled nil)
(put 'set-goal-column 'disabled nil)
(put 'narrow-to-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(put 'downcase-region 'disabled nil)
(put 'LaTeX-hide-environment 'disabled nil)


;;bookmark
(setq bookmark-save-flag 1)

(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

;;在行首 C-k 时，同时删除该行
(setq-default kill-whole-line t)

(setq abbrev-file-name "~/.emacs.d/abbrev_defs")
;; 备份目录
(setq backup-directory-alist '(("." . "~/.emacs.d/backup")))
(setq backup-by-copying t)
;; 备份的版本控制
(setq version-control t)
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)
;;关闭自动保存
(setq auto-save-default nil)
;; WoMan 不打开新的 frame
(setq woman-use-own-frame nil)


;; do not bug me about saving my abbreviations
(setq save-abbrevs nil)

;; org-mode setting
;; Org-mode settings
;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; (global-set-key "\C-cl" 'org-store-link)
;; (global-set-key "\C-ca" 'org-agenda)
;; (global-font-lock-mode 1)

;; (add-to-list 'tooltip-frame-parameters (frame-parameter nil 'font))
(require 'ido) 
(ido-mode t) ; for buffers and files

;; setting frame size.
;; http://stackoverflow.com/questions/335487/programmatically-setting-emacs-frame-size
(add-to-list 'default-frame-alist '(left . 0))
(add-to-list 'default-frame-alist '(top . 0))
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 163))

;; tabbar
(when (require 'tabbar nil t)
   (setq tabbar-buffer-groups-function
     	(lambda () (list "All Buffers")))
   (setq tabbar-buffer-list-function
     	(lambda ()
     	  (remove-if
     	   (lambda(buffer)
     	     (find (aref (buffer-name buffer) 0) " *"))
     	   (buffer-list))))
   (tabbar-mode))

;; make buffer names unique even if the files have the same names
(require 'uniquify)
(setq uniquify-buffer-name-style 'forward)

