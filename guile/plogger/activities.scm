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

(define-module (plogger activities)
  :use-module (plogger validations)
  :use-module (plogger phases)
  :use-module (plogger tasks)
  :use-module (plogger times)
  :use-module (dbi dbi)
  :export (current-activity get-current-activity-id start-activity 
           end-activity))

(define current-activity
 (lambda (db)
   (dbi-query db "select id from activities where end_time is null")
   (let ((activity-id (dbi-get_row db)))
	 (if activity-id
		 #t
		 #f))))

(define get-current-activity-id
 (lambda (db)
   (dbi-query db "select id from activities where end_time is null")
   (let ((activity-id (dbi-get_row db)))
	 (if activity-id
		 (cdr (assoc "id" activity-id))
		 #f))))

(define insert-activity
  (lambda (db task phase project)
    (validate-string-length task 32)
    (validate-string-length phase 32)
    (validate-string-length project 32)
    (let ((phase-id (get-phase-id db phase))
		  ;(rc-port (open-file rc-file "w"))
		  (task-id (get-task-id db task project)))
      (dbi-query 
       db 
       (format #f 
			   "insert into activities (task_id, phase_id) values ('~d', ~d)"
			   task-id phase-id))
	  ;(assoc-set! rc "current-activity" ))))
)))

(define get-task-id-from-activity-id
  (lambda (db activity-id)
    (dbi-query db (format #f "select task_id from activities where id = ~d" 
			  activity-id))
    (cdr (assoc "task_id" (dbi-get_row db)))))

(define update-activity-end-time-and-comment
  (lambda (db activity-id time-string comment)
    (dbi-query 
     db (format 
	 #f (string-append "update activities set end_time = '~a', "
			   "comment = '~a' where id = ~d" )
	 time-string comment activity-id))))

(define start-activity
  (lambda (db task phase project)
	(if (not (current-activity db))
		(insert-activity db task phase project)
		(throw 'exist-activity))))

(define end-activity
  (lambda (db task-progress comment)
	(let ((activity-id (get-current-activity-id db)))
	  (if activity-id
	      (begin
		(let ((time-string (current-utc-time)))
		  (update-activity-end-time-and-comment 
		   db activity-id time-string comment))
		(let ((task-id (get-task-id-from-activity-id db activity-id)))
		  (update-task-progress db task-id task-progress)
		  ))
	      (throw 'no-activity)))))
