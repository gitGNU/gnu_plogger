(define-library (plogger db)
  (import (scheme base)
          (plogger config)
          (class java.sql DriverManager))
  (export *db*)
  (begin
    (define *db* (connect-db))
    (define (connect-db)
      (let* ((url (format "jdbc:sqlite:~a/plogger.db" *config-directory*)))
        (java.lang.Class:forName "org.sqlite.JDBC")
        (DriverManager:getConnection url)))))
    
        
      
