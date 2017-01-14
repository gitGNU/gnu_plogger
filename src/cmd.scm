(define-library (plogger cmd)
  (import (scheme base) (scheme write))
  (export hello-plogger)
  (begin
    (define (hello-plogger)
      (display "Hello Plogger"))))
