(defun int-byte-to-hex (byte)
  (if (< byte 16)
      (format "0%x" byte)
    (format "%x" byte)
      )
  )

(defun repeating-xor (text key)
  (let
      (
       (result "")
       (iterations (length text))
       (key-length (length key))
       )
    (dotimes (i iterations)
      (let*
          (
           (key-i (aref key (% i key-length)))
           (char (aref text i))
           (bin-result (logxor char key-i))
           (hex (int-byte-to-hex bin-result))
           )
        (setq result (concat result hex))
        )
      )
    result
    )
  )
