%box dimensions
a = 600; %nm
b = 600; %nm
x = 1; %grid spacing
nx = (a/x + 1);
ny = (b/x + 1);
v = zeros(nx,ny);
%capacitor dimensions
l1 = 20; %nm
l2 = 10; %nm
t = 1; %nm %thickness of plates
d = 10; %nm

%centring the plates in the box 1-left/bottom, 2-right/top
    x11 = a/2; %20nm plate
    x12 = (x11+t)/x;
    x21 = x12+d/x; %10nm plate
    x22 = x21+l2/x;
    y11 = b/2; %20nm plate
    y12 = (y11+l1)/x;
    y21 = y11; %10nm plate
    y22 = y21+t/x;
    V2 = 1;
    V1 = 0;
    %boundary conditions
    v(x11:x12,y11:y12) = V2; %positive plate
    v(x21:x22,y21:y22) = V1; %negative plate
    vnew = v;
    e=0;
    %solving for potential
while true
    for i=2:nx-1
        for j=2:ny-1
            if ~(((i>=x11 && i<=x12)&&(j>=y11 && j<=y12))||((i>=x21 && i<=x22)&&(j>=y21 && j<=y22)))
                vnew(i,j) = (v(i-1,j)+v(i+1,j)+v(i,j-1)+v(i,j+1))/4;
                diff = abs((vnew(i,j)-v(i,j))/vnew(i,j));
                if diff>e
                    e=diff;
                end
                v(i,j) = vnew(i,j);
            end
        end
    end
    if e <= 0.1;
        break;
    end
e = 0;
end

    %solving for E=-grad(V)
    %x component
for i=2:nx-1
    for j=2:ny-1
       if i==x11
            Ex(i,j) = -(v(i,j)-v(i-1,j));
       elseif i==x12
            Ex(i,j) = -(v(i+1,j)-v(i,j));
       else
            Ex(i,j) = -(v(i,j+1)-v(i,j-1))/2;
        end
    end
end
%y component
for i=2:nx-1
    for j=2:ny-1
       if j==y21
            Ey(i,j) = -(v(i,j)-v(i,j-1));
       elseif j==y22
            Ey(i,j) = -(v(i,j+1)-v(i,j));
       else
            Ey(i,j) = -(v(i,j+1)-v(i,j-1))/2;
        end
    end
end

    %Gauss law
    %since plate 2 is grounded (plate 1 is vertical at V2 = 1V)
    epsilon = 8.854*10^-21; %Fnm^-1
    Exsum = sum(Ex(x12, y11:y12))-sum(Ex(x11, y11:y12));
    Eysum = -Ey(x12,y11)-Ey(x11,y11);
    E = Exsum+Eysum;
    Q = E*epsilon;
    cap = Q/(V2-V1)*10^9; %convert to m^-1
    
    %Electric potential
    figure(1);
    [X,Y]=meshgrid(1:nx,1:ny);
    s = surf(Y,X,v','FaceAlpha',0.5)
    xlabel('y')
    ylabel('x')
    zlabel('electric potential')
    title('Electric potential')
    s.EdgeColor = 'none';
    colorbar
    %Equipotential lines
    figure(2);
    [X,Y]=meshgrid(1:nx,1:ny);
    contour(X,Y,v',100)
    xlabel('x')
    ylabel('y')
    title('Equipotential lines')
    colorbar
    %Electric Field
    figure(3);
    [X, Y]=meshgrid(1:nx-1,1:ny-1);
    quiver(X,Y,Ex',Ey',2);
    xlabel('x')
    ylabel('y')
    title('Electric field profile')
    %max electric field
    Emax = Ex.^2+Ey.^2;
    [row, col] = find(ismember(Emax, max(Emax(:))));
    Emaxx = sqrt(Emax(row, col)); %max electric field


    





            
                
    
    
    
   