clc,clear
c='mbrgkcwymbrgkcwymbrgkc';
%z=@(xx,yy) 3*(1-xx).^2.*exp(-xx.^2-(yy+1).^2)....
    %-10*(xx./5-xx.^3-yy.^5).*exp(-xx.^2-yy.^2)....
    %-1/3*exp(-(xx+1).^2-yy.^2);
z=@(x,y) (x-y)+2.*x.^2.+(2.*x.*y+y.^2.);
a1=input('�Ʊ��l�Ix=0');
b1=input('�Ʊ��l�Iy=0');
a2=input('�Ʊ��l�Ix=0');
b2=input('�Ʊ��l�Iy=0.2');
a3=input('�Ʊ��l�Ix=-0.2');  
b3=input('�Ʊ��l�Iy=0');
err1=1;
t=1;
a=0;%��Ӫ�x��
b=0;%��Ӫ�y��
err=0.0001;
x1(t)=a1;
        x2(t)=a2;
        x3(t)=a3;
        y1(t)=b1;
        y2(t)=b2;
        y3(t)=b3;
        z1(t)=z(a1,b1);
        z2(t)=z(a2,b2);
        z3(t)=z(a3,b3);
color='mbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcymbrgkcy'; %color of lines/symbols;
while err1>err
Z=[z(a1,b1),z(a2,b2),z(a3,b3)];
m0=min(Z);
M=max(Z);
A=z(a1,b1);
B=z(a2,b2);
C=z(a3,b3);
%3���I���
    %�̤j�I�O(a1,b1)
    if M==A
    %���V
    t=t+1;
    a=a1;
    b=b1;
    da=(a3+a2)/2-a1;
    db=(b3+b2)/2-b1;
    a5=a1+((a3+a2)/2-a1)*2;
    b5=b1+((b3+b2)/2-b1)*2;
    a6=a1+((a3+a2)/2-a1)*3;
    b6=b1+((b3+b2)/2-b1)*3;
    Z1=[z(a5,b5),z(a6,b6)];
    m=min(Z1);
        if m<M %���X�i����n

            if m==z(a5,b5)
                a1=a5;
                b1=b5;
                %fprintf("m==z(a5,b5)�A1\n");
            elseif m==z(a6,b6)  
                a1=a6;
                b1=b6;
                %fprintf("m==z(a6,b6)�A1\n");
            else
             fprintf("��L�A1");  
            end
        else    %���Y����n
            a7=a1+da*0.5;
            b7=b1+db*0.5;
            n=3;
            fprintf("�Y�p1\n");
            err1=sqrt((z(a7,b7)-M)^2/n);
                while z(a7,b7)>M %�Y�p���Ȥ��n
                    fprintf("�Y�p1\n");
                    da=0.5*da;
                    db=0.5*db;
                    a7=a1+da;
                    b7=b1+db;
                    n=n+1;
                    err1=sqrt(err1+(z(a7,b7)-m0)^2/n);
                end
            a1=a7;
            b1=b7;
        end   
       %�]���x�} 
     x1(t)=a1;
     x2(t)=a2;
     x3(t)=a3;
     y1(t)=b1;
     y2(t)=b2;
     y3(t)=b3;
     z1(t)=z(a1,b1);
     z2(t)=z(a2,b2);
     z3(t)=z(a3,b3);
     fprintf('%5d %10.8f %10.8f\n %16.8f %10.8f\n %16.8f %10.8f\n',t,a1,b1,a2,b2,a3,b3);
    
    %�̤j�I�O(a2,b2)
    elseif M==B
    %���V
    t=t+1;
    a=a2;
    b=b2;
    da=(a3+a1)/2-a2;
    db=(b3+b1)/2-b2;
    a5=a2+((a3+a1)/2-a2)*2;
    b5=b2+((b3+b1)/2-b2)*2;
    a6=a2+((a3+a1)/2-a2)*3;
    b6=b2+((b3+b1)/2-b2)*3;
    Z1=[z(a5,b5),z(a6,b6)];
    m=min(Z1);
        if m<M %���X�i����n

            if m==z(a5,b5)
                a2=a5;
                b2=b5;
                %fprintf("m==z(a5,b5)�A2\n");
            elseif m==z(a6,b6)    
                a2=a6;
                b2=b6;
                %fprintf("m==z(a6,b6)�A2\n");
            else
                fprintf("��L�A2");
            end
        else    %���Y����n
            a7=a2+da*0.5;
            b7=b2+db*0.5;
            n=3;
            fprintf("�Y�p2\n");
            err1=sqrt((z(a7,b7)-M)^2/n);
                while z(a7,b7)>M %�Y�p���Ȥ��n
                    fprintf("�Y�p2\n");
                    da=0.5*da;
                    db=0.5*db;
                    a7=a2+da;
                    b7=b2+db;
                    n=n+1;
                    err1=qrt(err1+s(z(a7,b7)-m0)^2/n);
                end
            a2=a7;
            b2=b7;
        end   
        x1(t)=a1;
        x2(t)=a2;
        x3(t)=a3;
        y1(t)=b1;
        y2(t)=b2;
        y3(t)=b3;
        z1(t)=z(a1,b1);
        z2(t)=z(a2,b2);
        z3(t)=z(a3,b3);        
        fprintf('%5d %10.8f %10.8f\n %16.8f %10.8f\n %16.8f %10.8f\n',t,a1,b1,a2,b2,a3,b3);
    %�̤j�I�O(a3,b3)    
    elseif M==C
    %���V
    t=t+1;
    a=a3;
    b=b3;
    da=(a1+a2)/2-a3;
    db=(b1+b2)/2-b3;
    a5=a3+((a1+a2)/2-a3)*2;
    b5=b3+((b1+b2)/2-b3)*2;
    a6=a3+((a1+a2)/2-a3)*3;
    b6=b3+((b1+b2)/2-b3)*3;
    Z1=[z(a5,b5),z(a6,b6)];
    m=min(Z1);
        if m<M %���X�i����n
            if m==z(a5,b5)
                a3=a5;
                b3=b5;
                %fprintf("m==z(a5,b5)�A3\n");
            elseif m==z(a6,b6)    
                a3=a6;
                b3=b6;
                %fprintf("m==z(a6,b6)�A3\n");
            else
                fprintf("��L�A3");
            end    
        else    %���Y����n
            a7=a3+da*0.5;
            b7=b3+db*0.5;
            n=3;
            fprintf("�Y�p3\n");
            err1=sqrt((z(a7,b7)-M)^2/n);
                while z(a7,b7)>M %�Y�p���Ȥ��n
                    fprintf("�Y�p3\n");
                    da=0.5*da;
                    db=0.5*db;
                    a7=a3+da;
                    b7=b3+db;
                    n=n+1;
                    err1=sqrt(err1+(z(a7,b7)-m0)^2/n);
                end
            a3=a7;
            b3=b7;
        end
        %�]���x�}
        x1(t)=a1;
        x2(t)=a2;
        x3(t)=a3;
        y1(t)=b1;
        y2(t)=b2;
        y3(t)=b3;
        z1(t)=z(a1,b1);
        z2(t)=z(a2,b2);
        z3(t)=z(a3,b3);
        fprintf('%5d %10.8f %10.8f\n %16.8f %10.8f\n %16.8f %10.8f\n',t,a1,b1,a2,b2,a3,b3);
    else
    fprintf("��J���Ȥ��Ӧn�A������I����\n");
    err1=0.000001;
    end
end 
fprintf("  �̫�@�ӤT����\n")
fprintf('%5d %10.8f %10.8f\n %16.8f %10.8f\n %16.8f %10.8f\n',t,a1,b1,a2,b2,a3,b3);
z(-1.00787024,1.50950227)
z(-1.00978012,1.50514297)
z(-0.99665813,1.49418812)
%�}�l�e��
hold on;
X=[x1;x2;x3];
Y=[y1;y2;y3];
Z=[z1;z2;z3];
patch(X,Y,Z);
colorbar;
j=0;
for x1=-2:0.1:2
    j=j+1;
    i=0;
    for y1=-2:0.1:2
       i=i+1;
       %top(i,j)=3*(1-x1).^2.*exp(-x1.^2-(y1+1).^2)....
    %-10*(x1./5-x1.^3-y1.^5).*exp(-x1.^2-y1.^2)....
    %-1/3*exp(-(x1+1).^2-y1.^2);
       top(i,j)=(x1-y1)+2*x1*x1+(2*x1*y1+y1*y1); 
    end
end
x2 = linspace(-2,2,41);
y2 = linspace(-2,2,41);
contour (x2,y2,top); 
hold on;
n
err1