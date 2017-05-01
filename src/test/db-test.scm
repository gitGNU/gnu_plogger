(import (class org.junit Test))
(import (class org.junit Assert))
(import (plogger db))

(define-simple-class db-tests ()
  
  ((test-db-connect) ::void (@Test)
   (let* ((conn (db-connect))
          (meta-data (conn:getMetaData)))
     (Assert:assertEquals "SQLite"
                          (meta-data:getDatabaseProductName)))))
