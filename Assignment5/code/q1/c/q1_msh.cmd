Title ""

Controls {
}

Definitions {
	Constant "ConstantProfileDefinition_1" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+16
	}
	Refinement "RefinementDefinition_1" {
		MaxElementSize = ( 0.25 0.5 )
		MinElementSize = ( 0.25 0.5 )
	}
	Refinement "RefinementDefinition_2" {
		MaxElementSize = ( 0.05 0.5 )
		MinElementSize = ( 0.05 0.5 )
	}
	Refinement "RefinementDefinition_3" {
		MaxElementSize = ( 0.05 0.5 )
		MinElementSize = ( 0.05 0.5 )
	}
}

Placements {
	Constant "ConstantProfilePlacement_1" {
		Reference = "ConstantProfileDefinition_1"
		EvaluateWindow {
			Element = material ["Silicon"]
		}
	}
	Refinement "RefinementPlacement_1" {
		Reference = "RefinementDefinition_1"
		RefineWindow = Rectangle [(-0.2 -0.2) (5.2 3.2)]
	}
	Refinement "RefinementPlacement_2" {
		Reference = "RefinementDefinition_2"
		RefineWindow = Rectangle [(0 0) (0.5 3)]
	}
	Refinement "RefinementPlacement_3" {
		Reference = "RefinementDefinition_3"
		RefineWindow = Rectangle [(4.5 0) (5 3)]
	}
}

