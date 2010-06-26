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

(define-module (plogger times)
  :export (utc->local current-utc-time))

(define utc->local
  (lambda (date-string)
    (strftime "%Y-%m-%d %H:%M:%S" 
	      (localtime 
	       (car (mktime 
		     (car (strptime 
			   "%Y-%m-%d %H:%M:%S" date-string)) 
		     "00:00:00"))))))

(define current-utc-time
  (lambda ()
	(strftime "%Y-%m-%d %H:%M:%S" (gmtime (current-time)))))
