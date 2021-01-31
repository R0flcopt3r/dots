;;; ../Git/dots/emacs_doom/irc.el -*- lexical-binding: t; -*-

;; Buffer for inserting irc notifications
(defvar irc/notification-buffer "*irc-notifications*")

;; shitposting
(defun irc/shrug ()
  "adds shrug to current text"
  (interactive)
  (insert "¯\\_(ツ)_/¯"))

(defun irc/lenny ()
  "adds lenny to current text"
  (interactive)
  (insert "( ͡° ͜ʖ ͡°)"))

(defun irc/int (word)
  "Insensifies script"
  (interactive "sWhat: ")
  (insert
   (format "4%s INTENSIFIES" (upcase
                                            word))))
(defun irc/rainbow-region (begin end)
  "formats the selected region of text in rainbow colors"
  (interactive "r")
  (save-restriction
    (narrow-to-region begin end)
    (let ((current (point-min))
          (end (point-max))
          (colors '#1=(13 12 11 9 8 7 4 . #1#)))
      (while (< current end)
        (goto-char current)
        (let ((num (car colors)))
          (insert (concat "" (number-to-string num)))
          (let ((step (cond ((> num 9) 3)
                            (t 2))))
            (setq current (+ current 1 step)
                  end     (+ end step)
                  colors  ( cdr colors))))))
    (remove-text-properties (point-min) (point-max) '(personality))))

(defun irc/uml-reformat-region (begin end)
  (interactive "r")
  (save-restriction
    (narrow-to-region begin end)
    (goto-char (point-min))
    (let ((current (point-min)))
      (while (< current (point-max))
        (forward-char)
        (insert "̈")
        (setq current (1+ current))))
    (remove-text-properties (point-min) (point-max) '(personality))))

(defun irc/hue (word)
  "Laughing script for keks"
  (interactive "sLaugh in: ")
  (setq word (replace-regexp-in-string "\n" "" word))
  (let* ((color1 (concat "" (number-to-string (+ 2 (random 5)))))
         (color2 (concat "" (number-to-string (+ 5 (random 2)))))
         (color3 (concat "" (number-to-string (+ 5 (random 7)))))
         (color4 (concat "" (number-to-string (+ 9 (random 7)))))
         (color5 (concat "" (number-to-string (+ 2 (random 8)))))
         (text (apply 'concat
                      (cons ""
                            (mapcar (lambda (c) (concat (char-to-string c) ""))
                                    (string-to-list word)))))
         (cutting-point  (random (length text)))
         (right-part (substring text cutting-point))
         (left-atom (substring text 0 cutting-point))

         (right-atom (apply 'concat (make-list (+ 1 (random 4))
                                               right-part))))
    (insert
     (concat
      left-atom color1 right-atom
      left-atom color2 right-atom
      left-atom color3 right-atom
      left-atom color4 right-atom
      left-atom color5 right-atom))))

(defun irc/fw-reformat-region (begin end)
  (interactive "r")
  (save-restriction
    (narrow-to-region begin end)
    (dolist (c (number-sequence 33 126))
      (goto-char (point-min))
      (while (search-forward (char-to-string c) nil t)
        (replace-match (char-to-string (+ c 65248)) nil t)))
    (remove-text-properties (point-min) (point-max) '(personality))))


(defun irc/highlight-buffer (NICK BODY CHANNEL)
  "append notification to buffer"
  (with-current-buffer
      (get-buffer-create irc/notification-buffer)
    (insert (format "%15.15s -- %10.10s | %s\n"
                    CHANNEL NICK BODY ))))
