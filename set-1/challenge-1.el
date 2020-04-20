(defun six-hex-to-four-b64 (six-hex)
  (let*
      ((b64 "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/")
       (padded-hex
        (concat (make-string
                 (- 6 (length six-hex)) ?0) six-hex))
       (number (string-to-number padded-hex 16))
       (byte-array
        (vector
         (lsh number -18)
         (logand (lsh number -12 ) 63)
         (logand (lsh number -6) 63)
         (logand number 63)
         ))
       (chars (string
               (aref b64 (aref byte-array 0))
               (aref b64 (aref byte-array 1))
               (if (< (length six-hex) 4) ?= (aref b64 (aref byte-array 2)))
               (if (< (length six-hex) 6) ?= (aref b64 (aref byte-array 3)))
               ))
       )
    chars
    ))

(defun hex-to-b64 (input)
  (let
      (
       (iterations (ceiling (/ (length input) 6)))
       (result "")
       )
    (dotimes (i iterations)
      (let*
          (
           (start (* i 6))
           (end (min (+ start 6) (length input)))
           (six-hex (substring input start end))
           (four-b64 (six-hex-to-four-b64 six-hex))
           )
        (setq result (concat result four-b64))))
    result))

