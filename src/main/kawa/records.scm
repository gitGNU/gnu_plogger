(define-library (plogger records)
  (import (scheme base))
  (export make-project project? project-id project-name
	  project->alist alist->project
	  make-task task? task-id task-name task-desc
	  task->alist alist->task)
  (begin

    ;; Project  
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
		    (cdr (assq 'project-name alist))))

    ;; Task
    (define-record-type task-record
      (make-task id name desc)
      task?
      (id task-id)
      (name task-name)
      (desc task-desc))
  
    (define (task->alist task)
      (list
       (cons 'task-id (task-id task))
       (cons 'task-name (task-name task))
       (cons 'task-desc (task-desc task))))
    
    (define (alist->task alist)
      (make-task (cdr (assq 'task-id alist))
		 (cdr (assq 'task-name alist))
		 (cdr (assq 'task-desc alist))))


))
