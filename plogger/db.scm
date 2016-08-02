;; Plogger - Time tracking software
;; Copyright (C) 2010 Romel Raul Sandoval Palomo
;;
;; This program is free software; you can redistribute it and/or    
;; modify it under the terms of the GNU General Public License as   
;; published by the Free Software Foundation; either version 3 of   
;; the License, or (at your option) any later version.              
;;                                                                  
;; This program is distributed in the hope that it will be useful,  
;; but WITHOUT ANY WARRANTY; without even the implied warranty of   
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the    
;; GNU General Public License for more details.                     
;;                                                                  
;; You should have received a copy of the GNU General Public License
;; along with this program; if not, contact:
;;
;; Free Software Foundation           Voice:  +1-617-542-5942
;; 59 Temple Place - Suite 330        Fax:    +1-617-542-2652
;; Boston, MA  02111-1307,  USA       gnu@gnu.org

(define-module (plogger db)
  :use-module (dbi dbi)
  :use-module (plogger models)
  :use-module (plogger text)
  :export (db-list-result
	   save-unit get-unit-id all-units))

(define (all-units db)
  (dbi-query db "select * from units"))

(define save-unit 
  (lambda (db unit)
    (dbi-query db (format #f "\
insert into units (singular, plural) values ('~a', '~a')"
			  (unit-singular unit) (unit-plural unit)))))

(define get-project-id
  (lambda (db name)
    (validate-string-length name 32)
    (dbi-query db 
	       (format #f "select id from projects where name = '~a'" name))
    (cdr (assoc "id" (dbi-get_row db)))))

					

(define (get-tag-ids db tags)
  (let* ((tags-vales (list->values (string-split tags #\,)))
	 (tag-ids (dbi-query db (format #f "\
select id from tags where tag in (~a)" tags-values))))
	 ;;(tag-id-values (alist->values tag-ids)))
    tag-ids))

(define (save-task-tags db tag-ids)
  (let* ((task-id (cadr (dbi-query db "select last_insert_rowid()"))))
    (for-each (lambda (tag-id)
		(dbi-query db (format #f "\
insert into task-has-tag (task_id, tag_id) values (~d, ~d)"
				      task-id tag-id))) tag-ids)))

(define (save-task db task)
  (let ((project-id (get-project-id db (task-project task)))
	(tag-ids (get-tag-ids db (task-tags task))))
      (dbi-query 
       db 
       (format #f "\
insert into tasks (description, project_id) values ('~a', ~d)" 
	       name project-id))
      (save-task-tags db tag-ids)))


(define (db-list-result-r db list-result)
  (let ((result (dbi-get_row db)))
    (if result
	(db-list-result-r db (append list-result (list result)))
	list-result)))

(define (db-list-result db)
  (db-list-result-r db '()))

