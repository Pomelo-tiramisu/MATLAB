% peaks function
% By PSO

clc;clear;
f =@(x,y) 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
    - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
    - 1/3*exp(-(x+1).^2 - y.^2) ;

seed=123;
rng(seed);
n=2;
w=0.1;w1=0.2;w2=0.5;
c=1;c1=1;c2=2;
p=input('How many particle=(e.g.50)? ');
iter=input('How many iteration=(e.g.12)? ');
% initial step

for i=1:p
    X(i)=rand();Y(i)=rand();
    X(i)=(0.5-X(i))*6;Y(i)=(0.5-Y(i))*6;
end
Z=f(X,Y);Zmax=max(Z);
for i=1:p;switch Zmax;case Z(i);xmax=X(i);ymax=Y(i);end;end
for i=1:p;x_global(i)=xmax-X(i);y_global(i)=ymax-Y(i);end

for i=1:p
    x(1,i)=X(i);y(1,i)=Y(i);z(1,i)=Z(i);
   
    % x(2,i)=x(i)+(0+0+w2*(x_global(i));
    x(2,i)=x(1,i)+w2*x_global(i);y(2,i)=y(1,i)+w2*y_global(i);
    z(2,i)=f(x(2,i),y(2,i));
    
end


% local max e.g(z(1,1) vs z(2,1))
for g=1:iter
for i=1:p
    for j=1:n
        local_zmax=max(z(:,i));
        x_moment(i)=x(n,i)-x(n-1,i);y_moment(i)=y(n,i)-y(n-1,i);
        switch local_zmax
            case z(j,i);xmax(i)=x(j,i);ymax(i)=y(j,i);break
        end
    end
end
for i=1:p 
    x_local(i)=xmax(i)-x(n,i);y_local(i)=ymax(i)-y(n,i);
    x(n+1,i)=x(n,i)+(w*c*x_moment(i)+w1*c1*x_local(i)+w2*c2*x_global(i));
    y(n+1,i)=y(n,i)+(w*c*y_moment(i)+w1*c1*y_local(i)+w2*c2*y_global(i));
    z(n+1,i)=f(x(n+1,i),y(n+1,i));
%     c=c/2;c1=c1/2;c2=c2/2;
end
n=n+1;
zmax=max(max(z));
for i=1:p
    for j=1:n
        switch zmax
            case z(j,i);Xmax=x(n,i);Ymax=y(n,i);break
        end
    end
end
for i=1:p
    x_global(i)=Xmax-x(n,i);y_global(i)=Ymax-y(n,i);
end
end

% draw
for j=1:n
    figure
    for i=1:p
        plot3(x(j,i),y(j,i),z(j,i),'o','MarkerFaceColor','b');
        xx = linspace(-3, 3, 30);		% 在 x 軸 [-3,3] 之間取 30 點
        yy = linspace(-3, 3, 30);		% 在 y 軸 [-3,3] 之間取 30 點
        [xx,yy] = meshgrid(xx, yy);		% xx 和 yy 都是 25×25 的矩陣
        zz = f(xx,yy);	% zz 也是 30*2 的矩陣
%         surf(xx, yy, zz);				% 畫出立體曲面圖
        contour(xx, yy, zz, 20);
        colormap('default');				% 顏色改回預設值
        xlim([-3,3]);ylim([-3,3]);zlim([-10,10]);
        hold on
    end
end

% plot every point (x,y,z)
% for i=1:p
%     figure
%     plot(1:n,x(:,i),'-o',1:n,y(:,i),'-.>',1:n,z(:,i),':+');
% end

figure
for i=1:p
    plot(1:n,z(:,i),'-o')
    hold on
end

