clc;clear;
ne=input('希望初始幾個點');
n=input('n=(ex.35)?');
seed=1234;
rng(seed);
for j=1:ne
 x(j)=10*rand()-6
 while x(j)<-2.3||x(j)>2.3
 x(j)=10*rand()-6   
 end    
end    
for j=1:ne
y(j)=10*rand()-6
while y(j)<-2.3||y(j)>2.3
 y(j)=10*rand()-6   
 end    
end    
%n=30;
dots='+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>';%ploting symbols
color='mbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcy'; %color of lines/symbols;

j2=5; %for figure
for j=1:ne   
pave0=0;pmax0=0;nx=90;ny=nx;
rmax=2.0;rmin=0.5;      %allowable range (aspect ratio)
smax=0.02;smin=0;       %allowable range (slider slope)
t(j)=1;
r=0.5;
z=0;
error=1;err=0.01;
error=1;
asim=0.5;nsim=2;
psim=asim/nsim/(2^0.5)*((nsim+1)^0.5+nsim-1)
qsim=asim/nsim/(2^0.5)*((nsim+1)^0.5-1)

% 1st point of the simplex
x1(j)=x(j)+psim
y1(j)=y(j)+qsim
x2(j)=x(j)+qsim
y2(j)=y(j)+psim
xmax=max([x(j),x1(j),x2(j)]);
xmin=min([x(j),x1(j),x2(j)]);
ymax=max([y(j),y1(j),y2(j)]);
ymin=min([y(j),y1(j),y2(j)]);
while error>err&&xmin>=-3&&xmax<=3&&ymin>=-3&&ymax<=3
% draw
    xvalue(t(j))=x(j);
    x1value(t(j))=x1(j);
    x2value(t(j))=x2(j);
    yvalue(t(j))=y(j);
    y1value(t(j))=y1(j);
    y2value(t(j))=y2(j);
[pave]=top(x(j),y(j));
[pave1]=top(x1(j),y1(j));
[pave2]=top(x2(j),y2(j));

    pavevalue(t(j))=pave;
    pave1value(t(j))=pave1;
    pave2value(t(j))=pave2;
    Pmax(t(j))=max([pave,pave1,pave2]);
    if Pmax(t(j))==pave
        xmeritvalue(t(j))=x(j);ymeritvalue(t(j))=y(j);
    elseif Pmax(t(j))==pave1
        xmeritvalue(t(j))=x1(j);ymeritvalue(t(j))=y1(j);
    else
        xmeritvalue(t(j))=x2(j);ymeritvalue(t(j))=y2(j);
    end
pave_min=min([pave,pave1,pave2]); %pave_min the worst value of three points
pave_max0=max([pave,pave1,pave2]); %pave_max0 the better value of three points

err1=pave_max0-pave_min;
% compare pave best value only
    if pave_max0==pave
        x1ave=x(j);x2ave=y(j);pave0=pave;
    elseif pave_max0==pave1
        x1ave=x1(j);x2ave=y1(j);pave0=pave1;
    else
        x1ave=x2(j);x2ave=y2(j);pave0=pave2;
    end
if err1>0.001
    % replace the worst value to better one    
        if pave_min==pave%如果點a最爛
            t(j)=t(j)+1;
            %需要中心點及dx,dy
            [xo,yo,dx,dy]=dd(x1(j),x2(j),y1(j),y2(j),x(j),y(j));
            [x3,x4,y3,y4]=exp_mirr(xo,yo,dx,dy);
            [pave3]=top(x3,y3);
            [pave4]=top(x4,y4);
            pave_min=min([pave,pave3,pave4]); %pave_min the worst value of three points
            pave_max=max([pave,pave3,pave4]); %pave_max the best value of three points
        %擴張或鏡向好
            if pave_min==pave
                fprintf("a1\n");
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave1);
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave2);
                if pave_max==pave4%擴張好
                    x(j)=x4;y(j)=y4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave0);
                else %鏡像好
                    x(j)=x3;y(j)=y3;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave0);
                end    
            %擴張不好    
            else
                [x5,y5]=contra(xo,yo,dx,dy);
                [pave5]=top(x5,y5);
                pave_max=max([pave,pave5]); %pave_max the best value of three points
                %收縮好
                if pave_max==pave5
                    x(j)=x5;y(j)=y5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave0);
                %收縮不好，則重新製造三角形
                else
                    if pave_max0==pave1 %pave1 best value
                    xi=(x1(j)+x2(j))/2;yi=(y1(j)+y2(j))/2;
                    x2(j)=xi;y2(j)=yi;
                    x(j)=x5;y(j)=y5;
                    [pavei]=top(xi,yi);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave5);
                    else
                    xi=(x1(j)+x2(j))/2;yi=(y1(jy)+y2(jy))/2;    
                    x1(j)=xi;y1(jy)=yi;    
                    x(j)=x5;y(jy)=y5;
                    [pavei]=top(xi,yi);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave5);
                    end
                [paveo]=top(xo,yo);    
                [error]=err0(pavei,paveo); 
                error
                end
            end    
        elseif pave_min==pave1%如果點b最爛
            t(j)=t(j)+1;
            %需要中心點及dx,dy
            [xo,yo,dx,dy]=dd(x(j),x2(j),y(j),y2(j),x1(j),y1(j));
            [x3,x4,y3,y4]=exp_mirr(xo,yo,dx,dy);
            [pave3]=top(x3,y3);
            [pave4]=top(x4,y4);
            pave_min=min([pave1,pave3,pave4]); %pave_min the worst value of three points
            pave_max=max([pave1,pave3,pave4]); %pave_max the best value of three points
            %擴張或鏡向好
            if pave_min==pave1
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave);
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave2);
                if pave_max==pave4%擴張好
                    x1(j)=x4;y1(j)=y4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave0);
                else %鏡像好
                    x1(j)=x3;y1(j)=y3;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave0);
                end    
            %擴張不好    
            else
                [x5,y5]=contra(xo,yo,dx,dy);
                [pave5]=top(x5,y5);
                pave_max=max([pave1,pave5]); %pave_max the best value of three points
                %收縮好
                if pave_max==pave5
                    x1(j)=x5;y1(j)=y5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave0);
                %收縮不好，則重新製造三角形
                else
                    if pave_max0==pave
                    xi=(x(j)+x2(j))/2;yi=(y(j)+y2(j))/2;
                    x2(j)=xi;y2(j)=yi;
                    x1(j)=x5;y1(j)=y5;
                    [pavei]=top(xi,yi);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave5);
                    else
                    xi=(x(j)+x2(j))/2;yi=(y(j)+y2(j))/2;
                    x(j)=xi;y(j)=yi;    
                    x1(j)=x5;y1(j)=y5;
                    [pavei]=top(xi,yi);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave5);
                    end
                [paveo]=top(xo,yo);
                [error]=err0(pavei,paveo); 
                error
                end
            end    
        else %如果點c最爛
            t(j)=t(j)+1;
            %需要中心點及dx,dy
            [xo,yo,dx,dy]=dd(x(j),x1(j),y(j),y1(j),x2(j),y2(j));
            [x3,x4,y3,y4]=exp_mirr(xo,yo,dx,dy);
            [pave3]=top(x3,y3);
            [pave4]=top(x4,y4);
            pave_min=min([pave2,pave3,pave4]); %pave_min the worst value of three points
            pave_max=max([pave2,pave3,pave4]); %pave_max the best value of three points
            %擴張或鏡向好
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave);
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave1);
            if pave_min==pave2
                if pave_max==pave4%擴張好
                    x2(j)=x4;y2(j)=y4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave0);
                else %鏡像好
                    x2(j)=x3;y2(j)=y3;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave0);
                end    
            %擴張不好    
            else
                [x5,y5]=contra(xo,yo,dx,dy);
                [pave5]=top(x5,y5);
                pave_max=max([pave2,pave5]); %pave_max the best value of three points
                %收縮好
                if pave_max==pave5
                    x2(j)=x5;y2(j)=y5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave0);
                %收縮不好，則重新製造三角形
                else
                    if pave_max0==pave1
                    xi=(x(j)+x1(j))/2;yi=(y(j)+y1(j))/2;
                    x(j)=xi;y(j)=yi;
                    x2(j)=x5;y2(j)=y5;
                    [pavei]=top(xi,yi);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave5);
                    else
                    xi=(x(j)+x1(j)+x2(j))/3;yi=(y(j)+y1(j)+y2(j))/3;
                    x1(j)=xi;y1(j)=yi;    
                    x2(j)=x5;y2(j)=y5;
                    [pavei]=top(xi,yi);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z,pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z,pave5);
                    end
                [paveo]=top(xo,yo);
                [error]=err0(pavei,paveo);
                error
                end
            end
        end    
else
    error=0.00001
end
    %B.C condition    
    xmax=max([x(j),x1(j),x2(j)]);
    xmin=min([x(j),x1(j),x2(j)]);
    ymax=max([y(j),y1(j),y2(j)]);
    ymin=min([y(j),y1(j),y2(j)]);
    % draw
    xvalue(t(j))=x(j);
    x1value(t(j))=x1(j);
    x2value(t(j))=x2(j);
    yvalue(t(j))=y(j);
    y1value(t(j))=y1(j);
    y2value(t(j))=y2(j);
    [pave]=top(x(j),y(j));
    [pave1]=top(x1(j),y1(j));
    [pave2]=top(x2(j),y2(j));
    pavevalue(t(j))=pave;
    pave1value(t(j))=pave1;
    pave2value(t(j))=pave2;
    
    %plot the path
    Pmax(t(j))=max([pave,pave1,pave2]);
    if Pmax(t(j))==pave
        xmeritvalue(t(j))=x(j);ymeritvalue(t(j))=y(j);
    elseif Pmax(t(j))==pave1
        xmeritvalue(t(j))=x1(j);ymeritvalue(t(j))=y1(j);
    else
        xmeritvalue(t(j))=x2(j);ymeritvalue(t(j))=y2(j);
    end
    %draw search step
    
    %figure(j0)
    figure(3)
    %for i0=1:t(j)
    plot(Pmax,color(t(j))); 
    xlabel('search step');
    ylabel('Merit(of Objection Function)');
    title('Merit Pave by Simplex method');
    grid on
    hold on
    %end
    
    %draw 3d path
    %figure(j1)
    figure(4)
    plot3(xmeritvalue,ymeritvalue,Pmax,color(t(j)));
    hold on
    xlabel('slope1');
    ylabel('slope2');
    zlabel('average pressure');
    title('Merit Pave by Simplex method');
    

end
    Pmax=[];xmeritvalue=[];ymeritvalue=[];
    
    %draw simplex
    %j2=j1+1;
    %figure(j2)
    %for k=1:t(j)
    %patch([xvalue(k),x1value(k),x2value(k)],[yvalue(k),y1value(k),y2value(k)],[pavevalue(k);pave1value(k);pave2value(k)]);
    %end
    %xlabel('slope1');
    %ylabel('slope2');
    %hold on;
    %colorbar;
    
    %draw simplex
    %j2=j1+1;
    %figure(j2)
    figure(9)
    for k=1:t(j)
    patch([xvalue(k),x1value(k),x2value(k)],[yvalue(k),y1value(k),y2value(k)],[pavevalue(k);pave1value(k);pave2value(k)],color(k));
    %patch([xvalue(k),x1value(k),x2value(k)],[yvalue(k),y1value(k),y2value(k)],[pavevalue(k);pave1value(k);pave2value(k)],'EdgeColor',color(k),'FaceColor','none','LineWidth',2);
    end
    xlabel('x-axis');
    ylabel('y-axis');
    title('Peaks function by Simplex method');
    hold on;
    parula;
    
    %draw contour
    %figure(j2)
    figure(9)
    jj=0;
    for xx1=-3:0.1:3
        jj=jj+1;
        ii=0;
        for yy1=-3:0.1:3
            ii=ii+1;
            [pavec]=top(xx1,yy1);
            top1(ii,jj)=pavec;
        end
    end
    
    xx2 = linspace(-3,3,61);
    yy2 = linspace(-3,3,61);
    contour (xx2,yy2,top1); 
    hold on;
    
    %j0=j2;
    xvalue=[];x1value=[];x2value=[];
    yvalue=[];y1value=[];y2value=[];
    pavevalue=[];pave1value=[];pave2value=[];
    j2=j2+1;




end
t
%xvalue
%x1value
%x2value
%yvalue
%y1value
%y2value
%pavevalue
%pave1value
%pave2value
% fprintf("各s及壓力平均\n")
% fprintf('%12.3f',r,x1ave,x2ave,z,pave0);fprintf('\n')
% fprintf("各s平均及壓力最大\n")
% 
% ratio=rmin+r*(rmax-rmin);
% slope1=smin+x1ave*(smax-smin);
% slope2=smin+x2ave*(smax-smin);
% slope3=smin+z*(smax-smin);
% fprintf("各s平均及壓力平均\n")
% fprintf('%9.4f',ratio,slope1,slope2,slope3);fprintf('\n')

%draw peaks function

max=0;
xend=0;
yend=0;
tic;
for i=1:n
    for j=1:n
x=linspace (-3,3,n);
y=linspace (-3,3,n);
[xx,yy]=meshgrid(x,y); %xx&yy皆示50*50矩陣
zz=3*(1-xx).^2.*exp(-xx.^2-(yy+1).^2)....
    -10*(xx./5-xx.^3-yy.^5).*exp(-xx.^2-yy.^2)....
    -1/3*exp(-(xx+1).^2-yy.^2);
 if max<zz(i,j)
 max=zz(i,j);
 xend=-3+i*(6/n);
 yend=-3+j*(6/n);
end;
end;
end;
toc;

figure(4)
surf(xx,yy,zz);
xlabel('x-axis');
ylabel('y-axis');
zlabel('z-axis');
title('peaks function');
grid on
hold on



    
%draw peaks function
%a=0;
%b=0;
%for u=1:20
    %a=a+0.05;
    %b=0;
    %for v=1:20
    %b=b+0.05;
    %[pave_zz,pmax_zz,h_zz]=brg_slider(r,a,b,z,nx,rmax,rmin,smax,smin);
    %fw(v)=pave_zz;
    %ans(u,v)=fw(v);
    %end
%end
%figure(4)
%a=linspace (0,1,20);
%b=linspace (0,1,20);
%[aa,bb]=meshgrid(a,b); %aa&bb皆示n*n矩陣
%surf(aa,bb,ans);
%colormap('jet')
%hold on

    %xlabel('slope1');
    %ylabel('slope2');
    %zlabel('average pressure');
    %title('bearning optimization')
    
%draw simplex
%X=[xvalue;x1value;x2value];
%Y=[yvalue;y1value;y2value];
%Z=[pavevalue;pave1value;pave2value];
%figure(3);
%for i=1:10
%patch([xvalue(i),x1value(i),x2value(i)],[yvalue(i),y1value(i),y2value(i)],[pavevalue(i);pave1value(i);pave2value(i)]);
%end
%hold on;
%colorbar;

%determine how many steps to get merit point

function [pave]=top(xx,yy)
pave=3*(1-xx).^2.*exp(-xx.^2-(yy+1).^2)....
    -10*(xx./5-xx.^3-yy.^5).*exp(-xx.^2-yy.^2)....
    -1/3*exp(-(xx+1).^2-yy.^2);
end

function [xo,yo,dx,dy]=dd(x1,x2,y1,y2,x,y)
xo=(x1+x2)/2;
yo=(y1+y2)/2;
dx=(x1+x2)/2-x;
dy=(y1+y2)/2-y;
end
function [x3,x4,y3,y4]=exp_mirr(xo,yo,dx,dy)
x3=xo+dx;
x4=xo+2*dx;
y3=yo+dy;
y4=yo+2*dy;
end
function [x5,y5]=contra(xi,yi,dx,dy)
x5=xi-0.5*dx;
y5=yi-0.5*dy;
end
function  [error]=err0(pavei,paveo)
error=sqrt((pavei-paveo)^2/3);
end