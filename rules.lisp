

(define-regex-rule  *no-trailing*         •\s+$•      "no trailing whitespace")
(define-regex-rule  *no-leading*          •^\s+•      "no leading whitespace")
(define-regex-rule  *no-blank*            •^$•        "no blank lines")
(define-regex-rule  *no-leading-digits*   •^\d{4}•    "no large amount of leading digits")

