
# LCSH-check-DSL


An experimental approach to defining a domain specific language
for checking and correcting (cleaning)
Library of Congress Subject Headings

Rules are defined in the file `rules.lisp`
Here are examples

```
(define-regex-rule  *no-trailing*         •\s+$•      "no trailing whitespace")
(define-regex-rule  *no-leading*          •^\s+•      "no leading whitespace")
(define-regex-rule  *no-blank*            •^$•        "no blank lines")
(define-regex-rule  *no-leading-digits*   •^\d{4}•    "no large amount of leading digits")
```

Test it by running `./run-checks.lisp test/test1`


(this is a stub for now)


