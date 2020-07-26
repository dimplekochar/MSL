
;; Defined Parameters:

;; Contact Sets:
(sdegeo:define-contact-set "n1contact" 4 (color:rgb 1 0 0 )"##" )
(sdegeo:define-contact-set "n2contact" 4 (color:rgb 1 0 0 )"||" )

;; Work Planes:
(sde:workplanes-init-scm-binding)

;; Defined ACIS Refinements:
(sde:refinement-init-scm-binding)

;; Reference/Evaluation Windows:
(sdedr:define-refeval-window "RefEvalWin_1" "Rectangle" (position -0.2 -0.2 0) (position 0.3 0.3 0))
(sdedr:define-refeval-window "RefEvalWin_2" "Rectangle" (position 0 0 0) (position 0.01 0.1 0))
(sdedr:define-refeval-window "RefEvalWin_3" "Rectangle" (position 0.09 0 0) (position 0.1 0.1 0))
