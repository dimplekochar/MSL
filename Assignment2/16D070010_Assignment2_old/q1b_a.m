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

%plot(xgrid, roh); 
%using the 1 -2 1 matrix M to solve MX=N where X is the potential and N is
%the charge density to solve poisson's equation
M = zeros(nx,nx);
M(1,1) = 1;
for i=2:nx-1
  M(i,i) = -2;
  M(i,i-1) = 1;
  M(i,i+1) = 1;
end
M(nx,nx) = -1;
M(nx,nx-1) = 1;

%roh
N(1:xp/x) =  -q*NA*deltx^2/epsi;
N((xp/x)+1:((xn+xp)/x)) =  q*ND*deltx^2/epsi;
%LU decomposition of M
for i=1:nx
    for k=i:nx %upper triangular
         sum = 0; 
        for j=1:i-1
            sum = sum+(L(i,j)*U(j,k)); 
        end 
        U(i,k) = M(i,k)-sum;
    end
    for k=i:nx %lower triangular
        if i==k
            L(i,i) = 1; %diagonal of L is 1
        else
            sum = 0;
            for j=1:i-1
                sum = sum+(L(k,j)*U(j,i));
            end
            L(k,i) = (M(k,i) - sum)/U(i,i);
        end
    end
end
[Lmat, Umat] = lu(M);
%to solve Ly = b, Ux = y where b is charge density vector and x is
%potential vector
%solve Ly = b forward substitution
y(1) = N(1);
for i=2:nx
    y(i) = N(i);
    for j=1:i-1
        y(i) = y(i)-L(i,j)*y(j);
    end
end
%backward substitution
v(1:nx) = 0;
v(nx) = y(nx)/U(nx,nx);
for i=nx-1:-1:1
    v(i) = y(i);
    for j=i+1:nx
        v(i) = v(i) - U(i,j)*v(j);
    end
    v(i) = v(i)/U(i,i);
end
Vmat = M\N';
figure(1);
plot(xgrid,-v);
xlabel('x in cm')
ylabel('V using numerical LU')
figure(2);
plot(xgrid,-Vmat);
xlabel('x in cm')
ylabel('V using A by b Matlab function')
        
  