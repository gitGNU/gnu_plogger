(define-library (plogger cmd)
  (import (scheme base) (scheme write)
	  (plogger config) (plogger records))
  (export hello-plogger)
  (begin
    (define (hello-plogger)
      (display (string-append "Configuration Directory: " (config-path))))))
