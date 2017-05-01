(import (class org.junit Test))
(import (class org.junit Assert))
(import (plogger config))

(define-simple-class config-tests ()
  
  ((test-conf-dir) ::void (@Test)
   (let* ((path (config-path))
          (home (java.lang.System:get-property "user.home"))
          (expected-path (string-append home "/.plogger")))
     (Assert:assertEquals expected-path path))))
