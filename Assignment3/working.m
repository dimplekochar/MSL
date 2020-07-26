clear
lp = 10^-4; %cm
ln = 10^-4; %cm
l = lp+ln; %cm
x = 10^-7; %cm %grid spacing
nx = round(l/x); %grid points
ND = 10^16; %cm^-3
NA = 10^16; %cm^-3
ni = 1.45*10^10; %cm^-3
epsilon = 8.854*10^-14; %cm^-1
Ksi = 12;
epsi = Ksi*epsilon;
q = 1.602176634*10^-19;
T = 300; %K
k = 1.38064852*10^-23; %boltzmann constant
Vt = k*T/q;
phip = Vt*log(NA/ni);
phin = Vt*log(ND/ni);

%initialize potential and charge densities
v(1:nx) = linspace(-phip, phin, nx);
n = ni*exp(v./Vt);
p = ni*exp(-v./Vt);
F(1:nx) = 0;
J(1:nx,1:nx) = 0;
NAm(1:nx/2) = NA; %NA^-
NAm((nx/2)+1:nx) = 0;
NDp(1:nx/2) = 0; %ND^+
NDp((nx/2)+1:nx) = ND;
Ndop = NDp-NAm;
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
%     deltv(1) = 0;
%     deltv(nx) = 0;
    if max(abs(deltv./v))<0.1
        break;
    end
    v = v+deltv';
    iter=iter+1;
end

Ec = Vt*log(Nc./n); 
Ev = Vt*log(p./Nv);
Ef(1:nx) = 0;
xgrid = linspace(0, l-x, nx);

%potential
figure(1);
plot(xgrid,v);
xlabel('x in cm')
ylabel('Potential (volts)')

%Electric field

%roh
figure(3);
plot(xgrid,roh)
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
