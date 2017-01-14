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

(define-module (plogger interruptions)
  :use-module (plogger validations)
  :use-module (plogger activities)
  :use-module (plogger times)
  :use-module (dbi dbi)
  :export (start-interruption end-interruption))

(define insert-interruption
  (lambda (db activity-id)
	(dbi-query 
	 db 
	 (format #f 
		 "insert into interruptions (activity_id) values (~d)"
		 activity-id))))

(define update-interruption-end-time
  (lambda (db interruption-id time-string comment)
	(dbi-query 
	 db 
	 (format 
	  #f 
	  (string-append "update interruptions set end_time = '~a', "
			 "comment = '~a' where id = ~d")
	  time-string comment interruption-id))))

(define get-current-interruption
 (lambda (db)
   (dbi-query db "select id from interruptions where end_time is null")
   (let ((interruption-id (dbi-get_row db)))
     (if interruption-id
	 (cdr (assoc "id" interruption-id))
	 #f))))

(define end-interruption
  (lambda (db comment)
    (validate-string-length comment 1024)
    (let ((interruption-id (get-current-interruption db)))
      (if interruption-id
	  (let ((time-string (current-utc-time)))
	    (update-interruption-end-time 
	     db interruption-id time-string comment))
	  (throw 'no-interruption)))))

(define start-interruption
  (lambda (db)
	(let ((activity-id (get-current-activity-id db)))
	  (if activity-id
	      (let ((interruption-id (get-current-interruption db)))
		(if (not interruption-id)
		    (insert-interruption db activity-id)
		    (throw 'exist-interruption)))
	      (throw 'no-activity)))))
