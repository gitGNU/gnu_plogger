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
  :use-module (plogger config)
  :export (db-list-result
	   save-unit get-unit-id all-units
	   init-db db-open db-close))

(define init-db 
  (lambda (db-obj)
    (let ( (tables '("\
create table projects (
       id integer primary key, 
       project varchar(32) unique
);"

"create table tasks (
       id integer primary key,
       description varchar(200),
       progress decimal(3,2) default 0.0,
       project_id integer,
       foreign key(project_id) references projects(id)
);"

"create table tag_groups (
       id integer primary key, 
       tag_group varchar(32) unique
);"

"create table tags (
       id integer primary key,
       tag varchar(32) unique,
       tag_group_id integer,
       foreign key(tag_group_id) references tag_groups(id)
);"

"create table task_has_tags (
       task_id integer,
       tag_id integer,
       foreign key(task_id) references tasks(id),
       foreign key(tag_id) references tags(id)
);"

"create table remote_systems (
       id integer primary key,
       \"name\" varchar(32),
       url varchar(255)
);"

"create table remote_task_ids (
       id varchar(32) primary key,
       task_id integer,
       remote_system_id integer not null,
       foreign key(task_id) references tasks(id),
       foreign key(remote_system_id) references remote_systems(id)
);"

"create table units (
       id integer primary key,
       singular varchar(32) unique,
       plural varchar(36) unique
);"

"create table task_has_units (
       task_id integer not null,
       unit_id integer not null,
       quantity integer,
       foreign key (task_id) references tasks(id),
       foreign key (unit_id) references units(id)
);"

"create table activities (
       id integer primary key,
       start_time timestamp default current_timestamp,
       end_time timestamp,
       comment varchar(1024),
       task_id integer,
       foreign key(task_id) references tasks(id)
);")))
      (for-each (lambda (query)
		  (dbi-query db-obj query)
		  (if (not (eq? (car (dbi-get_status db-obj)) 0))
		      (throw 'db-initialization-error))) tables))))


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



;(define init-db 
;  (lambda (db-obj init-sql-file)
;    (let ( (query (read-delimited ";" init-sql-file)) )
;      (if (not (eof-object? query))
;	  (begin
;	    ;; TODO add logic to handle database errors.
;	    ;(display query)(newline)
;	    (dbi-query db-obj query)
;	    ;(display db-obj)(newline)
;	    (init-db db-obj init-sql-file))))))

;(define (valid-query? query)
;  (

(define db-open 
  (lambda () (dbi-open "sqlite3" *db-path*)))

(define db-close
  (lambda (db)
    (dbi-close db)))

