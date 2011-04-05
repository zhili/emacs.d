;; -*- coding: utf-8; -*-


;;;###autoload
(defun ywb-hippie-expand-filename ()
  (interactive)
  (let ((hippie-expand-try-functions-list
         '(try-complete-file-name try-complete-file-name-partially)))
    (call-interactively 'hippie-expand)))


;; 跳到匹配的括号处
;;;###autoload
(defun his-match-paren (arg)
  "Go to the matching paren if on a paren; otherwise insert %."
  (interactive "p")
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char))))
    (cond ((string-match "[[{(<]" next-char) (forward-sexp 1))
          ((string-match "[\]})>]" prev-char) (backward-sexp 1))
          (t (self-insert-command (or arg 1))))))

;;;###autoload
(defun wy-go-to-char (n char)
  "Move forward to Nth occurence of CHAR.
Typing `wy-go-to-char-key' again will move forwad to the next Nth
occurence of CHAR."
  (interactive "p\ncGo to char:")
  (search-forward (string char) nil nil n)
  (while (char-equal (read-char)
                     char)
    (search-forward (string char) nil nil n))
  (setq unread-command-events (list last-input-event)))




;; 按括号缩进一个区域
;;;autoload
(defun ywb-indent-accoding-to-paren ()
  "Indent the region between paren"
  (interactive)
  (let ((prev-char (char-to-string (preceding-char)))
        (next-char (char-to-string (following-char)))
        (pos (point)))
    (save-excursion
      (cond ((string-match "[[{(<]" next-char)
             (indent-region pos (progn (forward-sexp 1) (point)) nil))
            ((string-match "[\]})>]" prev-char)
             (indent-region (progn (backward-sexp 1) (point)) pos nil))))))






;;;###autoload
(defun ywb-shell-command-background (command &optional output-buffer)
  (interactive (list (read-from-minibuffer "Shell Command: " nil
                                           nil nil 'shell-command-history)
                     current-prefix-arg))
  (let ((buffer (or output-buffer
                    (get-buffer-create "*Shell Command Output*")))
        (directory default-directory))
    (with-current-buffer buffer
      (setq default-directory directory)
      (erase-buffer)
      (start-process-shell-command "shell" buffer command))
    (pop-to-buffer buffer t)))
;;;###autoload
(defun ywb-count-word-region ()
  (interactive)
  (let ((beg (point-min)) (end (point-max))
        (word 0) (other 0))
    (if mark-active
        (setq beg (region-beginning)
              end (region-end)))
    (save-excursion
      (goto-char beg)
      (while (< (point) end)
        (cond ((not (equal (car (syntax-after (point))) 2)) ; not a word
               (forward-char))
              ((< (char-after) 128)     ; is a english word
               (progn
                 (setq word (1+ word))
                 (forward-word)))
              (t
               (setq other (1+ other))
               (forward-char)))))
    (message "enlish word: %d\nother char: %d"
             word other)))

;; crazycool 的一个函数，显示 ascii 表
;;;###autoload
(defun ascii-table-show ()
  "Print the ascii table"
  (interactive)
  (with-current-buffer (switch-to-buffer "*ASCII table*")
    (setq buffer-read-only nil)
    (erase-buffer)
    (let ((i   0)
          (tmp 0))
      (insert (propertize
               "                                [ASCII table]\n\n"
               'face font-lock-comment-face))
      (while (< i 32)
        (dolist (tmp (list i (+ 32 i) (+ 64 i) (+ 96 i)))
          (insert (concat
                   (propertize (format "%3d " tmp)
                               'face font-lock-function-name-face)
                   (propertize (format "[%2x]" tmp)
                               'face font-lock-constant-face)
                   "    "
                   (propertize (format "%3s" (single-key-description tmp))
                               'face font-lock-string-face)
                   (unless (= tmp (+ 96 i))
                     (propertize " | " 'face font-lock-variable-name-face)))))
        (newline)
        (setq i (+ i 1)))
      (beginning-of-buffer))
    (toggle-read-only 1)))


;; 得到一个 tab 分开的表格的某几列
;;;###autoload
(defun ywb-get-column (start end)
  (interactive "r")
  (let ((cols (mapcar 'string-to-number
                      (split-string (read-from-minibuffer "cols(seperate by space): "))))
        line)
    (with-output-to-temp-buffer "*column*"
      (save-excursion
        (goto-char start)
        (while (< (point) end)
          (setq line (split-string (buffer-substring-no-properties (line-beginning-position)
                                                                   (line-end-position))
                                   "\t"))
          (princ (mapconcat 'identity (mapcar (lambda (c)
                                                (nth (1- c) line))
                                              cols) "\t"))
          (princ "\n")
          (forward-line 1))))))


;;;###autoload
(defun ywb-ibuffer-rename-buffer ()
  (interactive)
  (call-interactively 'ibuffer-update)
  (let* ((buf (ibuffer-current-buffer))
         (name (generate-new-buffer-name
                (read-from-minibuffer "Rename buffer(to new name): "
                                      (buffer-name buf)))))
    (with-current-buffer buf
      (rename-buffer name)))
  (call-interactively 'ibuffer-update))



;;;###autoload
(defun ywb-ibuffer-find-file ()
  (interactive)
  (let ((default-directory (let ((buf (ibuffer-current-buffer)))
			      (if (buffer-live-p buf)
				  (with-current-buffer buf
				    default-directory)
				default-directory))))
    (call-interactively 'ido-find-file)))




;;;###autoload
(defun ywb-sort-lines-1 (reverse beg end predicate)
  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (sort-subr reverse 'forward-line 'end-of-line nil nil
                 predicate))))
;;;###autoload
(defun ywb-org-table-sort-lines (reverse beg end numericp)
  (interactive "P\nr\nsSorting method: [n]=numeric [a]=alpha: ")
  (setq numericp (string-match "[nN]" numericp))
  (org-table-align)
  (save-excursion
    (setq beg (progn (goto-char beg) (line-beginning-position))
          end (progn (goto-char end) (line-end-position))))
  (let ((col (org-table-current-column))
        (cmp (if numericp
                 (lambda (a b) (< (string-to-number a)
                                  (string-to-number b)))
               'string<)))
    (ywb-sort-lines-1 reverse beg end
                      (lambda (pos1 pos2)
                        (let ((dat1 (split-string (buffer-substring-no-properties
                                                   (car pos1) (cdr pos1))
                                                  "\\s-*|\\s-*"))
                              (dat2 (split-string (buffer-substring-no-properties
                                                   (car pos2) (cdr pos2))
                                                  "\\s-*|\\s-*")))
                          (funcall cmp (nth col dat1) (nth col dat2)))))
    (dotimes (i col) (org-table-next-field))))

;;;###autoload
(defun ywb-html-preview-region (beg end)
  (interactive "r")
  (let ((file (make-temp-file "region-" nil ".html")))
    (write-region beg end file)
    (browse-url file)))
(defvar wcy-rotate-text-definations
  '(("[0-9]+" . (lambda (arg)
                  (format "%d" (+ arg (string-to-number (match-string 0))))))
    ("zero" "one" "two" "three" "four" "five" "six" "seven" "eight" "nine"))
  "
a list of ROT text defination. each element is a defination.
element can be a list of string.
element can be a cons. (REGEXP . func)
if REGEXP matched, func is called with no args, return value is the next value.
")

(defun wcy-rotate-text-aux (arg)
  (catch 'break
    (mapc
     #'(lambda (def)
         (let ((regexp (if (functionp (cdr def))
                           (car def)
                         (mapconcat 'regexp-quote def "\\|")))
               (func (if (functionp (cdr def))
                         (cdr def)
                       #'(lambda (arg)
                           (let* ((len (length def))
                                  (rest (member (match-string 0) def))
                                  (pos (- len (length rest))))
                             (format "%s" (nth (mod (+ pos arg) len) def)))))))
           (if (re-search-forward regexp (line-end-position) t nil)
               (throw 'break (funcall func arg)))))
     wcy-rotate-text-definations)
    nil))

(defun wcy-rotate-text(arg)
  (interactive "p")
  (save-excursion
    (let ((x (wcy-rotate-text-aux arg)))
      (if x (replace-match x)))))

;; sudo find file
(defvar find-file-root-prefix
  (if (featurep 'xemacs)
      "/[sudo/root@localhost]"
    "/sudo:root@localhost:" )
  "*The filename prefix used to open a file with `find-file-root'.")


(defvar find-file-root-history nil
  "History list for files found using `find-file-root'.")

(defvar find-file-root-hook nil
  "Normal hook for functions to run after finding a \"root\" file.")

(defun find-file-root ()
  "*Open a file as the root user.
   Prepends `find-file-root-prefix' to the selected file name so that it
   maybe accessed via the corresponding tramp method."
  (interactive)
  (require 'tramp)
  (let* ( ;; We bind the variable `file-name-history' locally so we can
         ;; use a separate history list for "root" files.
         (file-name-history find-file-root-history)
         (name (or buffer-file-name default-directory))
         (tramp (and (tramp-tramp-file-p name)
                     (tramp-dissect-file-name name)))
         path dir file)

    ;; If called from a "root" file, we need to fix up the path.
    (when tramp
      (setq path (tramp-file-name-path tramp)
            dir (file-name-directory path)))

    (when (setq file (read-file-name "Find file (UID = 0): " dir path))
      (find-file (concat find-file-root-prefix file))
      ;; If this all succeeded save our new history list.
      (setq find-file-root-history file-name-history)
      ;; allow some user customization
      (run-hooks 'find-file-root-hook))))




;; wcy-align-table 用于对齐表格
(defun split-string-with-separators (string &optional separators)
  (let ((rexp (or separators "[ \f\t\n\r\v]+")))
    (if (string-match rexp string)
        (let ((a (substring string 0 (match-beginning 0)))
              (b (match-string 0 string))
              (remain (substring string (match-end 0))))
          (cons a (cons b
                        (if (not (zerop (length remain)))
                            (split-string-with-separators remain rexp)))))
      (list string ))))
(defun wcy-align-table(beg end regexp prefix)
  (interactive "r\nsRegex:\np")
  (let ((string (replace-regexp-in-string "\\`\n*\\|\n*\\'" "" (delete-and-extract-region beg end)))
        alist columns)
    (setq regexp (concat "\\s-*" regexp "\\s-*"))
    (setq alist
          (mapcar
           (lambda (line)
             (mapcar 'wcy-align-table-trim-word
                     (split-string-with-separators line regexp)))
           (split-string string "\n")))
    (setq columns (wcy-align-table-calculate-column-width alist))
    (insert (mapconcat 'wcy-align-table-insert-line alist "\n"))))
(defun wcy-align-table-calculate-column-width(alist)
  (let* ((column (mapcar (lambda (a) (mapcar 'wcy-align-table-calculate-string-length a)) alist))
         results)
    (while column
      (setq results (wcy-align-table-calculate-column-width-1 results (car column)))
      (setq column (cdr column)))
    results))
(defun wcy-align-table-calculate-string-length ( string )
  (let ((length 0))
    (mapc (lambda (ch)
            (setq length (+ length
                            (cond
                             ((eq (char-charset ch) 'chinese-gb2312) 2)
                             (t 1)))))
          string)
    length))
(defun wcy-align-table-calculate-column-width-1(list1 list2)
  (let (results)
  (while (or list2 list1)
    (setq results (cons (max (or (car list1) 0)
                             (or (car list2) 0)) results))
    (setq list2 (cdr list2)
          list1 (cdr list1)))
  (nreverse results)))

(defun wcy-align-table-trim-word(words)
  (if (string-match "\\s-*\\(.*?\\)\\s-*\\'" words)
      (match-string 1 words)
    words))



(defun my-insert-date ()
  (interactive)
  (insert (format-time-string "%Y/%m/%d %H:%M:%S" (current-time))))




;;在没有选区的情况下c-w,m-w表示删除一行和复制一行
(defun my-kill-ring-save (&optional line)
  "This function is a enhancement of `kill-ring-save', which is normal used
to copy a region.  This function will do exactly as `kill-ring-save' if
there is a region selected when it is called. If there is no region, then do
copy lines as `yy' in vim."
  (interactive "P")
  (unless (or line (and mark-active (not (equal (mark) (point)))))
    (setq line 1))
  (if line
      (let ((beg (line-beginning-position))
            (end (line-end-position)))
        (when (>= line 2)
          (setq end (line-end-position line)))
        (when (<= line -2)
          (setq beg (line-beginning-position (+ line 2))))
        (if (and my-kill-ring-save-include-last-newline
                 (not (= end (point-max))))
            (setq end (1+ end)))
        (kill-ring-save beg end))
    (call-interactively 'kill-ring-save)))
;; set the following var to t if you like a newline to the end of copied text.
(setq my-kill-ring-save-include-last-newline nil)
;; bind it
(global-set-key [?\M-w] 'my-kill-ring-save)


(defun my-kill-region (&optional line)
  "This function is a enhancement of `kill-region', which is normal used to
kill a region to kill-ring.  This function will do exactly as `kill-region'
if there is a region selected when it is called. If there is no region, then
do kill lines as `dd' in vim."
  (interactive "P")
  (unless (or line (and mark-active (not (equal (mark) (point)))))
    (setq line 1))
  (if line
      (let ((beg (line-beginning-position))
            (end (line-end-position)))
        (when (>= line 2)
          (setq end (line-end-position line)))
        (when (<= line -2)
          (setq beg (line-beginning-position (+ line 2))))
        (if (and my-kill-region-include-last-newline
                 (not (= end (point-max))))
            (setq end (1+ end)))
        (kill-region beg end))
    (call-interactively 'kill-region)))
;; set the following var to t if you like a newline in the end of killed text.
(setq my-kill-region-include-last-newline t)
;; bind it
(global-set-key [?\C-w] 'my-kill-region)




(defun iwb ()
  "indent whole buffer"
  (interactive)
  (delete-trailing-whitespace)
  (indent-region (point-min) (point-max) nil)
  (untabify (point-min) (point-max)))

;; Convert to Dos or Unix
(defun convert-unix-to-dos ()
  (interactive)
  (set-buffer-file-coding-system 'undecided-dos))

(defun convert-dos-to-unix ()
  (interactive)
  (set-buffer-file-coding-system 'undecided-unix))

;;查看那些字符无法编码
(defun ywb-find-not-encodable-char ()
  (interactive)
  (let* ((from (point-min))
         (to (point-max))
         (codings (find-coding-systems-region from to))
         (unsafe (list buffer-file-coding-system))
         (rejected nil))
    (if (member (coding-system-base buffer-file-coding-system)
                codings)
        (message "Current coding system is work!")
      (setq unread-command-events (list ?\^G))
      (select-safe-coding-system-interactively
       from to codings unsafe rejected (car codings)))))


;;让一个宏只在 region 中运行,越界自动停止
(defun sams-apply-macro-on-region (start end command) ;[Jesper]
  "Evaluate a given function (or the last defined macro) on region.
I.e. it will continue until the point is position
outside the region.

This function is much like the function apply-macro-to-region-lines,
which is shipped with Emacs. It has one difference though. It
executes the macros until point is below the end of the region."
  (interactive "r\naCommand name (default:last keyboard macro).")
  (goto-char end)
  (let ((mark (point-marker)))
    (goto-char start)
    (while (< (point) (marker-position mark))
    (if (not (fboundp command))
        (call-last-kbd-macro)
      (command-execute command)))))




;;类似vim的c-y,c-e
;;;###autoload
(defun my-insert-char-next-line (arg)
  "insert char below the cursor"
  (interactive "p")
  (let ((col (current-column))
        char)
    (setq char
          (save-excursion
            (forward-line arg)
            (move-to-column col)
            (if (= (current-column) col)
                (char-after))))
    (if char
        (insert-char char 1)
      (message (concat "Can't get charactor in "
                       (if  (< arg 0)
                           "previous"
                         "next")
                       (progn (setq arg (abs arg))
                              (if (= arg 1) ""
                                (concat " " (number-to-string arg))))
                       " line.")))))

;;;###autoload
(defun my-insert-char-prev-line (arg)
  "insert char above the cursor"
  (interactive "p")
  (my-insert-char-next-line (- arg)))


;;查找选定区域的内容
(defvar my-isearch-string nil)
(setq my-isearch-string "")

(defun my-isearch-region-forward ()
  "isearch region if mark is acktive"
  (interactive)
  (if mark-active
      (let ((beg (region-beginning))
            (end (region-end)))
        (setq my-isearch-string (filter-buffer-substring beg end nil))
        (deactivate-mark)
        (if (> (length my-isearch-string) 0)
            (progn
              (goto-char beg)
              (isearch-update-ring my-isearch-string)
              (add-hook 'isearch-mode-end-hook 'my-isearch-end-hook)
              (isearch-mode t)          ;hack isearch-forward
              (isearch-repeat 'forward)
              (message "%s" isearch-string)))) ;print debug msg
    (if (> (length my-isearch-string) 0)
        (progn
          (isearch-repeat 'forward))
      (message "no region selected")
      )))
(defun my-isearch-end-hook ()
  (remove-hook 'isearch-mode-end-hook 'my-isearch-end-hook)
  (setq my-isearch-string ""))

;;类似vim的*
(defvar my-isearch-word "")

(defun my-isearch-word ()
  (interactive)
  (when (not mark-active)
    (let (word-beg word-end)
      (unless (looking-at "\\<")
        (if (eq (char-syntax (char-after)) ?w)
            (backward-word)
          (and (forward-word) (backward-word)))
        )
      (setq word-beg (point))
      (forward-word)
      (setq word-end (point))
      (setq my-isearch-word (filter-buffer-substring word-beg word-end nil t))
      (backward-word)
      )
    (when (> (length my-isearch-word) 0)
      (setq my-isearch-word (concat "\\<" my-isearch-word "\\>"))
      (isearch-update-ring my-isearch-word t)
      (add-hook 'isearch-mode-end-hook 'my-isearch-word-end-hook)
      (isearch-mode t t)
      (isearch-repeat 'forward)
      (message "%s" isearch-string))))

(global-set-key (kbd "C-*") 'my-isearch-word)

(defun my-isearch-word-end-hook ()
  (remove-hook 'isearch-mode-end-hook 'my-isearch-word-end-hook)
  (setq my-isearch-word ""))

(defun huangq-unfill-paragraph ()
  (interactive)
  (let ((fillcol fill-column))
    (setq fill-column 9999)
    (call-interactively 'fill-paragraph)
    (setq fill-column fillcol)))

;;自动转义字符串
(defun ywb-quote-region (beg end)
  "Stringfy text in region, `yank' to see it."
  (interactive "r")
  (kill-new (format "%S" (buffer-substring-no-properties beg end)) nil))

;;; Many thanks TO ilovecpp
(defvar switch-major-mode-last-mode nil)
(make-variable-buffer-local 'switch-major-mode-last-mode)

(defun major-mode-heuristic (symbol)
  (and (fboundp symbol)
       (string-match ".*-mode$" (symbol-name symbol))))

(defun switch-major-mode (mode)
  (interactive
   (let ((fn switch-major-mode-last-mode)
         val)
     (setq val
           (completing-read
            (if fn
                (format "Switch major mode to (default %s): " fn)
              "Switch major mode to: ")
            obarray 'major-mode-heuristic t nil nil (symbol-name fn)))
     (list (intern val))))
  (let ((last-mode major-mode))
    (funcall mode)
    (setq switch-major-mode-last-mode last-mode)))
(global-set-key (kbd "C-c m") 'switch-major-mode)

