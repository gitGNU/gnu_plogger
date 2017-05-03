(import (class org.junit Test))
(import (class org.junit Assert))
(import (plogger models))

(define-simple-class models-tests ()
  
  ((test-project) ::void (@Test)
   (let* ((name "Taco Bell")
	  (alias "tb")
	  (project (<project> name)))
     
     (Assert:assertEquals name (project:get-name))
     (Assert:assertTrue (<project>? project))
     (Assert:assertEquals alias (project:get-alias)))))
