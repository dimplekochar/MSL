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
ni = sqrt(Nc*Nv*exp(-Eg*q/(k*T)));
Vbi = (k*T/q)*log(NA*ND/ni^2);
w = sqrt(2*epsi*Vbi*((1/NA)+(1/ND))/q);
xp = ND*w/(NA+ND);%cm xp is length of ptype region 0-xp is ptype
xn = (ND/NA)*xp;%cm xp is length of ntype region xp-xp+xn is ntype
xp = round(xp*10^7)/10^7;
xn = round(xn*10^7)/10^7;
l = xp+xn; %cm %length of junction
x = 1*10^-7; %cm %grid spacing
deltx = 10^-7; %cm
nx = (l/x); %number of grid points
nx = round(nx);
xgrid = linspace(0,xp+xn-x,nx);
roh(1:xp/x) =  -q*NA;
roh((xp/x)+1:((xn+xp)/x)) =  q*ND;
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
fun1 = @(X) -(q*NA/epsi)+0*X;
fun2 = @(X) (q*ND/epsi)+0*X;
i = 1;
xx = 0;
while xx<xp
    Ei(i) = integral(fun1, 0, xx);
    i = i+1;
    xx = xx+x;
end
while xx<xp+xn
    Ei(i) = integral(fun1, 0, xp)+integral(fun2, xp, xx);
    i = i+1;
    xx = xx+x;
end
figure(2);
plot(xgrid,Ei);
xlabel('x in cm')
ylabel('Electric field using MATLAB integration')




