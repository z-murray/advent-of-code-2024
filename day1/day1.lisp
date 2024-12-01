(ql:quickload :cl-ppcre)
(use-package :cl-ppcre)

(defparameter *left* nil)
(defparameter *right* nil)

(with-open-file (in "input.txt")
  (loop for line = (read-line in nil)
	while line
	do (let* ((splitted (split "\\s+" line))
		  (lv (parse-integer (first splitted)))
		  (rv (parse-integer (second splitted))))
	     (push lv *left*)
	     (push rv *right*))))

(setf *left* (sort *left* #'<))
(setf *right* (sort *right* #'<))

(defparameter *total-distance*
  (reduce (lambda (acc lr) (+ acc (abs (- (first lr) (second lr)))))
	  (mapcar #'list *left* *right*)
	  :initial-value 0))

(defparameter *similarity-score*
  (reduce #'+ (mapcar (lambda (x) (* x (count x *right*))) *left*)))
