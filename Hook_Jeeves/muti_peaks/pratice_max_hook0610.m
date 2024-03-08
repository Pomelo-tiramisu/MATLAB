clc;clear;
ne=input('望分多少點');
np=input('望分解析度多少(ex35)');
seed=1234;
rng(seed);
dots='+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>+*oxsph<>';%ploting symbols
color='mbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcy'; %color of lines/symbols;
%color='mbrgkcyrmbrgkcymrbrgkcymrbrgkcyr';
%for j=1:ne
 %x(j)=10*rand()-6
 %while  x(j)<-2.5||x(j)>2.5
 %x(j)=10*rand()-6  
 %end
%end    
%for j=1:ne
%y(j)=10*rand()-6
%while  y(j)<-2.5||y(j)>2.5
 %y(j)=10*rand()-6  
 %end
%end    
for j=1:ne
 x(j)=10*rand()-6
 while  x(j)<-2.3||x(j)>2.3
 x(j)=10*rand()-6  
 end
end    
for j=1:ne
y(j)=10*rand()-6
while  y(j)<-2.3||y(j)>2.3
 y(j)=10*rand()-6  
 end
end    
%pmax0=0;nx=90;ny=nx;
%rmax=2.0;rmin=0.5;      %allowable range (aspect ratio)
%smax=0.02;smin=0;       %allowable range (slider slope)
j0=2;
for j=1:ne
r=0.01;z=0.01;
deltax=1;deltay=1;
pave0=1;ppave=0;
pmax0=0;nx=90;ny=nx;
rmax=2.0;rmin=0.5;      %allowable range (aspect ratio)
smax=0.02;smin=0;       %allowable range (slider slope)
r=0.5;z=0;
t(j)=1;

xave=x(j);
y1(j)=y(j);y2(j)=y(j);yave=y(j);
err=1;
A(t(j))=x(j);
B(t(j))=y(j);
[pave]=top1(x(j),y(j));
 M(t(j))=pave;
fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave);
while err>10^-3&&deltax>0.005&&deltay>0.05&&xave>=-3&&xave<=3&&yave>=-3&&yave<=3
    x1(j)=x(j)-deltax;
    x2(j)=x(j)+deltax;
    [pave]=top1(x(j),y(j));
    [pave1]=top1(x1(j),y1(j));
    [pave2]=top1(x2(j),y2(j));
  
    pave_max=max([pave,pave1,pave2]);

    if pave_max==pave1 %x1較好
        [dx]=dd(x1(j),xave);
        xave=x1(j);x(j)=xave;x2(j)=xave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        y1(j)=y(j)-deltay;
        y2(j)=y(j)+deltay;
        [pave]=top1(x(j),y(j));
        [pave1]=top1(x1(j),y1(j));
        [pave2]=top1(x2(j),y2(j));
        pave_max=max([pave,pave1,pave2]);

        if pave_max==pave1 %y1較好
        [dy]=dd(y1(j),yave);    
        yave=y1(j);y(j)=yave;y2(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end
            
        elseif pave_max==pave2 %y2較好
        [dy]=dd(y2(j),yave);    
        yave=y2(j);y(j)=yave;y1(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end
            
        else %y原值較好
        [dy]=dd(y(j),yave);    
        yave=y(j);y1(j)=yave;y2(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end
        end
    [err]=error0(pave0,ppave);
    ppave=pave0;
    err   
    elseif pave_max==pave2 %x2較好
        [dx]=dd(x2(j),xave);
        xave=x2(j);x(j)=xave;x1(j)=xave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        y1(j)=y(j)-deltay;
        y2(j)=y(j)+deltay;
        [pave]=top1(x(j),y(j));
        [pave1]=top1(x1(j),y1(j));
        [pave2]=top1(x2(j),y2(j));
        pave_max=max([pave,pave1,pave2]); 

        if pave_max==pave1%y1較好
        [dy]=dd(y1(j),yave);    
        yave=y1(j);y(j)=yave;y2(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end    
        elseif pave_max==pave2%y2較好
        [dy]=dd(y2(j),yave);    
        yave=y2(j);y(j)=yave;y1(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end
        else %y原值較好
        [dy]=dd(y(j),yave);    
        yave=y(j);y1(j)=yave;y2(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end    
        end
    [err]=error0(pave0,ppave);
    ppave=pave0;
    err
    else %x原值較好
        [dx]=dd(x(j),xave);
        xave=x(j);x1(j)=xave;x2(j)=xave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        y1(j)=y(j)-deltay;
        y2(j)=y(j)+deltay;
        [pave]=top1(x(j),y(j));
        [pave1]=top1(x1(j),y1(j));
        [pave2]=top1(x2(j),y2(j));
        pave_max=max([pave,pave1,pave2]); 

        if pave_max==pave1%y1較好
        [dy]=dd(y1(j),yave);    
        yave=y1(j);y(j)=yave;y2(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end
        [err]=error0(pave0,ppave);
        ppave=pave0;
        err    
        elseif pave_max==pave2%y2較好
        [dy]=dd(y2(j),yave);    
        yave=y2(j);y(j)=yave;y1(j)=yave;
        pave0=pave_max;
        t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
        fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
        %pattern search
        [x3,y3]=newdot(dx,dy,xave,yave);
        [pave3]=top1(x3,y3);
            if pave3>pave_max
            xave=x3;x(j)=xave;yave=y3;y(j)=yave;
            pave0=pave3;
            t(j)=t(j)+1;A(t(j))=xave;B(t(j))=yave;M(t(j))=pave0;
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xave,yave,z,pave0);
            else
            fprintf("no pattern search")    
            end
        [err]=error0(pave0,ppave);
        ppave=pave0;
        err    
        else %y原值較好 ，縮步伐
         yave=y(j);y1(j)=yave;y2(j)=yave;
         deltax=deltax/2;
         deltay=deltay/2;
        end    
    end
    
%draw search step
figure(3)
%figure(j0)
plot(M,color(t(j)));
xlabel('search step');
ylabel('Merit(of Objection Function)');
title('Merit');
grid on;
hold on

figure(4);
plot(A,B,color(t(j)));
xlabel('slope1');
ylabel('slope2');
zlabel('average pressure');
title('hook method');
hold on;

figure(7);
plot3(A,B,M,color(t(j)));
xlabel('slope1');
ylabel('slope2');
zlabel('average pressure');
title('hook method');
grid on;
hold on;


end 



j0=j0+1;
%hook method
j1=j0+1;
%figure(j1)
%figure(4)
%plot(A,B);
%plot3(A,B,M);
%xlabel('slope1');
%ylabel('slope2');
%zlabel('average pressure');
%title('hook method');
%hold on
j0=j1;



%消除先前的步伐
M=[];
A=[];
B=[];
end
fprintf("各s及壓力平均\n")
fprintf('%12.3f',r,xave,yave,z,pave0);fprintf('\n')
%fprintf("各s平均及壓力最大\n")
%fprintf('%12.3f',rxxx,s1xxx,s2xxx,s3xxx,pmax0);fprintf('\n')
ratio=rmin+r*(rmax-rmin);
slope1=smin+xave*(smax-smin);
slope2=smin+yave*(smax-smin);
slope3=smin+z*(smax-smin);
fprintf("各s平均及壓力平均\n")
fprintf('%9.4f',ratio,slope1,slope2,slope3);fprintf('\n')

%draw peaks function
a=-3;
b=-3;
for u=1:np
    a=a+6/np;
    b=-3;
    for v=1:np
    b=b+6/np;
    [pave_zz]=top1(a,b);
    fw(v)=pave_zz;
    ans(u,v)=fw(v);
    end
end
figure(7)
a=linspace (-3,3,np);
b=linspace (-3,3,np);
[aa,bb]=meshgrid(a,b); %aa&bb皆示n*n矩陣
surf(aa,bb,ans);
hold on

figure(4)
    jj=0;
    for xx1=-3:0.1:3
        jj=jj+1;
        ii=0;
        for yy1=-3:0.1:3
            ii=ii+1;
            [pavec]=top1(xx1,yy1);
            top(ii,jj)=pavec;
        end
    end
    
    xx2 = linspace(-3,3,61);
    yy2 = linspace(-3,3,61);
    contour (xx2,yy2,top); 
    hold on;
t
%plot(A,B,'o');
figure(1)

%figure(5)
%for x1=-1:1:0.1
    %j=j+1;
    %i=0;
    %for y1=-1:1:0.1
       %i=i+1;
       %[pavei,pmaxi,hi]=brg_slider(r,x1,y1,z,nx,rmax,rmin,smax,smin); 
    %end
%end
%x2 = linspace(-1,1,21);
%y2 = linspace(-1,1,21);
%contour (x2,y2,pavei); 
%hold on;

%x4 = linspace(0,1,21);
%y4 = linspace(0,1,21);
%figure(4)
%contour (x4,y4,pavei); 

%hold on;
%ratio=rmin+rxxx*(rmax-rmin);
%slope1=smin+s1xxx*(smax-smin);
%slope2=smin+s2xxx*(smax-smin);
%slope3=smin+s3xxx*(smax-smin);
%fprintf('%9.4f',ratio,slope1,slope2,slope3);fprintf('\n');

%for i=1:nx
    %h(i)=hmax(i,ny/2);  %mid-plane profile
%end
%hold on;
%plot (hs);
function [pave_0]=top1(xx,yy)
pave_0=3*(1-xx).^2.*exp(-xx.^2-(yy+1).^2)....
    -10*(xx./5-xx.^3-yy.^5).*exp(-xx.^2-yy.^2)....
    -1/3*exp(-(xx+1).^2-yy.^2);
end

function [dx]=dd(x1,xave) %後減前
dx=x1-xave;
end
function [x3,y3]=newdot(dx,dy,xave,yave)
x3=xave+0.5*dx;
y3=yave+0.5*dy;
end
function [err]=error0(pave0,ppave)
err=abs((pave0-ppave)/ppave);
end