

(defun xor-hex-with-char (hex-string char)
  (let
      (
       (iterations (/ (length hex-string) 2))
       (result "")
       )
    (dotimes (i iterations)
      (let*
          (
           (start (* i 2))
           (end (+ (* i 2) 2))
           (hex-byte (substring hex-string start end))
           (decimal-byte (string-to-number hex-byte 16))
           (decimal-result (logxor decimal-byte char))
           (ascii-result (byte-to-string decimal-result))
           )
        (setq result (concat result ascii-result)) 
        ))
    result
    )
  )

(defun is-english-letter (character)
  "If the character is an english language character, return 1, otherwise 0"
  (if (and (>= character 65) (<= character 122))
      1 0
      ))

(defun message-rank (message)
  "Rank messages by number of english ascii letters"
  (let
      (
       (result 0)
       )
    (dotimes (i (length message))
      (setq result (+ result (is-english-letter (aref message i)))) 
      )
    result
    )
  )


(defun message-strings (hex-string)
  "Returns Association list of strings with decoded messages brute forced with an ascii char"
  (let
      (
       (result '())
       )
    (dotimes (i 256)
      (push (list (xor-hex-with-char hex-string i) i hex-string) result))
    result
    )
  )

(defun ranked-message-strings (message-string-list)
  "Sort list of messages strings by rank"
  (sort message-string-list
        (lambda
         (a b)
         (<
          (message-rank (car a))
          (message-rank (car b))
         )
         )
        )
  )
