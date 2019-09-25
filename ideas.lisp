#!/usr/local/bin/lispscript



(defvar *RULES* nil)



(defmacro define-regex-rule (sym regex doc)
  `(progn (setf ,sym (re-compile ,regex)) (setf (get ',sym :doc) ,doc)
     (setf (get ',sym :regex) ,regex)     (push ',sym *RULES*)))

(define-condition bad-header (error)
  ((text :initarg :text :reader text)))



(load "rules.lisp")


(for-each "./test-files/test1"
  (let ((this-line        value!))
    (format t •~%~%this line is: "~A"~%• (cyan this-line))
    (handler-case
      (for-each *RULES*
        (let ((this-rule        (symbol-value value!))
              (this-regex       (get value! :regex)))
          (format t "checking rule: ~50A" value!)
          (if (~m this-line this-rule)
            ; (red "FAILED!")
            (error 'bad-header :text (format nil "violated rule ~A (~A)" value! this-regex))
            (format t "passed!~%"))))
      (bad-header () (format t "~A~%" (red "FAILED!"))))
    ))



