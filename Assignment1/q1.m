%box dimensions
a = 3000; %nm
b = 120; %nm
x = 1; %grid spacing
nx = (a/x + 1);
ny = (b/x + 1);
v = zeros(nx,ny);
%capacitor dimensions
l = 600; %nm
t = 1; %nm %thickness of plates
d = 6; %nm

%centring the plates in the box
    x1 = ((a-l)/(x*2))+1;
    x2 = ((a+l)/(x*2))+1;
    y1 = ((b-d)/(2*x))+1;
    y2 = ((b+d)/(2*x))+1;
    yy1 = y1-t; %considering plate thickness
    yy2 = y2+t;
    V2 = 0.5;
    V1 = -0.5;
    %boundary conditions
    v(x1:x2,yy1) = V1; %negative plate
    v(x1:x2,y1) = V1;
    v(x1:x2,yy2) = V2; %positive plate
    v(x1:x2,y2) = V2;
    vnew = v;
    e=0;
    %solving for potential
while true
    for i=2:nx-1
        for j=2:ny-1
            if ~(i>=x1 && i<=x2 && (j==y1 || j==y2 || j==yy1 || j==yy2))
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
            Ex(i,j) = -(v(i+1,j)-v(i-1,j))/2;
        end
end
    %y component
for i=2:nx-1
    for j=2:ny-1
       if (i>=x1 && i<=x2 && (j==yy1 || j==y2))
            Ey(i,j) = -(v(i,j)-v(i,j-1));
       elseif (i>=x1 && i<=x2 && (j==y1 || j==yy2))
            Ey(i,j) = -(v(i,j+1)-v(i,j));
       else
            Ey(i,j) = -(v(i,j+1)-v(i,j-1))/2;
        end
    end
end

    %Gauss law
    %since plate 1 is grounded
    epsilon = 8.854*10^-21; %Fnm^-1
    E =  Ex(x2,y2)+Ex(x2,yy2)-Ex(x1,y2)-Ex(x1,yy2)+sum(Ey(x1:x2,yy2))-sum(Ey(x1:x2,y2));
    Q = E*epsilon;
    cap = Q/(V2-V1)*10^9; %convert to m^-1
    capi = (l*epsilon)*10^9/d; %convert to m^-1
    capp = cap - capi;
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



            
                
    
    
    
   