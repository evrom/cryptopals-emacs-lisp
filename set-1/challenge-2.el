(defun fixed-xor-byte (hex-1 hex-2)
  ;; due to emacs numer size restriction,
  ;; this function cannot use any length of a
  ;; hex string
  (let*
      (
       (bin-1 (string-to-number hex-1 16))
       (bin-2 (string-to-number hex-2 16))
       (bin-result (logxor bin-1 bin-2))
       (hex-result (format "%x" bin-result))
       )
    hex-result
    )
  )

(defun fixed-xor (hex-1 hex-2)
  (let
      (
       (iterations (/ (length hex-1) 2))
       (result "")
       )
    (dotimes (i iterations)
      (let*
          (
           (start (* i 2))
           (end (+ (* i 2) 2))
           (byte-1 (substring hex-1 start end))
           (byte-2 (substring hex-2 start end))
           (byte-result (fixed-xor-byte byte-1 byte-2))
           )
        (setq result (concat result byte-result)) 
        ))
    result
    ))
