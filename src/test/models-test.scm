(import (class org.junit Test))
(import (class org.junit Assert))
(import (plogger models))



(define-simple-class models-tests ()

  ((test-org) ::void (@Test)
   
   (let* ((name "Taco Bell")
	  (alias "tb")
	  (org (<org> name alias)))
     
     (Assert:assertEquals name (org:get-name))
     (Assert:assertEquals alias (org:get-alias))
     (Assert:assertTrue (<org>? org))))
  
  ((test-project) ::void (@Test)
   
   (let* ((org-name "Taco Bell")
	  (org-alias "tb")
	  (name "SSO Integration")
	  (alias "tb-sso")
	  (project (<project> name alias (<org> org-name org-alias)))
	  (org ::<org> (project:get-org)))
     
     (Assert:assertEquals name (project:get-name))
     (Assert:assertEquals alias (project:get-alias))
     (Assert:assertEquals org-alias (org:get-alias))
     (Assert:assertTrue (<project>? project)))))
