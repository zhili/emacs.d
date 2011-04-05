;;; faces.el --- display style settings
;;
;; Guilherme Gondim (semente) <semente at taurinus.org>
;; http://bitbucket.org/semente/emacsd/
;; edit by huzhili at gmail.com
;; window system colors
;; (setq window-system-face-font "Monaco-12") 
;; (setq window-system-face-background "#272821")
;; (setq window-system-face-foreground "#F8F8F2")
;; (setq window-system-hl-line-face-background "gray10")
;; (setq window-system-highlight-changes-face-foreground nil)
;; (setq window-system-highlight-changes-face-background "#382f2f")
;; (setq window-system-highlight-changes-delete-face-foreground nil)
;; (setq window-system-highlight-changes-delete-face-background "#916868")
;; (setq window-system-highlight-changes-delete-face-underline nil)
;; (setq window-system-diff-added-face-foreground "spring green")
;; (setq window-system-diff-removed-face-foreground "tomato")

;; console colors
;; (setq console-face-background "black")
;; (setq console-face-foreground "white")
(setq console-diff-added-face-foreground "green")
(setq console-diff-removed-face-foreground "red")
(setq console-hl-line-face-background nil)

;; (defun set-window-system-faces ()
;;   (set-face-font       'default window-system-face-font (selected-frame))
;;   (set-face-background 'default window-system-face-background (selected-frame))
;;   (set-face-foreground 'default window-system-face-foreground (selected-frame))
;; )

(defun set-console-faces ()
  ;; (set-face-background 'default console-face-background (selected-frame))
  ;; (set-face-foreground 'default console-face-foreground (selected-frame))
  (set-face-foreground 'diff-added console-diff-added-face-foreground (selected-frame))
  (set-face-foreground 'diff-removed console-diff-removed-face-foreground (selected-frame))
  (set-face-background 'hl-line console-hl-line-face-background (selected-frame)))

(if window-system
;;     (set-window-system-faces)
    nil
   (set-console-faces))

(add-hook 'after-make-window-system-frame-hooks 'set-window-system-faces)
(add-hook 'after-make-console-frame-hooks 'set-console-faces)


;;; Cursor style:

(setq read-only-color "#4685aa")
(setq overwrite-color "#4685aa")
(setq normal-color    "#4685aa")

;; Valid values are t, nil, box, hollow, bar, (bar . WIDTH), hbar,
;; (hbar. HEIGHT); see the docs for cursor-type.
(setq read-only-cursor-type 'box)
(setq overwrite-cursor-type 'block)
(setq normal-cursor-type    'bar)

(defun set-cursor-according-to-mode ()
  "Change cursor color and type according to some minor modes."
  (cond
    (buffer-read-only
      (set-cursor-color read-only-color)
      (setq cursor-type read-only-cursor-type))
    (overwrite-mode
      (set-cursor-color overwrite-color)
      (setq cursor-type overwrite-cursor-type))
    (t
      (set-cursor-color normal-color)
      (setq cursor-type normal-cursor-type))))

(add-hook 'post-command-hook 'set-cursor-according-to-mode)
;;; faces.el ends here

;; http://jaguilar.posterous.com/i-get-so-tired-of-searching-fo
;; TextMate Monokai theme
(custom-set-faces
 '(default ((t (:stipple nil :background "#272822" :foreground "#F8F8F2" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 120 :width normal :family "monaco"))))
 '(cursor ((t (:background "#F8F8F2" :foreground "#272822"))))
 '(font-lock-comment-face ((((class color) (min-colors 88) (background dark)) (:foreground "#75715E"))))
 '(font-lock-function-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#A6E22E"))))
 '(font-lock-keyword-face ((((class color) (min-colors 88) (background dark)) (:foreground "#F92672"))))
 '(font-lock-preprocessor-face ((t (:inherit font-lock-builtin-face :foreground "#66d9ef"))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background dark)) (:foreground "#E6DB74"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background dark)) (:foreground "#66d9ef"))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background dark)) (:foreground "#FD971F"))))
 '(region ((((class color) (min-colors 88) (background dark)) (:background "#49483E"))))
 '(show-paren-match ((((class color) (background dark)) (:background "#3E3D32"))))
 '(variable-pitch ((t (:family "Monaco")))))