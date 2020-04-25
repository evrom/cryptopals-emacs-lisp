;; run with emacs -batch -l ert -l test-set-1.el -f ert-run-tests-batch-and-exit
(defun load-directory (dir)
  (let ((load-it (lambda (f)
                   (load-file (concat (file-name-as-directory dir) f)))
                 ))
    (mapc load-it (directory-files dir nil "\\.el$"))))
(load-directory "./set-1")
(ert-deftest challenge-1 ()
  (should (string= (hex-to-b64
              "49276d206b696c6c696e6720796f757220627261696e206c696b65206120706f69736f6e6f7573206d757368726f6f6d"
              )
             "SSdtIGtpbGxpbmcgeW91ciBicmFpbiBsaWtlIGEgcG9pc29ub3VzIG11c2hyb29t"
             )))

(ert-deftest challenge-2 ()
  (should
   (string=
    (fixed-xor
     "1c0111001f010100061a024b53535009181c"
     "686974207468652062756c6c277320657965"
     )
    "746865206b696420646f6e277420706c6179"
    )))

;; Challenge 3 helper functions
(ert-deftest xor-hex-with-char ()
  (should (equal (xor-hex-with-char "03" 65) "B"))
  (should (equal (xor-hex-with-char "03" ?A) "B"))
  )
(ert-deftest is-english-letter ()
  (should (= (is-english-letter ?A) 1))
  (should (= (is-english-letter ?1) 0))
  )
(ert-deftest message-rank ()
  (should (= (message-rank "Hi") 2))
  (should (= (message-rank "!@") 0))
  )

(ert-deftest challenge-3 ()
  (should
    (member "Cooking MC's like a pound of bacon"
     (mapcar 'car (message-strings
      "1b37373331363f78151b7f2b783431333d78397828372d363c78373e783a393b3736"))
     )
    )
)
