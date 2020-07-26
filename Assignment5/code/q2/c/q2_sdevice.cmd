#File section
File {

        Grid = "q2_msh.tdr"
       Param = "models.par"
        Plot = "MIM_plot_eg_dd.dat"
        Current = "MIM_current_eg_dd.plt"
        Output = "MIM_output_eg_dd.log"

}

#Electrodes
Electrode {
   	{ Name="n1contact" Voltage=0.0}
	  { Name="n2contact" Voltage=0.0}
	
}

#Physics
Physics {
   #Hydrodynamic( eTemperature )
   EffectiveIntrinsicDensity( Slotboom )
   Mobility (
    #  DopingDependence
   HighFieldSaturation
   #    Enormal
    # ConstantMobility

   )
	Recombination(
		Auger
		SRH
	)
}

#Plot
Plot {
   #eDensity hDensity eCurrent/Vector hCurrent
   #Potential SpaceCharge ElectricField/Vector
   #eMobility hMobility eVelocity hVelocity
  # Doping DonorConcentration AcceptorConcentration Bandgap ConductionBandEnergy ValenceBandEnergy
  # eAvalancheGeneration hAvalancheGeneration SRHRecombination TotalRecombination
   #eQuasiFermiPotential  hQuasiFermiPotential 
  # DeepLevels "TotalTrapConcentration"
	Doping DonorConcentration AcceptorConcentration BandGap BandGapNarrowing ElectronAffinity ConductionBandEnergy ValenceBandEnergy 	eQuasiFermiEnergy hQuasiFermiEnergy
	eDensity hDensity
	EffectiveIntrinsicDensity IntrinsicDensity ElectricField/Vector
	Potential
	eMobility hMobility
	SRHRecombination AugerRecombination TotalRecombination SurfaceRecombination
}


Math {
-CheckUndefinedModels
   Extrapolate
   RelErrControl
   NoSRHperPotential
   iterations =50
}



Solve {
   #-initial solution:
   Poisson
  Coupled { Poisson Electron hole}

plot(FilePrefix="0.0V_neg_dd")


#Ramp up voltage from 0 to 0.01 through 10 intervals

  Quasistationary (Initialstep= 0.05 MaxStep=0.1 MinStep=0.0001
     Goal{ Name="n2contact" Voltage= 0.01})
     { Coupled { Poisson Electron hole} 
     plot(FilePrefix="0.01V_neg_dd")
     CurrentPlot ( Time = (range = (0 1) intervals = 10))
     }
 #Ramp up voltage from 0.01 to 0.1 through 10 intervals   
  
  Quasistationary (Initialstep= 0.05 MaxStep=0.1 MinStep=0.0001
     Goal{ Name="n2contact" Voltage= 0.1})
     { Coupled { Poisson Electron hole} 
     plot(FilePrefix="0.1V_neg_dd" )
     CurrentPlot ( Time = (range = (0 1) intervals = 10))
     }
 #Ramp up voltage from 0.1 to 1 through 50 intervals    
 
   Quasistationary (Initialstep= 0.0001 MaxStep=0.05 MinStep=0.0001
     Goal{ Name="n2contact" Voltage= 1})
     { Coupled { Poisson Electron hole} 
     plot(FilePrefix="1V_neg_dd")
     CurrentPlot ( Time = (range = (0 1) intervals = 50))
     }
     
    Quasistationary (Initialstep= 0.025 MaxStep=0.05 MinStep=0.0001
     Goal{ Name="n2contact" Voltage= 3})
     { Coupled { Poisson Electron hole} 
     plot(FilePrefix="3V_neg_dd" )
     CurrentPlot ( Time = (range = (0 1) intervals = 50))
 
     }
       

   
    
}

