*mos
********************************************************************************* 
.OPTION POST=2
.hdl "q1.va"
.model mos simple_mos

*Netlist********************************************************************************

X1 3 2 0 0 mos
Vg 2 0 DC 1
Vd 3 0 DC 1
 *********************************************************************************
.dc Vd 0 2 0.001
.dc Vg 0 2 0.001
.print DC i(Vd) V(3)
.end


