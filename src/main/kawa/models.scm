(define-library (plogger models)
  (import (kawa base))
  (export <org> <project>)
  (begin

    (define-simple-class <named> ()
      
      (name ::String)
      (alias ::String)

      ((*init*) #!void)
      
      ((*init* (name0 ::String) (alias0 ::String))
       (set! name name0)
       (set! alias alias0))
      
      ((get-name) name)
      ((get-alias) alias)
      
      )

    (define-simple-class <org> (<named>))
    
    (define-simple-class <project> ()
      
      (name ::String)
      (alias ::String)
      (org ::<org>)
      
      ((*init* (name0 ::String) (alias0 ::String) (org0 ::<org>))
       (set! name name0)
       (set! alias alias0)
       (set! org org0))
      
      ((get-name) name)
      ((get-alias) alias)
      ((get-org) org)
      
      )

))
