(load-file "./set-1/challenge-3.el")
(load-file "./set-1/helpers.el")



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

