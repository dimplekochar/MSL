Title ""

Controls {
}

Definitions {
	Constant "ConstantProfileDefinition_1" {
		Species = "BoronActiveConcentration"
		Value = 1e+18
	}
	Constant "ConstantProfileDefinition_2" {
		Species = "PhosphorusActiveConcentration"
		Value = 1e+18
	}
	Refinement "RefinementDefinition_1" {
		MaxElementSize = ( 0.25 0.1 )
		MinElementSize = ( 0.25 0.1 )
	}
	Refinement "RefinementDefinition_2" {
		MaxElementSize = ( 0.05 0.05 )
		MinElementSize = ( 0.05 0.05 )
	}
	Refinement "RefinementDefinition_3" {
		MaxElementSize = ( 0.05 0.05 )
		MinElementSize = ( 0.05 0.05 )
	}
	Refinement "RefinementDefinition_4" {
		MaxElementSize = ( 0.01 0.01 )
		MinElementSize = ( 0.01 0.01 )
	}
}

Placements {
	Constant "ConstantProfilePlacement_1" {
		Reference = "ConstantProfileDefinition_1"
		EvaluateWindow {
			Element = region ["ptype"]
		}
	}
	Constant "ConstantProfilePlacement_2" {
		Reference = "ConstantProfileDefinition_2"
		EvaluateWindow {
			Element = region ["ntype"]
		}
	}
	Refinement "RefinementPlacement_1" {
		Reference = "RefinementDefinition_1"
		RefineWindow = Rectangle [(-0.2 -0.2) (4.2 2.2)]
	}
	Refinement "RefinementPlacement_2" {
		Reference = "RefinementDefinition_2"
		RefineWindow = Rectangle [(0 0) (0.2 2)]
	}
	Refinement "RefinementPlacement_3" {
		Reference = "RefinementDefinition_3"
		RefineWindow = Rectangle [(3.8 0) (4 2)]
	}
	Refinement "RefinementPlacement_4" {
		Reference = "RefinementDefinition_4"
		RefineWindow = Rectangle [(1.9 0) (2.1 2)]
	}
}

