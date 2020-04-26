(load-file "./set-1/challenge-3.el")

(defun read-lines (filePath)
  "Return a list of lines of a file at filePath."
  (with-temp-buffer
    (insert-file-contents filePath)
    (split-string (buffer-string) "\n" t)))


(defun message-strings-from-lines (lines)
  (let
      (
       (result '())
       )
  (dolist (hex-string lines)

      (dotimes (i 256)
        (push (list (xor-hex-with-char hex-string i) i hex-string) result))
      )
  result
  )
)

;; (print (ranked-message-strings (message-strings-from-lines (read-lines "./assets/4.txt"))))

