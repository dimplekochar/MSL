# use these files to get the band diagram and IV characteristics of the given device structure
File {
Grid= "5_pn_final_structure_fps.tdr"
Current= "bottom.plt"
Plot= "bottom.tdr"
Output= "bottom.log"
}
Electrode {
{ Name= "n" Voltage= 0.0 }
{ Name= "p" Voltage= 0.0 }
}
Physics {
Mobility ( DopingDep )
EffectiveIntrinsicDensity(BandGapNarrowing(oldSlotboom))
Recombination (
eAvalanche(CarrierTempDrive) hAvalanche(Okuto)
)
# turn them on or off to see the effect of each recombination mechanism
}

Plot {
Doping DonorConcentration AcceptorConcentration
BandGap BandGapNarrowing ElectronAffinity
ConductionBandEnergy ValenceBandEnergy
eQuasiFermiEnergy hQuasiFermiEnergy
eDensity hDensity
EffectiveIntrinsicDensity IntrinsicDensity
ElectricField/Vector
Potential
SpaceCharge
Current/Vector eCurrent/Vector hCurrent/Vector
CurrentPotential
# for visualizing current lines
eMobility hMobility
SRHRecombination AugerRecombination
TotalRecombination SurfaceRecombination
eLifeTime hLifeTime
ComplexRefractiveIndex QuantumYield
}

Math {
Extrapolate
Iterations= 8
SubMethod= ParDiSo
Method= Blocked
}
Solve{
Coupled { Poisson }
Coupled { Poisson Electron Hole }
Quasistationary ( InitialStep = 1e-3 MaxStep = 0.1 MinStep = 1e-6
Goal { Name = "p" Voltage =2})
	{ Coupled { Poisson Electron Hole } 
	plot(FilePrefix="2V_neg_dd")
     CurrentPlot ( Time = (range = (0 1) intervals = 50))}
NewCurrentFile="IV_sweep_"
Quasistationary ( InitialStep = 1e-3 MaxStep = 0.1 MinStep = 1e-6
Goal { Name = "p" Voltage =-5})
	{ Coupled { Poisson Electron Hole } 
	plot(FilePrefix="-5V_neg_dd")
     CurrentPlot ( Time = (range = (0 1) intervals = 50))}
Quasistationary ( InitialStep = 1e-3 MaxStep = 0.001 MinStep = 1e-6
Goal { Name = "p" Voltage =-10})
{ Coupled { Poisson Electron Hole } }
}


