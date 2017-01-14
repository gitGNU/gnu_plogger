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

(define-module (plogger text)
  :export (alists->table alists->list))

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

(define (extract-elements-lengths list)
  ;(display "List: ")
  ;(display list)(newline)
  (map string-length list))
   
(define (extract-lines-elements-lengths lines)
  ;(display "Lines: ")
  ;(display lines)(newline)
  (map extract-elements-lengths lines))
  
(define (extract-elements-max-lengths lengths lines-elements-lengths)
  (if (not (null? lines-elements-lengths))
      (extract-elements-max-lengths
       (map max lengths (car lines-elements-lengths))
       (cdr lines-elements-lengths))
      lengths))

(define (extract-table-format-r format-string lengths)
  (if (not (null? lengths))
      (extract-table-format-r
       (string-append format-string
		      "~" (format #f "~a" (car lengths)) "a ") ;;",,,' @a "
       (cdr lengths))
      format-string))

(define (extract-table-format lines)
  (let* ((lines-elements-lengths (extract-lines-elements-lengths lines))
	 (max-lengths (extract-elements-max-lengths
		       (car lines-elements-lengths)
		       (cdr lines-elements-lengths))))
    ;(display "Lines: ")(display lines)(newline)
    ;(display "max-lenghts")(display max-lengths)(newline)
    (extract-table-format-r "" max-lengths)))
			    
			    
(define (display-row format-string row)
  (if (not (null? row))
      (apply format (append (list #t format-string) row))))

(define (display-lines format-string lines)
  (if (not (null? lines))
      (begin
	(display-row format-string (car lines))(newline)
	(display-lines format-string (cdr lines)))))

(define (lines->string-lines lines)
  (map (lambda (list)
	 (map (lambda (element)
		(format #f "~a" element)) list)) lines))

(define (alists->table alists)
  (let* ((headers (extract-headers (car alists) '()))
	 (rows (extract-rows alists '()))
	 (lines (append (list headers) rows))
	 (string-lines (lines->string-lines lines))
	 (format-string (extract-table-format string-lines)))
    ;(display "Lines: ")(display lines)(newline)
    ;(display "format-string: ")(display format-string)(newline)
    (display-lines format-string string-lines)))

;(define (alists->list alists)
;  (let ((rows (extract-rows alists '())))
;    (display-lines rows)))

(define (list->values list)
  (let* ((values-with-extra-comma (concatenate
				   (map (lambda (value)
					  (format #f "'~a'," value)) list)))
	 (values (substring tags-with-extra-comma
			    0
			    (- (string-leght tags-with-extra-comma) 1))))
    values))

(define (alist->values list)
  (list->values (alist->list list)))
