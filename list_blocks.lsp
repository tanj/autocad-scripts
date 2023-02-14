(defun c:blockinfo ( / e f i s )
  (if 
      (and
       (setq s (ssget "_X" '((0 . "INSERT") (410 . "Model"))))
       (setq f (getfiled "Create CSV File" "" "csv" 1))
       (setq f (open f "w"))
       )
      (progn
        (repeat (setq i (sslength s))
                (setq e (entget (ssname s (setq i (1- i)))))
                (write-line
                 (apply 'strcat
                        (cons (LM:name->effectivename (cdr (assoc 2 e)))
                              (mapcar '(lambda ( x ) (strcat "," (rtos x)))
                                      (cdr (assoc 10 e))
                                      )
                              )
                        )
                 f
                 )
                )
        (close f)
        )
    )
  (princ)
  )

(defun c:blockinfo-bare ( / e f i s )
  (if 
      (and
       (setq s (ssget "_X" '((0 . "INSERT") (410 . "Model"))))
       (setq f (getfiled "Create CSV File" "" "csv" 1))
       (setq f (open f "w"))
       )
      (progn
        (repeat (setq i (sslength s))
                (setq e (entget (ssname s (setq i (1- i)))))
                (write-line
                 (apply 'strcat
                        (cons (LM:name (cdr (assoc 2 e)))
                              (mapcar '(lambda ( x ) (strcat "," (rtos x)))
                                      (cdr (assoc 10 e))
                                      )
                              )
                        )
                 f
                 )
                )
        (close f)
        )
    )
  (princ)
  )


(defun LM:name ( blk / rep )
  (strcat (if blk blk "") (if rep rep ""))
  )
;; Block Name -> Effective Block Name  -  Lee Mac
;; blk - [str] Block name

(defun LM:name->effectivename ( blk / rep )
  (if
      (and (wcmatch blk "`**")
           (setq rep
                 (cdadr
                  (assoc -3
                         (entget
                          (cdr (assoc 330 (entget (tblobjname "block" blk))))
                          '("AcDbBlockRepBTag")
                          )
                         )
                  )
                 )
           (setq rep (handent (cdr (assoc 1005 rep))))
           )
      (cdr (assoc 2 (entget rep)))
    blk
    )
  )

(princ)
