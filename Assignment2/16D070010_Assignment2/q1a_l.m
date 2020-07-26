clear;
q = 1.6*10^-19;
k = 1.38*10^-23;
T = 300;
epsilon = 8.854*10^-14; %cm^-1
epsi = 11.8*epsilon;
NA = 10^16; %cm^-3
ND = 10^16; %cm^-3
Nc = 2.75*10^19; %cm^−3
Nv = 2*10^19; %cm^−3
Eg = 1.1; %eV
ni =sqrt(Nc*Nv*exp(-Eg*q/(k*T)));

xn = ((3*epsi/(q*(NA+ND)))*(2*k*T/q)*log(0.5*(NA+ND)/ni))^(1/2);
xp = xn; %cm xp is length of ptype region 0-xp is ptype
xp = round(xp*10^7)/10^7;
xn = round(xn*10^7)/10^7;
l = xp+xn; %cm %length of junction
x = 1*10^-7; %cm %grid spacing
deltx = 10^-7; %cm
nx = (l/x); %number of grid points
xgrid = linspace(0,xp+xn-x,nx);
roh(1:nx) = q*(NA+ND).*(xgrid-xp)./(xn+xp);  
%plot(xgrid, roh); 
%integration using trapezoidal rule
E(1:nx) = 0;
E(1) = 0;
for i=2:nx
    E(i) = E(i-1)+(deltx/(2*epsi))*(roh(i-1)+roh(i));
end

figure(1);
plot(xgrid,E);
xlabel('x in cm')
ylabel('Electric field using trapezoidal integration')

%integration using matlab function
fun = @(X) q*(NA+ND)*(X-xp)/((xn+xp)*epsi);
i = 1;
xx = 0;
while xx<xp+xn
    Ei(i) = integral(fun, 0, xx);
    i = i+1;
    xx = xx+x;
end
figure(2);
plot(xgrid,Ei);
xlabel('x in cm')
ylabel('Electric field using MATLAB integration')




