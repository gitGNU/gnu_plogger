(define-library (plogger config)
  (import (scheme base))
  (export config-directory)
  (begin
    (define config-directory
      (string-append home-directory "/.plogger"))))