(load-file "./set-1/helpers.el")

(defun int-to-bin-str (i)
  "convert an integer into it's binary representation in string format"
  (let ((result ""))
    (while (not (= i 0))
      (setq result (concat (if (= 1 (logand i 1)) "1" "0") result))
      (setq i (lsh i -1)))
    (if (string= result "")
        (setq result "0"))
    result))

(defun pad-bin-str (str)
  (concat (make-string (- 8 (length str)) ?0) str)
  )

(defun hamming-distance-byte (byte-1 byte-2)
  (let
      (
       (result 0)
       (bin-str-1 (pad-bin-str (int-to-bin-str byte-1)))
       (bin-str-2 (pad-bin-str (int-to-bin-str byte-2)))
       )
    (dotimes (i 8)
      (if (= (aref bin-str-1 i) (aref bin-str-2 i))
          nil
        (setq result (+ result 1))
        )
      )
    result
    ))

(defun hamming-distance (str-1 str-2)
  (let
      (
       (result 0)
       )
    (dotimes (i (length str-1))
      (setq result
            (+ result
               (hamming-distance-byte
                (aref str-1 i)
                (aref str-2 i)
                )
               )
            )
      )
    result
    )
  )

