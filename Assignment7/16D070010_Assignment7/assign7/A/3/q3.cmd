#1.Grid definition
#1DGrid definition in x direction
line x location=0.0  spacing=1.0<nm> tag=SiTop
line x location=50<nm> spacing=10<nm>
line x location=100<nm> spacing=20<nm>
line x location=500<nm> spacing=50<nm>
line x location=1200<nm> spacing=100<nm> tag=SiBottom

#1D Grid definition in y direction
line y location=0.0  spacing=50<nm> tag=Left
line y location=1000<nm> spacing=50<nm> tag=Right

#2. Define simulation domain and initial parameters
# Initial simulation domain
region Silicon xlo=SiTop xhi=SiBottom ylo=Left yhi=Right

# Initial doping concentration in the region defined
init concentration=1e+16<cm-3> field=Boron wafer.orient=100

# Global Mesh settings for automatic meshing in newly generated layers.
#This strategy is used when there is change in initial geometry due to
#deposit, oxidation and etching

mgoals min.normal.size=2<nm> normal.growth.ratio=1.4 accuracy=1e-5

#3. Oxide Deposition
deposit material= {Oxide} type=isotropic time=1 rate= {0.15}
grid remesh

#4. Implant Mask
mask name=implant_mask segments= {0<um> 0.45<um> 0.55<um> 1.0<um> }

#5. Anisotropic oxide etching
etch material= {oxide} type=anisotropic time=1 rate= {0.17} mask=implant_mask
grid remesh

# save the structure file after etching
struct tdr=1_pn_oxide_etch_before_implant ; 

#6. Grid refinement
refinebox Silicon min= {0.0 0.4} max= {0.2 0.6}\
xrefine= {0.01 0.01 0.01} yrefine= {0.01 0.01 0.01}
grid remesh

#7. Ion Implantation (n-type dopants)
implant Phosphorus energy=4.3<keV> dose=4.8e12<cm-2> tilt = 0
 
#8. Diffusion of n-type dopants 
diffuse temperature=1060<C> time=9<s>

# saving the structure after implantation and diffusion
struct tdr=2_pn_after_implant_diffusion ;

#9. Isotropic oxide etch
etch material= {Oxide} type=isotropic time=1 rate= {0.17}
grid remesh

# saving structure file after oxide etch
struct tdr=3_pn_after_imp_diff_oxide_etch ;

#10. n-contact deposition
deposit material= {Aluminum} type=isotropic time=1 rate= {0.07}
grid remesh


#saving structure after contact deposition
struct tdr=4_pn_after_metal_depos ;

#11. Metal etching for n-contact
mask name=contacts_mask1 left=0.45<um> right=0.55<um>

etch material= {Aluminum} type=anisotropic time=1 rate= {0.08} mask=contacts_mask1
grid remesh

#12. Define contacts
contact name = "n" box Aluminum adjacent.material = Ambient \
xlo = -0.071 xhi = -0.069 ylo = 0.425 yhi = 0.575

contact name = "p" box silicon adjacent.material = Ambient\
xlo = 1.19 xhi = 1.21 ylo = 0.0 yhi = 1

# save final structure
struct tdr = 5_pn_final_structure
