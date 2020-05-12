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

(defun hamming-distance-by-key-length (input key-length) 
  (let*
      (
       (segment-1 (substring input 0 key-length))
       (segment-2 (substring input key-length (* 2 key-length)))
       ) 
    (hamming-distance segment-1 segment-2)
    )
  )

(defun guess-key-length (input min max)
  "Guess key length by finding hamming distances between different sized segments of cipher text"
  (let
      (
       (iterations (+ (- max min) 1))
       (result '())
       )
    (dotimes (i iterations result)
      (setq result
            (cons
             (cons (+ i min) (hamming-distance-by-key-length input (+ i min)))
             result))
      )
  )
  )

(defun normalize-score (item)
  (let*
      (
       (key-length (car item))
       (score (cdr item))
       (normalized-score (/ (float score) key-length))
       )
    (cons key-length normalized-score)
    )
  )

(defun normalize-key-guesses (input)
  "Use guess-key-length output to return alist of normalized guess score"
  (mapcar 'normalize-score input)
  )

(defun rank-normalized-key-guesses (input)
  (sort input (lambda (item-1 item-2) (< (cdr item-1) (cdr item-2)))))
