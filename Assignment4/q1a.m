d = 100*10^-4; %cm %distance between A and B
N = 1000; %number of points
nA = 10^12; %cm^-3
nB  = 0; %cm^-3
tau = 10^-7; %s
D = 30; %cm^2/sec
x = d/N; %gridspacing
n(1:N+1) = 0;
n(1) = nA;
n(N+1) = nB;
xgrid = linspace(0, d, N+1);


P(1:N+1) = 0;
P(1) = nA;
P(N+1) = nB;
M(1:N+1, 1:N+1) = 0;
M(1,1) = 1;
M(N+1, N+1) = 1;
for i=2:N
    M(i,i) = (-x^2/tau)-(2*D);
    M(i,i-1) = D;
    M(i,i+1) = D;
end
n = M\P';

figure(1); %numerical
plot(xgrid, n);
xlabel('x')
ylabel('concentration')
title('numerical')
n_analytical = 10^6*((-9.665*exp(577.35*xgrid))+(1.0000096*10^6*exp(-577.35*xgrid)));
figure(2); %analytical
plot(xgrid, n_analytical);
xlabel('x')
ylabel('concentration')
title('analytical')
figure(3); %comparison
plot(xgrid, n, xgrid, n_analytical);
xlabel('x')
ylabel('concentration')
title('comparison')


%flux
flux_A = D*(n(2)-n(1))/x;
flux_B = D*(n(N+1)-n(N))/x;
flux_BA = flux_B-flux_A;