clear;
q = 1.6*10^-19;
epsilon = 8.854*10^-14; %cm^-1
epsi = 11.2*epsilon;
NA = 10^16; %cm^-3
ND = 10^16; %cm^-3
xp = 200*10^-7; %cm xp is length of ptype region 0-xp is ptype
xn = 200*10^-7; %cm xp is length of ntype region xp-xp+xn is ntype
l = xp+xn; %cm %length of junction
x = 1*10^-7; %cm %grid spacing
deltx = 10^-7; %cm
nx = (l/x); %number of grid points
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




