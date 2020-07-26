clear;
NA = 2*10^15; %cm^-3
ND = 10^16; %cm^-3
Nc = 2.75*10^19; %cm^−3
Nv = 2*10^19; %cm^−3
Eg = 1.1; %eV
%setting Ev as our reference
Ev = 0;
Ec = Ev+Eg;
Ej = 0.045;
Ed = Ec - Ej;
Ea = Ev + Ej;
T = 300; %K
q = 1.6*10^-19;
k = 1.38*10^-23/q; %boltzmann constant
Ef_curr = 1.1; %ev (Since ND > NA, we expect fermi level to be closer to Ec)
Ef_next = 0;
iter = 0; %no. of iterations
while true
    iter = iter +1;
    func = -Nv*exp((Ev-Ef_curr)/(k*T))+Nc*exp((Ef_curr-Ec)/(k*T))+(NA/(1+4*exp((Ea-Ef_curr)/(k*T))))-(ND/(1+2*exp((Ef_curr-Ed)/(k*T))));
    funcp = ((Nv*exp((Ev-Ef_curr)/(k*T))+Nc*exp((Ef_curr-Ec)/(k*T)))+(NA*4*exp((Ea-Ef_curr)/(k*T))/(1+4*exp((Ea-Ef_curr)/(k*T)))^2)+(ND*2*exp((Ef_curr-Ed)/(k*T))/(1+2*exp((Ef_curr-Ed)/(k*T)))^2))/(k*T);
    Ef_next = Ef_curr - func/funcp;
    e = abs(Ef_next-Ef_curr);
    Ef_curr = Ef_next;
    if e<0.01
        break
    end
    
end
Efermi = Ef_curr;