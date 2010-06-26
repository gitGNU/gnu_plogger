(define-module (plogger issue-types)
  :use-module (plogger validations)
  :use-module (dbi dbi)
  :export (new-issue-type get-issue-type-id select-issue-types))

(define (select-issue-types db)
  (dbi-query db "select * from issue_types"))

(define new-issue-type 
  (lambda (db title)
    (validate-string-length title 32)
    (dbi-query db 
	       (format #f "\
insert into issue_types (title) values ('~a')" title))))

(define get-issue-type-id
  (lambda (db title)
    (validate-string-length title 32)
    (dbi-query db 
	       (format #f "\
select id from issue_types where title = '~a'" title))
    (cdr (assoc "id" (dbi-get_row db)))))
