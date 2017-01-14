(define-library (plogger records)
  (import (scheme base))
  (export make-project project? project-id project-name
	  project->alist alist->project)
  (begin
    
    (define-record-type project-record
      (make-project id name)
      project?
      (id project-id)
      (name project-name))
  
    (define (project->alist project)
      (list
       (cons 'project-id (project-id project))
       (cons 'project-name (project-name project))))
    
    (define (alist->project alist)
      (make-project (cdr (assq 'project-id alist))
		    (cdr (assq 'project-name alist))))))


