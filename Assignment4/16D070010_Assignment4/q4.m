q4d;
q = 1.6*10^-19;
N = 200; %number of grid points
plus = round(N/17); %40 nm  away point
Do = 10.5; %cm^2/sec %boron in Si - diffusion
Ea = 3.69*q;  %boron in Si - activation
Temp = 500+273; %temperature %fix any temperature
kb = 1.38*10^-23; %boltzmann constant
D = Do*exp(-Ea/(kb*Temp));
xgrid  = depth*10^-4; %from q4d
x = xgrid(2) - xgrid(1);
for i=102:201
    xgrid(i) = xgrid(i-1)+x;
end
p = x^2/(2*D);
T = 1000; %no. of time steps
t = p*T; %sec %total time
tgrid = linspace(0, t, T+1);
n_in(1:101) = conc; %initial concentration
n_in(102:N+1) = 0;
n(1:N+1, 1:T+1) = 0;
n(1:N+1, 1) = n_in;
n_new(1:N+1, 1:T+1) = 0;
err = 0;
iter = 0;
while true
    for j=2:T+1
        for i=2:N
            n_new(i,j) = (((n(i+1,j)+n(i-1,j))/x^2)+(n(i,j-1)/(D*p)))/((2/x^2)+(1/(D*p)));
            if abs(n_new(i,j)-n(i,j))>err
                err = abs(n_new(i,j)-n(i,j));
            end
            n(i,j) = n_new(i,j);
        end
        n(1,j) = 0; 
        n(N+1,j) = n(N,j); %neumann
    end
    iter = iter+1;
    
    if err<0.1
        break;
    end
    err=0;
end
for j=2:T+1
    A = n(1:N+1,j);
    [M, I]=max(A);
    for i=I:N+1-plus
        if n(i,j)/n(i+plus,j)<=10 && n(i,j) <= 1.1*10^17 && n(i,j) >= 0.9*10^17
            break;
        end
    end
	if n(i,j)/n(i+plus,j)<=10 && n(i,j) <= 1.1*10^17 && n(i,j) >= 0.9*10^17
        break;
    end
end

thermal_budget = tgrid(j)*D; 