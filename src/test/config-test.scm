(import (class org.junit Test))
(import (class org.junit Assert))
(import (plogger config))

(define-simple-class config-tests ()
  
  ((test-conf-dir) ::void (@Test)
   (let* ((db (db-connect))
          (meta-data (db:getMetaData)))
     (Assert:assertEquals "SQLite"
                          (meta-data:getDatabaseProductName)))))
