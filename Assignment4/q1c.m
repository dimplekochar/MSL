d = 100*10^-4; %cm %distance between A and B
N = 1000; %number of points
nA = 0; %cm^-3
nB  = 0; %cm^-3
tau = 10^-7; %s
D = 30; %cm^2/sec
x = d/N; %gridspacing
n(1:N+1) = 0;
n(1) = nA;
n(N+1) = nB;
S(1:N+1) = 0;
s = round(30*10^-4/x);
S(s+1) = 10^12;
xgrid = linspace(0, d, N+1);

P(1:N+1) = 0;
P(1) = nA;
P(N+1) = nB;
P = P+S;
M(1:N+1, 1:N+1) = 0;
M(1,1) = 1;
M(N+1, N+1) = 1;
for i=2:N
    M(i,i) = (-2/x^2)-(1/(D*tau));
    M(i,i-1) = 1/x^2;
    M(i,i+1) = 1/x^2;
end
M(s+1,1:N+1) = 0;
M(s+1, s+1) = 2*D/x;
M(s+1, s+2) = -D/x;
M(s+1, s) = -D/x;
n = M\P';

figure(1); %numerical
plot(xgrid, n);
xlabel('x')
ylabel('concentration')
title('numerical')
n_analytical(1:s+1) = 10^6*((5.105*exp(577.35*xgrid(1:s+1)))+(-5.105*exp(-577.35*xgrid(1:s+1))));
n_analytical(2+s:N+1) = ((-1527.836*exp(577.35*xgrid(2+s:N+1)))+(1.58*10^8*exp(-577.35*xgrid(2+s:N+1))));
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