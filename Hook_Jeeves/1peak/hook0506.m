clc;clear;
z=@(x,y) (x-y)+2.*x.^2.+(2.*x.*y+y.^2.);
%times=input('�Ʊ���������ex1000=?');
a=input('�Ʊ��l�Ix=(-2~1)?');
b=input('�Ʊ��l�Iy=?(-1~3)');
a0=1; %��la
b0=1; %��lb
n=input('�Ʊ�B��=?');
min=0; %�û��̤p
min1=0;
t=1;
err=1.;
A(t)=a;
B(t)=b;
tic;
while a>=-2.&&a<=1.&&b>=-1.&&b<=3&&n>=0.1
   min=z(a,b); 
   %��n�Y�p
   a1=a-n;
   a2=a+n;
   b1=b-n;
   b2=b+n;
   %������
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
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������1");    
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
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������2\n");    
            end
            
        else
        t=t+1;
        bo=b;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������3");    
            end
        end
   %���     
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
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������4");    
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
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������5");    
            end
            
        else
        t=t+1;    
        b0=b;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        m(t)=min;
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        %�}�l�׵ۨ�
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
            %�׵ۨ�������      
            fprintf("  �׵ۨ�������6");    
            end
            
        end    
  else %x��ȸ��n
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
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������7");    
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
        %�}�l�׵ۨ�
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
            %�׵ۨ�������    
            fprintf("  �׵ۨ�������8\n");    
            end
        else %y�ȭ�ȸ��n�ά۵��A�Y�B��
        t=t+1;
        b0=b;
        A(t)=a;
        B(t)=b;
        min=z(a,b);
        fprintf('%5d %10.8f %10.8f %10.8f\n',t,a,b,min);
        n=n/2;
        fprintf("  4�ӭȳ��@�ˡA�ҥH�B���b9");
        n
        end
  end
  err=abs(min-z(a0,b0));
end
toc;
%�e��
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