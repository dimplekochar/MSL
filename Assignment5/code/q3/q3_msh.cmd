Title ""

Controls {
}

Definitions {
	Refinement "RefinementDefinition_1" {
		MaxElementSize = ( 0.005 0.01 )
		MinElementSize = ( 0.005 0.01 )
	}
	Refinement "RefinementDefinition_2" {
		MaxElementSize = ( 0.001 0.01 )
		MinElementSize = ( 0.001 0.01 )
	}
	Refinement "RefinementDefinition_3" {
		MaxElementSize = ( 0.001 0.01 )
		MinElementSize = ( 0.001 0.01 )
	}
}

Placements {
	Refinement "RefinementPlacement_1" {
		Reference = "RefinementDefinition_1"
		RefineWindow = Rectangle [(-0.2 -0.2) (0.3 0.3)]
	}
	Refinement "RefinementPlacement_2" {
		Reference = "RefinementDefinition_2"
		RefineWindow = Rectangle [(0 0) (0.01 0.08)]
	}
	Refinement "RefinementPlacement_3" {
		Reference = "RefinementDefinition_3"
		RefineWindow = Rectangle [(0.02 0.09) (0.1 0.1)]
	}
}

