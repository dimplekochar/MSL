;Length definitions
(define x1 0)
(define y1 0)
(define z1 0)
(define L 0.1)
(define x2 (+ L x1))
(define T 0.1)
(define y2 (+ T y1))
(define W 1)
;(define z2 (+ T z1))
(define z2 0)
;Mesh co-ordinates
(define Lmesh 0.01)
(define xmeshmin1 x1)
(define ymeshmin1 y1)
(define zmeshmin1 z1)
(define xmeshmax1 (+ x1 Lmesh))
(define ymeshmax1 0.08)
(define zmeshmax1 z2)
(define xmeshmin2 0.02)
(define ymeshmin2 (- y2 Lmesh))
(define zmeshmin2 z1)
(define xmeshmax2 x2)
(define ymeshmax2 y2)
(define zmeshmax2 z2)
;material 
(sdegeo:create-rectangle (position x1 y1 z1)  (position x2 y2 z2) "SiO2" "region_1" )

;contact
(sdegeo:insert-vertex (position 0.02 0.1 0.0))
(sdegeo:insert-vertex (position 0 0.08 0.0))
(sdegeo:define-contact-set "n1contact"     4.0 (color:rgb 1.0 0.0 0.0 ) "%%" )
(sdegeo:define-contact-set "n2contact"     4.0 (color:rgb 1.0 0.0 0.0 ) "||" )

(sdegeo:define-2d-contact (list (car (find-edge-id (position 0.06 0.1 0)))) "n1contact")
(sdegeo:define-2d-contact (list (car (find-edge-id (position 0 0.04 0)))) "n2contact")

;Refinement Window for Global Meshing

(sdedr:define-refeval-window "RefEvalWin_1" "Rectangle"  (position (- x1 0.2) (- y1 0.2) 0) (position (+ x2 0.2) (+ y2 0.2) 0))

;Global Mesh

(sdedr:define-refinement-size "RefinementDefinition_1" 0.005 0.01 0.005 0.01 )
(sdedr:define-refinement-placement "RefinementPlacement_1" "RefinementDefinition_1" "RefEvalWin_1" )

;Region-based Mesh
(sdedr:define-refeval-window "RefEvalWin_2" "Rectangle"  (position xmeshmin1 ymeshmin1 0) (position xmeshmax1 ymeshmax1 0))
(sdedr:define-refinement-placement "RefinementPlacement_2" "RefinementDefinition_2" "RefEvalWin_2" )
(sdedr:define-refinement-size "RefinementDefinition_2" 0.001 0.01 0.001 0.01 )

(sdedr:define-refeval-window "RefEvalWin_3" "Rectangle"  (position xmeshmin2 ymeshmin2 0) (position xmeshmax2 ymeshmax2 0))
(sdedr:define-refinement-placement "RefinementPlacement_3" "RefinementDefinition_3" "RefEvalWin_3" )
(sdedr:define-refinement-size "RefinementDefinition_3" 0.001 0.01 0.001 0.01 )

(sde:save-model "q3")
(sde:build-mesh "snmesh"  "-a -c boxmethod" "q3")
