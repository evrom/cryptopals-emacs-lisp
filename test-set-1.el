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

;; challenge 4 is the same as challenge 3, but with a file. Therefore no tests

(ert-deftest challenge-5 ()
  (should (equal (repeating-xor
           "Burning 'em, if you ain't quick and nimble
I go crazy when I hear a cymbal"
           "ICE")
           "0b3637272a2b2e63622c2e69692a23693a2a3c6324202d623d63343c2a26226324272765272a282b2f20430a652e2c652a3124333a653e2b2027630c692b20283165286326302e27282f"))
  )

;; challenge 5 helper functions

(ert-deftest hamming-distance ()
  (should (= (hamming-distance "this is a test" "wokka wokka!!!") 37))
  )

(ert-deftest hamming-distance-by-key-length ()
  (should (= (hamming-distance-by-key-length "this is a testwokka wokka!!!" 14) 37))
  )

(ert-deftest guess-key-length ()
  (print (guess-key-length (base64-decode-string "HUIfTQsPAh9PE048GmllH0kcDk4TAQsHThsBFkU2AB4BSWQgVB0dQzNTTmVS
BgBHVBwNRU0HBAxTEjwMHghJGgkRTxRMIRpHKwAFHUdZEQQJAGQmB1MANxYG") 2 40))
  )

(ert-deftest normalize-score ()
  (should (= (cdr (normalize-score '(4 . 20))) 5))
  )

(ert-deftest blocks-from-ciphertext ()
  (should (equal
           (blocks-from-ciphertext "aabaabaaaaaaaaaaaaa" 3)
           [(1 97 97 97 97 97 97 97)
            (1 97 97 97 97 97 97)
            (1 98 98 97 97 97 97)]
           ))
  )
