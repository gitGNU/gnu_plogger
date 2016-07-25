(define-module (plogger task-types)
  :use-module (plogger validations)
  :use-module (dbi dbi)
  :export (new-task-type get-task-type-id select-task-types))

(define (select-task-types db)
  (dbi-query db "select * from task_types"))

(define new-task-type 
  (lambda (db title)
    (validate-string-length title 32)
    (dbi-query db 
	       (format #f "\
insert into task_types (title) values ('~a')" title))))

(define get-task-type-id
  (lambda (db title)
    (validate-string-length title 32)
    (dbi-query db 
	       (format #f "\
select id from task_types where title = '~a'" title))
    (cdr (assoc "id" (dbi-get_row db)))))
