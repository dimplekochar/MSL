clear
lnn = 10^-4; %cm
ln = 10^-4; %cm
l = lnn+ln; %cm
x = 10^-7; %cm %grid spacing
nx = round(l/x); %grid points
NDD = 10^17; %cm^-3
ND = 10^16; %cm^-3
ni = 1.45*10^10; %cm^-3
epsilon = 8.854*10^-14; %cm^-1
Ksi = 12;
epsi = Ksi*epsilon;
q = 1.602176634*10^-19;
T = 300; %K
k = 1.38064852*10^-23; %boltzmann constant
Vt = k*T/q;
phinn = Vt*log(NDD/ni);
phin = Vt*log(ND/ni);

%initialize potential and charge densities
v(1:nx) = linspace(phinn, phin, nx);
n = ni*exp(v./Vt);
p = ni*exp(-v./Vt);
F(1:nx) = 0;
J(1:nx,1:nx) = 0;
NDDp(1:nx/2) = NDD; %NA^-
NDDp((nx/2)+1:nx) = 0;
NDp(1:nx/2) = 0; %ND^+
NDp((nx/2)+1:nx) = ND;
Ndop = NDp+NDDp;
emax = 0;
F(1) = 0;
F(nx) = 0;
J(1,1) = 1;
J(nx,nx) = 1;
iter = 1;
while true
    n = ni*exp(v./Vt);
    p = ni*exp(-v./Vt);
    roh = q*(Ndop+p-n);  %charge density
    b = -roh/epsi;
    deltroh = -(q/Vt)*(p+n);
    deltb = -deltroh/epsi;
    for i=2:nx-1
        F(i) = ((v(i-1)-2*v(i)+v(i+1))/x^2)-b(i);
        J(i,i-1) = 1/x^2;
        J(i,i+1) = 1/x^2;
        J(i,i) = (-2/x^2)-deltb(i); 
    end
    deltv = -J\F';
    if max(abs(deltv./v))<0.01
        break;
    end
    v = v+deltv';
    v(1) = phinn;
    v(nx) = phin;
    iter=iter+1;
end

Potential = v;

%solving for electric field
E(1) = -(v(2) - v(1));
for i=2:nx-1
    E(i) = -(v(i+1)-v(i-1))/2;
end
E(nx) = -(v(nx) - v(nx-1));
Field = E/x;

%charge concentration
n = ni*exp(v./Vt);
p = ni*exp(-v./Vt);
roh = q*(Ndop+p-n);
Charge = roh/q;

%Band diagram
Eg = 1.12; %eV
h = 6.626*10^-34; %planck's constant
m0 = 9.1*10^-31;
mn = 1.08*m0; %effective electron mass in Si
mp = 0.57*m0; %effective hole mass in Si
Nc = (2*(2*pi*mn*k*T/h^2)^1.5)*10^-6;
Nv = (2*(2*pi*mp*k*T/h^2)^1.5)*10^-6;

Ec = Vt*log(Nc./n); 
Ev = Vt*log(p./Nv);
Ef(1:nx) = 0;
xgrid = linspace(0, l-x, nx);

%potential
figure(1);
plot(xgrid,Potential);
xlabel('x in cm')
ylabel('Potential (volts)')

%Electric field
figure(2);
plot(xgrid,Field);
xlabel('x in cm')
ylabel('Electric field (volts/cm)')

%roh
figure(3);
plot(xgrid,Charge)
xlabel('x in cm')
ylabel('charge density (cm^-3)')

%n
figure(4);
plot(xgrid,n);
xlabel('x in cm')
ylabel('Electron density (cm^-3)')

%p
figure(5);
plot(xgrid,p)
xlabel('x in cm')
ylabel('Hole density (cm^-3)')


%band diagram
figure(6)
plot(xgrid,Ec,xgrid,Ev,xgrid,((Ec+Ev)/2),xgrid,Ef)
legend('Ec','Ev','Emid', 'Ef')
xlabel('x in cm')
ylabel('Energy (eV)')
