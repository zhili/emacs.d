;; -*- coding: utf-8; -*-


(define-prefix-command 'lwindow-map)
(global-set-key (kbd "<lwindow>") 'lwindow-map)
(global-set-key (kbd "<lwindow> <up>") 'tabbar-backward-group)
(global-set-key (kbd "<lwindow> <down>") 'tabbar-forward-group)
(global-set-key (kbd "<lwindow> <left>") 'tabbar-backward)
(global-set-key (kbd "<lwindow> <right>") 'tabbar-forward)

;; 组内循环滚动tab
(setq tabbar-cycling-scope (quote tabs))



;;table可以“所见即所得”的编辑一个文本模式的表格
(autoload 'table-insert "table" "WYGIWYS table editor")


