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

(define-module (plogger text)
  :export (alists->table))

(define (extract-headers alist headers)
  (let ((headers (append headers (list (car (car alist))))))
	(if (not (null? (cdr alist)))
		(extract-headers (cdr alist) headers)
		headers)))

(define (extract-values alist values)
  (let ((values (append values (list (cdr (car alist))))))
	(if (not (null? (cdr alist)))
		(extract-values (cdr alist) values)
		values)))

(define (extract-rows alists rows)
  (if (not (null? alists))
	  (let ((rows (append rows (list (extract-values (car alists) '())))))
		(extract-rows (cdr alists) rows))
	  rows))

(define (display-row row)
  (if (not (null? row))
	  (begin
		(display (car row))(display "\t")
		(display-row (cdr row)))))

(define (display-lines lines)
  (if (not (null? lines))
	  (begin
		(display-row (car lines))(newline)
		(display-lines (cdr lines)))))

(define (alists->table alists)
  (let* ((headers (extract-headers (car alists) '()))
		 (rows (extract-rows alists '()))
		 (lines (append (list headers) rows)))
	(display-lines lines)))
