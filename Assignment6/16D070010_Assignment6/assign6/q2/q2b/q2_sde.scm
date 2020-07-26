(define mesh 0.005)
;material 

(sdegeo:create-rectangle  (position 0 0 0) (position 2 2 0) "Silicon" "ptype"  )
(sdegeo:create-rectangle  (position 2 0 0) (position 4 2 0) "Silicon" "ntype"  )


;Doping
(sdedr:define-constant-profile "ConstantProfileDefinition_1" "BoronActiveConcentration" 1e18)
(sdedr:define-constant-profile-region "ConstantProfilePlacement_1" "ConstantProfileDefinition_1" "ptype")
(sdedr:define-constant-profile-placement "ConstantProfilePlacement_1" "ConstantProfileDefinition_1" "ptypewindow")

(sdedr:define-constant-profile "ConstantProfileDefinition_2" "PhosphorusActiveConcentration" 1e18)
(sdedr:define-constant-profile-region "ConstantProfilePlacement_2" "ConstantProfileDefinition_2" "ntype")
(sdedr:define-constant-profile-placement "ConstantProfilePlacement_2" "ConstantProfileDefinition_2" "ntypewindow")


;contact
(sdegeo:define-contact-set "n1contact"     4.0 (color:rgb 1.0 0.0 0.0 ) "%%" )
(sdegeo:define-contact-set "n2contact"     4.0 (color:rgb 1.0 0.0 0.0 ) "||" )

(sdegeo:define-2d-contact (list (car (find-edge-id (position 0 1 0)))) "n1contact")
(sdegeo:define-2d-contact (list (car (find-edge-id (position 4 1 0)))) "n2contact")


;Refinement Window for Global Meshing

(sdedr:define-refeval-window "RefEvalWin_1" "Rectangle"  (position (- 0 0.2) (- 0 0.2) 0) (position (+ 4 0.2) (+ 2 0.2) 0))

;Global Mesh

(sdedr:define-refinement-size "RefinementDefinition_1" 0.25 0.1 0.25 0.1 )
(sdedr:define-refinement-placement "RefinementPlacement_1" "RefinementDefinition_1" "RefEvalWin_1" )

;Region-based Mesh
(sdedr:define-refeval-window "RefEvalWin_2" "Rectangle"  (position 0 0 0) (position 0.2 2 0))
(sdedr:define-refinement-placement "RefinementPlacement_2" "RefinementDefinition_2" "RefEvalWin_2" )
(sdedr:define-refinement-size "RefinementDefinition_2" 0.05 0.05 0.05 0.05 )

(sdedr:define-refeval-window "RefEvalWin_3" "Rectangle"  (position 3.8 0 0) (position 4 2 0))
(sdedr:define-refinement-placement "RefinementPlacement_3" "RefinementDefinition_3" "RefEvalWin_3" )
(sdedr:define-refinement-size "RefinementDefinition_3" 0.05 0.05 0.05 0.05 )

(sdedr:define-refeval-window "RefEvalWin_4" "Rectangle"  (position 1.9 0 0) (position 2.1 2 0))
(sdedr:define-refinement-placement "RefinementPlacement_4" "RefinementDefinition_4" "RefEvalWin_4" )
(sdedr:define-refinement-size "RefinementDefinition_4" 0.01 0.01 0.01 0.01 )

(sde:save-model "q2")
(sde:build-mesh "snmesh"  "-a -c boxmethod" "q2")
