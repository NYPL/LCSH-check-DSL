#!/usr/local/bin/lispscript
; vi: ft=lisp


« (DEFVAR *INPUT-FILE* Ø (CADR (CMDARGS)))
    OR DIE "NO INPUT FILE SUPPLIED" »


(DEFPARAMETER *HOLDER* (MAKE-HASH-TABLE :TEST #'EQUAL
                                        :SIZE 5499276))


(DEFCONSTANT +NUM-LINES+ 10395972)


(FOR-EACH-LINE *INPUT-FILE*
  (PROGRESS INDEX! +NUM-LINES+ :INTERVAL 100000)
  (IF (NULL (GETHASH VALUE! *HOLDER*))
    (SETF (GETHASH VALUE! *HOLDER*) 1)
    (INCF (GETHASH VALUE! *HOLDER*))))


; (WITH-A-FILE "count-dump.lisp" :w
;   (PRINT *HOLDER* STREAM!))

(WITH-A-FILE "counts.dat" :w
  (FOR-EACH-HASH *HOLDER*
    (FORMAT STREAM! "~D~C~S~%" VALUE! #\Tab KEY!)))


















; vi: ft=lisp
