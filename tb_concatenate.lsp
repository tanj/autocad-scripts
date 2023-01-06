(defun c:tb_concatenate ( linelst / )
;; Contatenate multiple project "LINEx" desc lines into single
;; line of text to apply to a target title block attribute


;; "linelst" = (list num1 num2 ... numx) where the numbers are
;; integer values for the "LINEx" lines to concatenate.
;; Ex: to concatenate LINE3 and LINE14 with a dash character
;; between them, the call would look like this:
;; (c:tb_concatenate (list 3 "-" 14))


;; Make sure linelst is not nil and is a list of something


  (setq output_str "") ;; default to nothing if total failure


  (if (AND linelst (listp linelst))
      (progn ;; okay to continue
        ;; Get copy of the active project's title descriptions
        (setq x (c:wd_proj_wdp_data)) ;; API call for project data
        (setq desclst (nth 2 x)) ;; strip out just LINEx list


        ;; Now assemble the concatenated output string
        (foreach item linelst
                 (cond
                  ((= (type item) 'INT) ;; integer number, assume LINEx index
                   (if (< item (length desclst)) ;; don't overrun end of list
                       ;; Paste on this LINEx value
                       (setq output_str (strcat output_str (nth item desclst)))
                     )
                   )
                  (T ;; assume delimiter or fixed text string
                   (setq output_str (strcat output_str item))
                   )
                  ) )
        ) )
  output_str ;; return the concatenate string (or "" if failure)
)
