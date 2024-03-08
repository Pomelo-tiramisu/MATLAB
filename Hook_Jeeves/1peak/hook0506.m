clc;clear;
z=@(x,y) (x-y)+2.*x.^2.+(2.*x.*y+y.^2.);
%times=input('希望比較的次數ex1000=?');
a=input('希望初始點x=(-2~1)?');
b=input('希望初始點y=?(-1~3)');
a0=1; %原始a
b0=1; %原始b
n=input('希望步伐=?');
min=0; %永遠最小
min1=0;
t=1;
err=1.;
A(t)=a;
B(t)=b;
tic;
while a>=-2.&&a<=1.&&b>=-1.&&b<=3&&n>=0.1
   min=z(a,b); 
   %讓n縮小
   a1=a-n;
   a2=a+n;
   b1=b-n;
   b2=b+n;
   %比較方格
  if z(a1,b)<=min   
    t=t+1;
    a0=a;    
    a=a1;
    A(t)=a;
    B(t)=b;
    min=z(a,b);
    m(t)=min;
    fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        if z(a,b1)<min
        t=t+1;
        b0=b;
        b=b1;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
            else
            %斜著走不成立    
            fprintf("  斜著走不成立1");    
            end     
        elseif z(a,b2)<min
        t=t+1;    
        b0=b;
        b=b2;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
            else
            %斜著走不成立    
            fprintf("  斜著走不成立2\n");    
            end
            
        else
        t=t+1;
        bo=b;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
            else
            %斜著走不成立    
            fprintf("  斜著走不成立3");    
            end
        end
   %比較     
  elseif z(a2,b)<=min
    t=t+1;  
    a0=a;   
    a=a2;
    A(t)=a;
    B(t)=b;
    min=z(a,b);
    m(t)=min;
    fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        if z(a,b1)<min
        t=t+1;
        b0=b;
        b=b1;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
            else
            %斜著走不成立    
            fprintf("  斜著走不成立4");    
            end
            
        elseif z(a,b2)<min
        t=t+1;    
        b0=b;
        b=b2;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
         min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);    
            else
            %斜著走不成立    
            fprintf("  斜著走不成立5");    
            end
            
        else
        t=t+1;    
        b0=b;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
            else
            %斜著走不成立      
            fprintf("  斜著走不成立6");    
            end
            
        end    
  else %x原值較好
    t=t+1;  
    a0=a;
    A(t)=a;
    B(t)=b;
    min=z(a,b);
    m(t)=min;
    fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        if z(a,b1)<min
        t=t+1;
        b0=b;
        b=b1;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);     
            else
            %斜著走不成立    
            fprintf("  斜著走不成立7");    
            end
            
        elseif z(a,b2)<min
        t=t+1;    
        b0=b;
        b=b2;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %開始斜著走
        a3=a+(a-a0)/2;
        b3=b+(b-b0)/2;
        min1=z(a3,b3);
            if min1<min
            t=t+1;
            a0=a;
            b0=b;
            a=a3;
            b=b3;
            A(t)=a;
            B(t)=b;
            min=min1;
            m(t)=min;
            fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);   
            else
            %斜著走不成立    
            fprintf("  斜著走不成立8\n");    
            end
        else %y值原值較好或相等，縮步伐
        t=t+1;
        b0=b;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        n=n/2;
        fprintf("  4個值都一樣，所以步伐減半9");
        n
        end
  end
  err=abs(min-z(a0,b0));
end
toc;
%畫圖
hold on;
plot(A,B,'o');
hold on;
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
contour (x2,y2,top); 
hold on;