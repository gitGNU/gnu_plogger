;; Plogger - Time tracking software
;; Copyright (C) 2010 Romel Raúl Sandoval-Palomo
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

(define-module (plogger commands)
  :use-module (plogger projects)
  :use-module (plogger task-types)
  :use-module (plogger tasks)
  :use-module (plogger phases)
  :use-module (plogger activities)
  :use-module (plogger interruptions)
  :use-module (plogger config)
  :use-module (plogger rdb)
  :use-module (plogger text)
  :use-module (ice-9 getopt-long)
  :use-module (dbi dbi)
  :export (add-project show-projects add-task-type show-task-types 
           add-task show-tasks add-phase show-phases 
		   start end interrupt continue query))

(define (query options arg)
  (let ((db (db-open)))
    (dbi-query db arg)
    (let ((status (cdr (dbi-get_status db)))
	  (result (db-list-result db)))
      (if (not (null? result))
	  (alists->table result)
	  (begin (display status)(newline))))))

(define (add-project options arg)
  (let ((db (db-open)))
    (new-project db (option-ref options 'project #f))
    (db-close db)))

(define (add-phase options arg)
  (let ((db (db-open)))
    (new-phase db (option-ref options 'phase #f))
    (db-close db)))

(define (show-phases options arg)
  (let ((db (db-open)))
	(select-phases db)
	(alists->table (db-list-result db))
	(db-close db)))

(define (add-task-type options arg)
  (let ((db (db-open)))
    (new-task-type db (option-ref options 'task-type #f))
    (db-close db)))

(define (show-task-types options arg)
  (let ((db (db-open)))
	(select-task-types db)
	(alists->table (db-list-result db))
	(db-close db)))

(define (add-task options arg)
  (let ((db (db-open)))
    (new-task db 
	       (option-ref options 'task-type #f)
	       (option-ref options 'task #f)
	       (option-ref options 'project #f))
    (db-close db)))

(define (show-tasks options arg)
  (let ((db (db-open))
		(project-title (option-ref options 'project #f)))
	(if project-title
		(select-tasks db project-title)
		(select-tasks db))
	(alists->table (db-list-result db))
	(db-close db)))

(define (show-projects options arg)
  (let ((db (db-open)))
	(select-projects db)
	(alists->table (db-list-result db))
	(db-close db)))

(define (start options arg)
  (let ((db (db-open)))
    (start-activity db 
		    (option-ref options 'task #f)
		    (option-ref options 'phase #f)
		    (option-ref options 'project #f))
    (db-close db)))

(define (end options arg)
  (let ((db (db-open)))
    (end-activity db 
		  (option-ref options 'progress #f)
		  (option-ref options 'comment #f))
    (db-close db)))

(define (interrupt options arg)
  (let ((db (db-open)))
    (start-interruption db)
    (db-close db)))

(define (continue options arg)
  (let ((db (db-open)))
    (end-interruption db (option-ref options 'comment #f))
    (db-close db)))
