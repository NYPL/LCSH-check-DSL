#!/usr/local/bin/lispscript
; vi: ft=lisp


« (DEFVAR *INPUT-FILE* Ø (CADR (CMDARGS)))
    or die "no input file supplied" »

(DEFVAR *CHECKS* NIL)

(DEFCLASS LCSH-CHECK ()
  ((doc :initarg :doc)))

(DEFCLASS REGEX-CHECK (lcsh-check)
  ((regex        :initarg :regex)
   (comp-regex   :initarg :comp-regex)))

(DEFMACRO DEFINE-REGEX-RULE (sym regex doc)
  `(PROGN (push (make-instance 'regex-check
                               :regex ,regex :comp-regex (re-compile ,regex)
                               :doc ,doc) *CHECKS*)))

(DEFINE-CONDITION bad-header (error)
  ((text :initarg :text :reader text)))

(DEFINE-CONDITION regex-rule-failure (bad-header)
  ((text :initarg :text :reader text)
   (line :initarg :line :reader line)))

(DEFMETHOD check-violation ((acheck REGEX-CHECK) aheader)
  (~m aheader { acheck 'comp-regex }))

(DEFMETHOD show-error ((anerror BAD-HEADER))
  (FT "~40S~A~%" (line anerror) (RED •violates rule "~A"• (text anerror))))



(LOAD "rules.lisp")


(FOR-EACH *INPUT-FILE*
  (LET ((this-line        value!))
    (fOR-EACH *CHECKS*
      (HANDLER-CASE
        (PROGN
          (WHEN (check-violation value! this-line)
            (ERROR 'regex-rule-failure
                   :text (FN "~A: m/~A/" { value! 'doc } { value! 'regex })
                   :line this-line)
            (FT "passed!~%")))
        (bad-header (error!) (show-error error!))))))



; vi: ft=lisp
