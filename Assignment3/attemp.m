clear
lp = 10^-4; %cm
ln = 10^-4; %cm
l = lp+ln; %cm
x = 10^-7; %cm %grid spacing
nx = round(l/x); %grid points
ND = 10^16; %cm^-3
NA = 10^16; %cm^-3
epsilon = 8.854*10^-14; %cm^-1
Ksi = 12;
epsi = Ksi*epsilon;
q = 1.602176634*10^-19;
T = 300; %K
k = 1.38064852*10^-23; %boltzmann constant
ni = 1.45*10^10; %cm^-3
Eg = 1.12; %eV
h = 6.626*10^-34; %planck's constant
m0 = 9.1*10^-31;
mn = 1.08*m0; %effective electron mass in Si
mp = 0.57*m0; %effective hole mass in Si
Nc = (2*(2*pi*mn*k*T/h^2)^1.5)*10^-6;
Nv = (2*(2*pi*mp*k*T/h^2)^1.5)*10^-6;
Vt = k*T/q;
Vbi = (k*T/q)*log(NA*ND/ni^2);
%initialize potential and charge densities
v = zeros(1,nx);
deltv = zeros(1,nx);
diffv(1:nx, 1:nx) = 0;
diffv1(1:nx, 1:nx) = 0;
diffv2(1:nx, 1:nx) = 0;
n = zeros(1,nx);
p = zeros(1,nx);
NAm(1:nx/2) = NA; %NA^-
NAm((nx/2)+1:nx) = 0;
NDp(1:nx/2) = 0; %ND^+
NDp((nx/2)+1:nx) = ND;
n(1) = (ni^2)/NA;
p(1) = NA;
p(2:nx/2) = NA/2;
n(2:nx/2) = 2*(ni^2)/NA;
n(nx) = ND;
p(nx) = (ni^2)/ND;
n((nx/2)+1:nx) = ND/2;
p((nx/2)+1:nx) = 2*(ni^2)/ND;
v(1) = 0;
v(nx) = Vbi;
roh = q*(NDp-NAm+p-n); %charge density

emax = 0;
iter=0;
while true
    F(1) = v(1)/x^2 + roh(1)/epsi;
    F(nx) = (v(nx-1)-v(nx))/x^2 + roh(nx)/epsi;
    for i=2:nx-1
        F(i) = ((v(i-1)-2*v(i)+v(i+1))/x^2) + roh(i)/epsi;
        diffv1(i,i-1) = 1/x^2;
        diffv1(i,i) = -2/x^2;
        diffv1(i,i+1) = 1/x^2;       
    end
    diffv1(1,1) = 1/x^2;
    diffv1(nx,nx) = -1/x^2;
    diffv1(nx,nx-1) = 1/x^2;
    for i=3:nx-1
        %diffv2(i,1) = (q/(epsi*2*Vt))*(p(1)*exp((v(1)+v(2)-v(i)-v(i+1))/(2*Vt))+n(1)*exp((-v(1)-v(2)+v(i)+v(i+1))/(2*Vt)));
        diffv2(i,1) = (q/(epsi*2*Vt))*(p(i)+n(i));
        diffv2(i,2) = diffv2(i,1);
        diffv2(i,i) = -diffv2(i,1);
        diffv2(i,i+1) = -diffv2(i,1);
    end
    %diffv2(2,1) = (q/(epsi*2*Vt))*(p(1)*exp((v(1)-v(3))/(2*Vt))+n(1)*exp((-v(1)+v(3))/(2*Vt)));
    diffv2(2,1) = (q/(epsi*2*Vt))*(p(2)+n(2));
    diffv2(2,3) = -diffv2(2,1);
    diffv = diffv1+diffv2;
    deltv = -diffv\F';
    v = v+deltv';
    v(1) = 0;
    v(nx) = Vbi;
    if max(deltv)<0.05
        break;
    end
    for i=2:nx-1 %so that boundaries don't change
            n(i) = n(i-1)*exp((v(i+1)-v(i-1))/(2*Vt));
            p(i) = p(i-1)*exp((v(i-1)-v(i+1))/(2*Vt));
            roh(i) = q*(NDp(i)-NAm(i)+p(i)-n(i));
    end
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

% 
% %band diagram
% figure(6)
% plot(xgrid,Ec,xgrid,Ev,xgrid,((Ec+Ev)/2),xgrid,Ef)
% legend('Ec','Ev','Emid', 'Ef')
% xlabel('x in cm')
% ylabel('Energy (eV)')
