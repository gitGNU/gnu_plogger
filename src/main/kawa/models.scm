(define-library (plogger models)
  (import (kawa base))
  (export <org> <project>)
  (begin

    (define-simple-class <named> ()
      
      (name ::String)
      (alias ::String)

      ((*init* (name0 ::String) (alias0 ::String))
       (set! name name0)
       (set! alias alias0))
      
      ((get-name) name)
      ((get-alias) alias))

    (define-simple-class <org> (<named>)
      ((*init* (name0 ::String) (alias0 ::String))
       (invoke-special <named> (this) '*init* name0 alias0)))
    
    (define-simple-class <project> (<named>)
      
      (org ::<org>)
      
      ((*init* (name0 ::String) (alias0 ::String) (org0 ::<org>))
       (invoke-special <named> (this) '*init* name0 alias0)
       (set! org org0))
      
      ((get-org) org))

    

    ))
