(import (class org.junit Test))
(import (class org.junit Assert))
(import (plogger db))

(define-simple-class db-tests ()
  
  ((test-db) ::void (@Test)
   (let* ((db (db-connect))
          (meta-data (db:getMetaData)))
     (Assert:assertEquals "SQLite"
                          (meta-data:getDatabaseProductName)))))
