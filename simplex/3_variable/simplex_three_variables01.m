clc;clear;
ne=input('How many points you want to spread?');
seed=1234;
rng(seed);
%random for 1st 3 variables
for j=1:ne
 x(j)=rand()
 while  x(j)>0.85
 x(j)=rand()    
 end
end    
for j=1:ne
y(j)=rand()
while  y(j)>0.85
 y(j)=rand()    
 end
end
for j=1:ne
z(j)=rand()
while  z(j)>0.85
 z(j)=rand()    
 end
end
color='mbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcy';
for j=1:ne   
pave0=0;pmax0=0;nx=90;ny=nx;
rmax=2.0;rmin=0.5;      %allowable range (aspect ratio)
smax=0.02;smin=0;       %allowable range (slider slope)
t(j)=1;
r=0.5;
error=1;err=0.01;
error=1;
asim=0.2;nsim=2;
psim=asim/nsim/(2^0.5)*((nsim+1)^0.5+nsim-1)
qsim=asim/nsim/(2^0.5)*((nsim+1)^0.5-1)

% 1st point of the simplex
x1(j)=x(j)+psim;y1(j)=y(j)+qsim;z1(j)=z(j)+qsim;
x2(j)=x(j)+qsim;y2(j)=y(j)+psim;z2(j)=z(j)+qsim
x3(j)=x(j)+qsim;y3(j)=y(j)+qsim;z3(j)=z(j)+psim
while error>err
    % if over the boundary than change the value
if x(j)<0||x1(j)<0||x2(j)<0||x3(j)<0||x(j)>1||x1(j)>1||x2(j)>1||x3(j)>1
    [xxxx0,xxxx1,xxxx2,xxxx3]=xyz(x(j),x1(j),x2(j),x3(j));
    x(j)=xxxx0;x1(j)=xxxx1;x2(j)=xxxx2;x3(j)=xxxx3;
end    
if y(j)<0||y1(j)<0||y2(j)<0||y3(j)<0||y(j)>1||y1(j)>1||y2(j)>1||y3(j)>1
     [yyyy0,yyyy1,yyyy2,yyyy3]=xyz(y(j),y1(j),y2(j),y3(j));
     y(j)=yyyy0;y1(j)=yyyy1;y2(j)=yyyy2;y3(j)=yyyy3;
end    
if z(j)<0||z1(j)<0||z2(j)<0||z3(j)<0||z(j)>1||z1(j)>1||z2(j)>1||z3(j)>1
    [zzzz0,zzzz1,zzzz2,zzzz3]=xyz(z(j),z1(j),z2(j),z3(j));
    z(j)=zzzz0;z1(j)=zzzz1;z2(j)=zzzz2;z3(j)=zzzz3;
end        
 % draw
xvalue(t(j))=x(j);x1value(t(j))=x1(j);x2value(t(j))=x2(j);x3value(t(j))=x3(j);
yvalue(t(j))=y(j);y1value(t(j))=y1(j);y2value(t(j))=y2(j);y3value(t(j))=y3(j);
zvalue(t(j))=z(j);z1value(t(j))=z1(j);z2value(t(j))=z2(j);y3value(t(j))=z3(j);
[pave,pmax,h]=brg_slider(r,x(j),y(j),z(j),nx,rmax,rmin,smax,smin); 
[pave1,pmax1,h1]=brg_slider(r,x1(j),y1(j),z1(j),nx,rmax,rmin,smax,smin);
[pave2,pmax2,h2]=brg_slider(r,x2(j),y2(j),z2(j),nx,rmax,rmin,smax,smin);
[pave3,pmax3,h3]=brg_slider(r,x3(j),y3(j),z3(j),nx,rmax,rmin,smax,smin);
pavevalue(t(j))=pave;pave1value(t(j))=pave1;pave2value(t(j))=pave2;pave3value(t(j))=pave3;
Pmax(t(j))=max([pave,pave1,pave2,pave3]);

if Pmax(t(j))==pave
xmeritvalue(t(j))=x(j);ymeritvalue(t(j))=y(j);zmeritvalue(t(j))=z(j);
elseif Pmax(t(j))==pave1
xmeritvalue(t(j))=x1(j);ymeritvalue(t(j))=y1(j);zmeritvalue(t(j))=z1(j);
elseif Pmax(t(j))==pave2
xmeritvalue(t(j))=x2(j);ymeritvalue(t(j))=y2(j);zmeritvalue(t(j))=z2(j);
else
xmeritvalue(t(j))=x3(j);ymeritvalue(t(j))=y3(j);zmeritvalue(t(j))=z3(j);
end

pave_min=min([pave,pave1,pave2,pave3]); %pave_min the worst value of three points
pave_max0=max([pave,pave1,pave2,pave3]); %pave_max0 the better value of three points
pmax_min=min([pmax,pmax1,pmax2,pmax3]); %pave_min the worst value of three points
pmax_max0=max([pmax,pmax1,pmax2,pmax3]); %pave_max0 the better value of three points
err1=pave_max0-pave_min;

% compare pave best value only
if pave_max0==pave
x1ave=x(j);x2ave=y(j);x3ave=z(j);pave0=pave;have=h;
elseif pave_max0==pave1
x1ave=x1(j);x2ave=y1(j);x3ave=z1(j);pave0=pave1;have=h1;
elseif pave_max0==pave2
x1ave=x2(j);x2ave=y2(j);x3ave=z2(j);pave0=pave2;have=h2;
else
x1ave=x3(j);x2ave=y3(j);x3ave=z3(j);pave0=pave3;have=h3;
end

% compare pmax best value only
if pmax_max0==pave
s1xxx=x(j);s2xxx=y(j);s3xxx=z(j);pmax0=pmax;hmax=h;
elseif pmax_max0==pave1
s1xxx=x1(j);s2xxx=y1(j);s3xxx=z1(j);pmax0=pmax1;hmax=h1;
elseif pmax_max0==pave2
s1xxx=x2(j);s2xxx=y2(j);s3xxx=z2(j);pmax0=pmax2;hmax=h2;
else
s1xxx=x3(j);s2xxx=y3(j);s3xxx=z3(j);pmax0=pmax3;hmax=h3;
end

if err1>0.1
    % replace the worst value to better one    
        if pave_min==pave% if a the worst
            t(j)=t(j)+1;
            %need center point, dx, dy
            [xo,yo,zo,dx,dy,dz]=dd(x1(j),x2(j),x3(j),y1(j),y2(j),y3(j),z1(j),z2(j),z3(j),x(j),y(j),z(j));
            [x4,x5,y4,y5,z4,z5]=exp_mirr(xo,yo,zo,dx,dy,dz);
            [pave4,pmax4,h4]=brg_slider(r,x4,y4,z4,nx,rmax,rmin,smax,smin);
            [pave5,pmax5,h5]=brg_slider(r,x5,y5,z5,nx,rmax,rmin,smax,smin);
            pave_min=min([pave,pave4,pave5]); %pave_min the worst value of three points
            pave_max=max([pave,pave4,pave5]); %pave_max the best value of three points
            %compare expansion or reflection
            if pave_min==pave
                fprintf("a1\n");
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                if pave_max==pave5 % expansion better
                    x(j)=x5;y(j)=y5;z(j)=z5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave0);
                else % reflection better
                    x(j)=x4;y(j)=y4;z(j)=z4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave0);
                end    
            %expansion and reflection bad   
            else
                [x6,y6,z6]=contra(xo,yo,zo,dx,dy,dz);
                [pave6,pmax6,h6]=brg_slider(r,x6,y6,z6,nx,rmax,rmin,smax,smin);
                pave_max=max([pave,pave6]); %pave_max the best value of three points
                % contraction better
                if pave_max==pave6
                    x(j)=x6;y(j)=y6;z(j)=z6;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave0);
                %contraction bad than overall contraction
                else
                    if pave_max0==pave1 %pave1 best value    
                    [xi,xii,xiii]=newsimplex(x1(j),x(j),x2(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y1(j),y(j),y2(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z1(j),z(j),z2(j),z3(j));
                    x(j)=xi;x2(j)=xii;x3(j)=xiii;
                    y(j)=yi;y2(j)=yii;y3(j)=yiii;
                    z(j)=zi;z2(j)=zii;z3(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    
                    elseif pave_max0==pave2 %pave2 best value
                    [xi,xii,xiii]=newsimplex(x2(j),x(j),x1(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y2(j),y(j),y1(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z2(j),z(j),z1(j),z3(j));
                    x(j)=xi;x1(j)=xii;x3(j)=xiii;
                    y(j)=yi;y1(j)=yii;y3(j)=yiii;
                    z(j)=zi;z1(j)=zii;z3(j)=ziii;
     
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    else %pave3 best value
                    [xi,xii,xiii]=newsimplex(x3(j),x(j),x1(j),x2(j));
                    [yi,yii,yiii]=newsimplex(y3(j),y(j),y1(j),y2(j));
                    [zi,zii,ziii]=newsimplex(z3(j),z(j),z1(j),z2(j));
                    x(j)=xi;x1(j)=xii;x2(j)=xiii;
                    y(j)=yi;y1(j)=yii;y2(j)=yiii;
                    z(j)=zi;z1(j)=zii;z2(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);    
                    end
                [paveo,pmaxo,ho]=brg_slider(r,xo,yo,zo,nx,rmax,rmin,smax,smin);
                [error]=err0(pavei,paveii,paveiii,paveo); %judge convergence
                error
                end
            end    
        elseif pave_min==pave1% if b the worst
            t(j)=t(j)+1;
            %need center point, dx, dy
            [xo,yo,zo,dx,dy,dz]=dd(x(j),x2(j),x3(j),y(j),y2(j),y3(j),z(j),z2(j),z3(j),x1(j),y1(j),z1(j));
            [x4,x5,y4,y5,z4,z5]=exp_mirr(xo,yo,zo,dx,dy,dz);
            [pave4,pmax4,h4]=brg_slider(r,x4,y4,z4,nx,rmax,rmin,smax,smin);
            [pave5,pmax5,h5]=brg_slider(r,x5,y5,z5,nx,rmax,rmin,smax,smin);
            pave_min=min([pave1,pave4,pave5]); %pave_min the worst value of three points
            pave_max=max([pave1,pave4,pave5]); %pave_max the best value of three points
            %expansion or reflection better
            if pave_min==pave1
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                if pave_max==pave5% expansion better
                    x1(j)=x5;y1(j)=y5;z1(j)=z5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave0);
                else % reflection better
                    x1(j)=x4;y1(j)=y4;z1(j)=z4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave0);
                end    
            %expansion and reflection bad    
            else
                [x6,y6,z6]=contra(xo,yo,zo,dx,dy,dz);
                [pave6,pmax6,h6]=brg_slider(r,x6,y6,z6,nx,rmax,rmin,smax,smin);
                pave_max=max([pave1,pave6]); %pave_max the best value of three points
                %contraction better
                if pave_max==pave6
                    x1(j)=x6;y1(j)=y6;z1(j)=z6;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave0);
                %contraction bad than overall contraction 
                else
                    if pave_max0==pave %pave0 best value
                    [xi,xii,xiii]=newsimplex(x(j),x1(j),x2(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y(j),y1(j),y2(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z(j),z1(j),z2(j),z3(j));
                    x1(j)=xi;x2(j)=xii;x3(j)=xiii;
                    y1(j)=yi;y2(j)=yii;y3(j)=yiii;
                    z1(j)=zi;z2(j)=zii;z3(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    elseif pave_max0==pave2 %pave2 best value
                    [xi,xii,xiii]=newsimplex(x2(j),x1(j),x(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y2(j),y1(j),y(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z2(j),z1(j),z(j),z3(j));
                    x1(j)=xi;x(j)=xii;x3(j)=xiii;
                    y1(j)=yi;y(j)=yii;y3(j)=yiii;
                    z1(j)=zi;z(j)=zii;z3(j)=ziii;
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    else %pave3 best value
                    [xi,xii,xiii]=newsimplex(x3(j),x1(j),x(j),x2(j));
                    [yi,yii,yiii]=newsimplex(y3(j),y1(j),y(j),y2(j));
                    [zi,zii,ziii]=newsimplex(z3(j),z1(j),z(j),z2(j));
                    x1(j)=xi;x(j)=xii;x2(j)=xiii;
                    y1(j)=yi;y(j)=yii;y2(j)=yiii;
                    z1(j)=zi;z(j)=zii;z2(j)=ziii;
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii); 
                    end
                
                [paveo,pmaxo,ho]=brg_slider(r,xo,yo,zo,nx,rmax,rmin,smax,smin);
                [error]=err0(pavei,paveii,paveiii,paveo);%judge convergence
                error
                end
            end    
        elseif pave_min==pave2 %if c the worst
            t(j)=t(j)+1;
            %need center point, dx, dy
            [xo,yo,zo,dx,dy,dz]=dd(x(j),x1(j),x3(j),y(j),y1(j),y3(j),z(j),z1(j),z3(j),x2(j),y2(j),z2(j));
            [x4,x5,y4,y5,z4,z5]=exp_mirr(xo,yo,zo,dx,dy,dz);
            [pave4,pmax4,h4]=brg_slider(r,x4,y4,z4,nx,rmax,rmin,smax,smin);
            [pave5,pmax5,h5]=brg_slider(r,x5,y5,z5,nx,rmax,rmin,smax,smin);
            pave_min=min([pave2,pave4,pave5]); %pave_min the worst value of three points
            pave_max=max([pave2,pave4,pave5]); %pave_max the best value of three points
            %expansion or reflection better
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
            if pave_min==pave2
                if pave_max==pave5%expansion better
                    x2(j)=x5;y2(j)=y5;z2(j)=z5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave0);
                else %reflection better
                    x2(j)=x4;y2(j)=y4;z2(j)=z4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave0);
                end    
            %expansion and reflection bad    
            else
                [x6,y6,z6]=contra(xo,yo,zo,dx,dy,dz);
                [pave6,pmax6,h6]=brg_slider(r,x6,y6,z6,nx,rmax,rmin,smax,smin);
                pave_max=max([pave2,pave6]); %pave_max the best value of three points
                %contraction better
                if pave_max==pave6
                    x2(j)=x6;y2(j)=y6;z2(j)=z6;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave0);
                %contraction bad than overall contraction
                else
                    if pave_max0==pave1 %pave1 best value
                    [xi,xii,xiii]=newsimplex(x1(j),x(j),x2(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y1(j),y(j),y2(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z1(j),z(j),z2(j),z3(j));
                    x(j)=xi;x2(j)=xii;x3(j)=xiii;
                    y(j)=yi;y2(j)=yii;y3(j)=yiii;
                    z(j)=zi;z2(j)=zii;z3(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    elseif pave_max0==pave  %pave best value
                    [xi,xii,xiii]=newsimplex(x(j),x1(j),x2(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y(j),y1(j),y2(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z(j),z1(j),z2(j),z3(j));
                    x1(j)=xi;x2(j)=xii;x3(j)=xiii;
                    y1(j)=yi;y2(j)=yii;y3(j)=yiii;
                    z1(j)=zi;z2(j)=zii;z3(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    else %pave3 best value
                    [xi,xii,xiii]=newsimplex(x3(j),x1(j),x2(j),x(j));
                    [yi,yii,yiii]=newsimplex(y3(j),y1(j),y2(j),y(j));
                    [zi,zii,ziii]=newsimplex(z3(j),z1(j),z2(j),z(j));
                    x1(j)=xi;x2(j)=xii;x(j)=xiii;
                    y1(j)=yi;y2(j)=yii;y(j)=yiii;
                    z1(j)=zi;z2(j)=zii;z(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave3);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    end
                [paveo,pmaxo,ho]=brg_slider(r,xo,yo,zo,nx,rmax,rmin,smax,smin);
                [error]=err0(pavei,paveii,paveiii,paveo); 
                error
                end
            end
        else %pave3 worst
            t(j)=t(j)+1;
            %need center point, dx, dy
            [xo,yo,zo,dx,dy,dz]=dd(x(j),x1(j),x2(j),y(j),y1(j),y2(j),z(j),z1(j),z2(j),x3(j),y3(j),z3(j));
            [x4,x5,y4,y5,z4,z5]=exp_mirr(xo,yo,zo,dx,dy,dz);
            [pave4,pmax4,h4]=brg_slider(r,x4,y4,z4,nx,rmax,rmin,smax,smin);
            [pave5,pmax5,h5]=brg_slider(r,x5,y5,z5,nx,rmax,rmin,smax,smin);
            pave_min=min([pave3,pave4,pave5]); %pave_min the worst value of three points
            pave_max=max([pave3,pave4,pave5]); %pave_max the best value of three points
            %expansion and reflection bad
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
            fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
            if pave_min==pave3
                if pave_max==pave5%expansion better
                    x3(j)=x5;y3(j)=y5;z3(j)=z5;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave0);
                else %reflection better
                    x3(j)=x4;y3(j)=y4;z3(j)=z4;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave0);
                end    
            %expansion and reflection bad  
            else
                [x6,y6,z6]=contra(xo,yo,zo,dx,dy,dz);
                [pave6,pmax6,h6]=brg_slider(r,x6,y6,z6,nx,rmax,rmin,smax,smin);
                pave_max=max([pave3,pave6]); %pave_max the best value of three points
                %contraction better
                if pave_max==pave6
                    x3(j)=x6;y3(j)=y6;z3(j)=z6;pave0=pave_max;
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x3(j),y3(j),z3(j),pave0);
                %收縮不好，則重新製造三角形
                else
                    if pave_max0==pave1 %pave1 best value
                    [xi,xii,xiii]=newsimplex(x1(j),x(j),x2(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y1(j),y(j),y2(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z1(j),z(j),z2(j),z3(j));
                    x(j)=xi;x2(j)=xii;x3(j)=xiii;
                    y(j)=yi;y2(j)=yii;y3(j)=yiii;
                    z(j)=zi;z2(j)=zii;z3(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x1(j),y1(j),z1(j),pave1);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    elseif pave_max0==pave  %pave best value
                    [xi,xii,xiii]=newsimplex(x(j),x1(j),x2(j),x3(j));
                    [yi,yii,yiii]=newsimplex(y(j),y1(j),y2(j),y3(j));
                    [zi,zii,ziii]=newsimplex(z(j),z1(j),z2(j),z3(j));
                    x1(j)=xi;x2(j)=xii;x3(j)=xiii;
                    y1(j)=yi;y2(j)=yii;y3(j)=yiii;
                    z1(j)=zi;z2(j)=zii;z3(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x(j),y(j),z(j),pave);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    else %pave2 best value
                    [xi,xii,xiii]=newsimplex(x2(j),x1(j),x3(j),x(j));
                    [yi,yii,yiii]=newsimplex(y2(j),y1(j),y3(j),y(j));
                    [zi,zii,ziii]=newsimplex(z2(j),z1(j),z3(j),z(j));
                    x1(j)=xi;x3(j)=xii;x(j)=xiii;
                    y1(j)=yi;y3(j)=yii;y(j)=yiii;
                    z1(j)=zi;z3(j)=zii;z(j)=ziii;
                    
                    [pavei,pmaxi,hi]=brg_slider(r,xi,yi,zi,nx,rmax,rmin,smax,smin);
                    [paveii,pmaxii,hii]=brg_slider(r,xii,yii,zii,nx,rmax,rmin,smax,smin);
                    [paveiii,pmaxiii,hiii]=brg_slider(r,xiii,yiii,ziii,nx,rmax,rmin,smax,smin);
                    
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,x2(j),y2(j),z2(j),pave2);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xi,yi,zi,pavei);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xii,yii,zii,paveii);
                    fprintf('%6.3f %6.3f %6.3f %6.3f %6.3f %8.1f\n',t(j),r,xiii,yiii,ziii,paveiii);
                    end
                [paveo,pmaxo,ho]=brg_slider(r,xo,yo,zo,nx,rmax,rmin,smax,smin);
                [error]=err0(pavei,paveii,paveiii,paveo); 
                error
                end
            end
        end
else
    error=0.00001
end
    %B.C condition    
    xmax=max([x(j),x1(j),x2(j),x3(j)]);xmin=min([x(j),x1(j),x2(j),x3(j)]);
    ymax=max([y(j),y1(j),y2(j),y3(j)]);ymin=min([y(j),y1(j),y2(j),y3(j)]);
    zmax=max([z(j),z1(j),z2(j),z3(j)]);zmin=min([z(j),z1(j),z2(j),z3(j)]);
    % draw
    xvalue(t(j))=x(j);x1value(t(j))=x1(j);x2value(t(j))=x2(j);x3value(t(j))=x3(j);
    yvalue(t(j))=y(j);y1value(t(j))=y1(j);y2value(t(j))=y2(j);y3value(t(j))=y3(j);
    zvalue(t(j))=z(j);z1value(t(j))=z1(j);z2value(t(j))=z2(j);z3value(t(j))=z3(j);
    [pave,pmax,h]=brg_slider(r,x(j),y(j),z(j),nx,rmax,rmin,smax,smin);
    [pave1,pmax1,h1]=brg_slider(r,x1(j),y1(j),z1(j),nx,rmax,rmin,smax,smin);
    [pave2,pmax2,h2]=brg_slider(r,x2(j),y2(j),z2(j),nx,rmax,rmin,smax,smin);
    [pave3,pmax3,h3]=brg_slider(r,x3(j),y3(j),z3(j),nx,rmax,rmin,smax,smin);
    pavevalue(t(j))=pave;pave1value(t(j))=pave1; pave2value(t(j))=pave2; pave3value(t(j))=pave3;
    %plot the path
    Pmax(t(j))=max([pave,pave1,pave2,pave3]);
    if Pmax(t(j))==pave
        xmeritvalue(t(j))=x(j);ymeritvalue(t(j))=y(j);zmeritvalue(t(j))=z(j);
    elseif Pmax(t(j))==pave1
        xmeritvalue(t(j))=x1(j);ymeritvalue(t(j))=y1(j);zmeritvalue(t(j))=z1(j);
    elseif Pmax(t(j))==pave2
        xmeritvalue(t(j))=x2(j);ymeritvalue(t(j))=y2(j);zmeritvalue(t(j))=z2(j);
    else
        xmeritvalue(t(j))=x3(j);ymeritvalue(t(j))=y3(j);zmeritvalue(t(j))=z3(j);
    end
    %draw search step
    figure(3)
    plot(Pmax); 
    xlabel('search step');
    ylabel('Merit(of Objection Function)');
    title('Merit Pave');
    grid on
    hold on

    %draw slope1 slope2 slope3 dots
    figure(4)
    plot3(xmeritvalue,ymeritvalue,zmeritvalue);
    xlabel('slope1');
    ylabel('slope2');
    zlabel('slope3');
    title('x-y-z');
    hold on
    grid on

end
    Pmax=[];xmeritvalue=[];ymeritvalue=[];zmeritvalue=[];
    
    figure(9)
    for k=1:t(j)
        if xvalue(k)<0||yvalue(k)<0||zvalue(k)<0
         colorline='yh';
          colorface='y';
        else 
            if pavevalue(k)<4500
            colorline='rh';
            colorface='r';
            elseif pavevalue(k)<5000
            colorline='bh'; 
            colorface='b';
            elseif pavevalue(k)<5500
            colorline='kh';
             colorface='k';
            elseif pave1value(k)<6000
            colorline='mh';
             colorface='m';
            elseif pave1value(k)<7000
            colorline='gh';
            colorface='g';   
            end
        end    
        plot3(xvalue(k),yvalue(k),zvalue(k),colorline,'MarkerFaceColor',colorface,'MarkerSize',15);
        hold on
        if xvalue(k)<0||yvalue(k)<0||zvalue(k)<0
         colorline='yh';
          colorface='y';
        else
            if pave1value(k)<4500
            colorline='rh';
             colorface='r';
            elseif pave1value(k)<5000
            colorline='bh';
             colorface='b';
            elseif pave1value(k)<5500
            colorline='kh';
             colorface='k';
            elseif pave1value(k)<6000
            colorline='mh';
             colorface='m';
            elseif pave1value(k)<7000
            colorline='gh';
            colorface='g';   
            end
        end
        plot3(x1value(k),y1value(k),z1value(k),colorline,'MarkerFaceColor', colorface,'MarkerSize',15);
        hold on
        if x2value(k)<0||y2value(k)<0||z2value(k)<0
          colorline='yh';
           colorface='y';
        else  
            if pave2value(k)<4500
            colorline='rh';
             colorface='r';
            elseif pave2value(k)<5000
            colorline='bh';
             colorface='b';
            elseif pave2value(k)<6500
            colorline='kh';
             colorface='k';
            elseif pave1value(k)<6000
            colorline='mh';
             colorface='m';
            elseif pave1value(k)<7000
            colorline='gh';
            colorface='g';   
            end
        end    
        plot3(x2value(k),y2value(k),z2value(k),colorline,'MarkerFaceColor', colorface,'MarkerSize',15);
        hold on
        if x3value(k)<0||y3value(k)<0||z3value(k)<0
            colorline='yh';
             colorface='y';
        else
            if pave3value(k)<4500
            colorline='rh';
             colorface='r';
            elseif pave3value(k)<5000
            colorline='bh';
             colorface='b';
            elseif pave3value(k)<5500
            colorline='kh';
             colorface='k';
            elseif pave1value(k)<6000
            colorline='mh';
             colorface='m';
            elseif pave1value(k)<7000
            colorline='gh';
            colorface='g';   
            end 
        end    
        plot3(x3value(k),y3value(k),z3value(k),colorline,'MarkerFaceColor', colorface,'MarkerSize',15);
        hold on

    end
xlabel('slope1');
ylabel('slope2');
zlabel('slope3');
title('Merit of average pressure by Simplex method')
grid on
    xvalue=[];x1value=[];x2value=[];x3value=[];
    yvalue=[];y1value=[];y2value=[];y3value=[];
    zvalue=[];z1value=[];z2value=[];z3value=[];
    pavevalue=[];pave1value=[];pave2value=[];pave3value=[];




end
t

fprintf("各s及壓力平均\n")
fprintf('%12.3f',r,x1ave,x2ave,x3ave,pave0);fprintf('\n')
fprintf("各s平均及壓力最大\n")
fprintf('%12.3f',r,s1xxx,s2xxx,s3xxx,pmax0);fprintf('\n')
ratio=rmin+r*(rmax-rmin);
slope1=smin+x1ave*(smax-smin);
slope2=smin+x2ave*(smax-smin);
slope3=smin+x3ave*(smax-smin);
fprintf("各s平均及壓力平均\n")
fprintf('%9.4f',ratio,slope1,slope2,slope3);fprintf('\n')


for i=1:nx
    hs(i)=have(i,ny/2);  %mid-plane profile
end
%hold on;
figure(1)
plot (hs);
xlabel('grid number');
ylabel('have');
grid on

ratio=rmin+r*(rmax-rmin);
slope1=smin+s1xxx*(smax-smin);
slope2=smin+s2xxx*(smax-smin);
slope3=smin+s3xxx*(smax-smin);
fprintf('%9.4f',ratio,slope1,slope2,slope3);fprintf('\n');


for i=1:nx
    h(i)=hmax(i,ny/2);  %mid-plane profile
end
%hold on;
figure(2)
plot (h);
xlabel('grid number');
ylabel('hmax');
grid on
    
%draw bearing model
a=0;
b=0;
c=0;
for u=1:5
    a=a+0.2;
    b=0;
    for v=1:5
         b=b+0.2;
         c=0;
        for w=1:5
            c=c+0.2;
            [pave_zz,pmax_zz,h_zz]=brg_slider(r,a,b,c,nx,rmax,rmin,smax,smin);
            fw(w)=pave_zz;
            ans(u,v,w)=fw(w);
            if  ans(u,v,w)<4500
            colorline='ro';
            elseif  ans(u,v,w)<5000
            colorline='bo'; 
            elseif  ans(u,v,w)<5500
            colorline='ko';
            elseif  ans(u,v,w)<6000
            colorline='mo';  
            end
            figure(9)
            plot3(a,b,c,colorline);
            grid on
        end
    end
end

function [pave,pmax,h]=brg_slider(r,s1,s2,s3,nx,rmax,rmin,smax,smin)
ny=nx;
nxd=nx/3;
omega=1.96;
hmin=0.004;

ratio=rmin+r*(rmax-rmin);
slope1=smin+s1*(smax-smin);
slope2=smin+s2*(smax-smin);
slope3=smin+s3*(smax-smin);
dx=1.0/nx/ratio;
dy=1.0/ny*ratio;
p=zeros(nx+1,ny+1);
h=zeros(nx+1,ny+1);
hmax=hmin+(slope1+slope2+slope3)*dx*nxd; %max film thickness
    for k=1:ny+1
        for i=1:nxd+1
            h(i,k)=hmax-slope1*dx*(i-1);
        end
        for i=nxd+1:2*nxd+1
            h(i,k)=hmax-slope1*dx*nxd-slope2*dx*(i-nxd-1);
        end
        for i=2*nxd+1:3*nxd+1
            h(i,k)=hmax-(slope1+slope2)*dx*nxd-slope3*dx*(i-2*nxd-1);
        end
    end
    iter=0; pdsum=1.0;
    while pdsum>0.001
      iter=iter+1; pdsum=0.0;
      for k=2:ny
          for i=2:nx
              c1=h(i,k)^3;
              c3=0.75*h(i,k)*h(i,k)*(h(i+1,k)-h(i-1,k));
              
              a=(c3+c1)*dy*dy;
              b=(-c3+c1)*dy*dy;
              c=c1*dx*dx;
              d=c;
              e=2*c1*(dx*dx+dy*dy);
              f=6*(h(i+1,k)-h(i-1,k))*dx*dy*dy/2;
              
              pd=(a*p(i+1,k)+b*p(i-1,k)+c*p(i,k+1)+d*p(i,k-1)-f)/e-p(i,k);
              p(i,k)=p(i,k)+omega*pd; %film pressure
              pdsum=pdsum+pd^2;
          end
      end
    end
    pave=0;
    for i=1:nx+1
        for k=1:ny+1
            pave=pave+p(i,k);   %sum the pressure
        end    
    end
    pave=pave/nx/ny;        %average pressure
    pmax=max(max(p));       %maximum pressure (2d array)
end
function [xo,yo,zo,dx,dy,dz]=dd(x1,x2,x3,y1,y2,y3,z1,z2,z3,x,y,z)
xo=(x1+x2+x3)/3;
yo=(y1+y2+y3)/3;
zo=(z1+z2+z3)/3;
dx=(x1+x2+x3)/3-x;
dy=(y1+y2+y3)/3-y;
dz=(z1+z2+z3)/3-z;
end
function [x4,x5,y4,y5,z4,z5]=exp_mirr(xo,yo,zo,dx,dy,dz)
x4=xo+dx;
x5=xo+2*dx;
y4=yo+dy;
y5=yo+2*dy;
z4=zo+dz;
z5=zo+2*dz;
end
function [x5,y5,z5]=contra(xi,yi,zi,dx,dy,dz)
x5=xi-0.5*dx;
y5=yi-0.5*dy;
z5=zi-0.5*dz;
end
function  [error]=err0(pavei,paveii,paveiii,paveo)
A=sqrt((pavei-paveo)^2/3);
B=sqrt((paveii-paveo)^2/3);
C=sqrt((paveiii-paveo)^2/3);
error=min([A,B,C]);
end
function [xi,xii,xiii]=newsimplex(x1,x,x2,x3)
xi=(x1+x)/2;
xii=(x1+x2)/2;
xiii=(x1+x3)/2;
end
function [xx0,xx1,xx2,xx3]=xyz(x,x1,x2,x3)
   if x<0
    xx0=0;xx1=x1;xx2=x2;xx3=x3;   
   end
   if x1<0
    xx0=x;xx1=0;xx2=x2;xx3=x3;   
   end
   if x2<0
    xx0=x;xx1=x1;xx2=0;xx3=x3;   
   end 
   if x3<0
    xx0=x;xx1=x1;xx2=x2;xx3=0;   
   end
   if x>1
    xx0=1;xx1=x1;xx2=x2;xx3=x3;   
   end
   if x1>1
    xx0=x;xx1=1;xx2=x2;xx3=x3;   
   end
   if x2>1
    xx0=x;xx1=x1;xx2=1;xx3=x3;   
   end 
   if x3>1
    xx0=x;xx1=x1;xx2=x2;xx3=1;   
   end    
end