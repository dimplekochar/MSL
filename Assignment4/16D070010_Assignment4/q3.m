clear;
d = 100*10^-4; %cm %distance between A and B
N = 100; %number of points
nA = 10^3; %cm^-3
nB  = 0; %cm^-3
D = 30; %cm^2/sec
x = d/N; %gridspacing
p = x^2/(2*D);
T = 1000; %no. of time steps
t = p*T; %sec %total time
n(1:N+1, 1:T+1) = 0;
n_new(1:N+1, 1:T+1) = 0;
n(1, 2:T+1) = nA;
n(N+1, 1:T+1) = nB;
xgrid = linspace(0, d, N+1);
tgrid = linspace(0, t, T+1);

err = 0;
iter = 0;
while true
    for i=2:N
        for j=2:T+1
            n_new(i,j) = (((n(i+1,j)+n(i-1,j))/x^2)+(n(i,j-1)/(D*p)))/((2/x^2)+(1/(D*p)));
            if abs(n_new(i,j)-n(i,j))>err
                err = abs(n_new(i,j)-n(i,j));
            end
            n(i,j) = n_new(i,j);
        end
    end
    iter = iter+1;
    if err<0.5
        break;
    end
    err=0;
end

figure(1);
hold on;
for j=1:T+1
    plot(xgrid, (n(1:N+1, j))); 
end
 xlabel("x")
 ylabel("concentration")
 title("numerical")    
     

for j=2:T+1
    for i=1:N+1
        n_a(i,j) = 10^3*erfc(xgrid(i)/(2*sqrt(D*tgrid(j))));
    end
end

figure(2); %analytical
hold on;
for j=1:T+1
    plot(xgrid, (n_a(1:N+1, j))); %log10? gives straightlines
end
     xlabel("x")
     ylabel("concentration")
     title("analytical")


            