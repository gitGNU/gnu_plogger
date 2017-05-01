(define-library (plogger db)
  (import (class java.sql DriverManager)
          (kawa base)
          (plogger config)
          )
  (export *db* db-connect)
  (begin
    (define *db* (db-connect))
    (define (db-connect)
      (let* ((url (format "jdbc:sqlite:~A/plogger.db" *conf-dir*)))
        (java.lang.Class:forName "org.sqlite.JDBC")
        (DriverManager:getConnection url)))))
    
        
      
