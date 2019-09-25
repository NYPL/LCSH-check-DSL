#!/usr/local/bin/lispscript



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

; make red a macro!!
(DEFMETHOD show-error ((anerror BAD-HEADER))
  (ft "~40S~A~%" (line anerror) (red •violates rule "~A"• (text anerror))))



(LOAD "rules.lisp")


(for-each "./test-files/test1"
  (let ((this-line        value!))
    (for-each *CHECKS*
      (handler-case
        (progn
          (when (check-violation value! this-line)
            (error 'regex-rule-failure
                   :text (fn "~A: m/~A/" { value! 'doc } { value! 'regex })
                   :line this-line)
            (ft "passed!~%")))
        (bad-header (error!) (show-error error!))))))


