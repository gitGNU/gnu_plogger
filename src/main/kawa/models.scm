(define-library (plogger models)
  (import (kawa base))
  (export <project>)
  (begin

    (define-simple-class <project> ()
      (name ::String)
      ((*init* (name0 ::String))
       (set! name name0))
      ((get-name) name))

))
