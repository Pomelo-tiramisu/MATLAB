clc,clear
f=@(x,y) (x-y)+2.*x.^2.+(2.*x.*y+y.^2.);
%先用虎克法找3點
x=0;y=0;
dx=0.2;dy=0.2;
x1=x-dx;y1=y-dy;
x2=x+dx;y2=y+dy;
z=f(x,y);z1=f(x1,y);z2=f(x2,y);
zmin=min([z,z1,z2]);
z0=zmin;
x0=x;y0=y;t=1;
A(t)=x;B(t)=y;
%x
if zmin==z1
 dx=x1-x;t=t+1;   
 x=x1;x2=x1;A(t)=x;B(t)=y;
 z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
 zmin=min([z,z1,z2]);
 %y
 if zmin==z1
     dy=y1-y;t=t+1;
     y=y1;y2=y1;A(t)=x;B(t)=y;
     x3=x+dx;y3=y+dy;z3=f(x3,y3);
     x4=x+0.5*dx;y4=y+0.5*dy;z4=f(x4,y4);
     zmin=min([z1,z3,z4]);
     if zmin==z3
      x=x3;y=y3;t=t+1;A(t)=x;B(t)=y;   
     elseif zmin==z4
      x=x4;y=y4;t=t+1;A(t)=x;B(t)=y;   
     else
       fprintf("斜著超爛大小不好");   
     end    
 elseif zmin==z2
     dy=y2-y;t=t+1;
     y=y2;y1=y2;A(t)=x;B(t)=y;
     x3=x+dx;y3=y+dy;z3=f(x3,y3);
     x4=x+0.5*dx;y4=y+0.5*dy;z4=f(x4,y4);
     zmin=min([z2,z3,z4]);
     if zmin==z3
      x=x3;y=y3;t=t+1;A(t)=x;B(t)=y;   
     elseif zmin==z4
      x=x4;y=y4;t=t+1;A(t)=x;B(t)=y;   
     else
       fprintf("斜著超爛大小不好");   
     end    
 else
   fprintf("y 步伐大小不好");  
 end
%x 
elseif zmin==z2
 dx=x2-x;t=t+1;
 x=x2;x1=x2;A(t)=x;B(t)=y;
 z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
 zmin=min([z,z1,z2]);
 %y
 if zmin==z1
     dy=y1-y;t=t+1;
     y=y1;y2=y1;A(t)=x;B(t)=y;
     x3=x+dx;y3=y+dy;z3=f(x3,y3);
     x4=x+0.5*dx;y4=y+0.5*dy;z4=f(x4,y4);
     zmin=min([z1,z3,z4]);
     if zmin==z3
      x=x3;y=y3;t=t+1;A(t)=x;B(t)=y;   
     elseif zmin==z4
      x=x4;y=y4;t=t+1;A(t)=x;B(t)=y;   
     else
       fprintf("斜著超爛大小不好");   
     end    
 elseif zmin==z2
     dy=y2-y;t=t+1;
     y=y2;y1=y2;A(t)=x;B(t)=y;
     x3=x+dx;y3=y+dy;z3=f(x3,y3);
     x4=x+0.5*dx;y4=y+0.5*dy;z4=f(x4,y4);
     zmin=min([z2,z3,z4]);
     if zmin==z3
      x=x3;y=y3;t=t+1;A(t)=x;B(t)=y;   
     elseif zmin==z4
      x=x4;y=y4;t=t+1;A(t)=x;B(t)=y;  
     else
       fprintf("斜著超爛大小不好");   
     end    
 else
   fprintf("y 步伐大小不好");  
 end    
 
else 
 fprintf("x 步伐大小不好");
end

dx1=0;dy1=dy;
dx2=dx;dy2=dy;

%"5"
x0=x;y0=y;
x1=x-dx1;y1=y-dy1;
x2=x+dx1;y2=y+dy1;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);
%"6"
if zmin==z1
t=t+1;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
t=t+1;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("6 不好"); 
end    

x1=x-dx2;y1=y-dy2;
x2=x+dx2;y2=y+dy2;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);
%"7"
if zmin==z1
dx1=x1-x;dy1=y1-y;t=t+1;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
dx1=x2-x;dy1=y2-y;t=t+1;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("7 不好"); 
end

dx1=dx2;dy1=dy2;
dx2=x-x0;dy2=y-y0;

x3=x+dx2;y3=y+dy2;
x4=x-dx2;y4=y-dy2;
dx3=dx2;dy3=dy2;
z=f(x,y);z3=f(x3,y3);z4=f(x4,y4);
zmin=min([z,z3,z4]);
if zmin==z3
t=t+1;
x=x3;y=y3;A(t)=x;B(t)=y;   
elseif zmin==z4
t=t+1;
x=x4;y=y4;A(t)=x;B(t)=y;
else 
 fprintf("8 不好"); 
end
%"8"
x0=x;y0=y;

%"9"
x1=x-dx1;y1=y-dy1;
x2=x+dx1;y2=y+dy1;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);

if zmin==z1
dx1=x1-x;dy1=y1-y;t=t+1;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
dx1=x2-x;dy1=y2-y;t=t+1;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("9 不好"); 
end

n=1;
while n<2
%"10"

x1=x-dx3;y1=y-dy3;
x2=x+dx3;y2=y+dy3;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);
if zmin==z1
dx1=x1-x;dy1=y1-y;
dx3=x1-x0;dy3=y1-y0;t=t+1;n=3;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
dx1=x2-x;dy1=y2-y;
dx3=x2-x0;dy3=y2-y0;t=t+1;n=3;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("10 不好");
 dx3=dx3/2;
 dy3=dy3/2;
 n=1;
end
x
y
end

n=1;
while n<2
%"11"
x1=x-dx3;y1=y-dy3;
x2=x+dx3;y2=y+dy3;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);
if zmin==z1
t=t+1;n=3;
dx2=x1-x;dy2=y1-y;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
t=t+1;n=3;
dx2=x2-x;dy2=y2-y;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("11 不好");
 dx3=dx3/2;
 dy3=dy3/2;
 n=1;
end
x
y
end

%"12"
x0=x;y0=y;
x1=x-dx1;y1=y-dy1;
x2=x+dx1;y2=y+dy1;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);

if zmin==z1
dx1=x1-x;dy1=y1-y;t=t+1;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
dx1=x2-x;dy1=y2-y;t=t+1;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("12 不好"); 
end

n=1;
while n<2
%"13"
x1=x-dx2;y1=y-dy2;
x2=x+dx2;y2=y+dy2;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);
if zmin==z1
dx1=x1-x;dy1=y1-y;t=t+1;n=3;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
dx1=x2-x;dy1=y2-y;t=t+1;n=3;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("13 不好"); 
 dx2=dx2/2;
 dy2=dy2/2;
 n=1;
end
x
y
end

dx3=x-x0;
dy3=y-y0;
n=1;
while n<2
x1=x-dx3;y1=y-dy3;
x2=x+dx3;y2=y+dy3;
z=f(x,y);z1=f(x1,y1);z2=f(x2,y2);
zmin=min([z,z1,z2]);
if zmin==z1
dx1=x1-x;dy1=y1-y;t=t+1;n=3;
x=x1;x2=x1;y=y1;y2=y1;A(t)=x;B(t)=y;   
elseif zmin==z2
dx1=x2-x;dy1=y2-y;t=t+1;n=3;
x=x2;x1=x2;y=y2;y1=y2;A(t)=x;B(t)=y;
else 
 fprintf("14 不好"); 
 dx3=dx3/2;
 dy3=dy3/2;
 n=1;
end
x
y
f(x,y)
end

%draw
figure(1)
plot(A,B)
hold on
j=0;
for x1=-2:0.1:2
    j=j+1;
    i=0;
    for y1=-2:0.1:2
       i=i+1;
       top(i,j)=(x1-y1)+2*x1*x1+(2*x1*y1+y1*y1); 
    end
end
x2 = linspace(-2,2,41);
y2 = linspace(-2,2,41);
figure(1)
contour (x2,y2,top); 
hold on;