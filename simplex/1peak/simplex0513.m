clc,clear
c='mbrgkcwymbrgkcwymbrgkc';
%z=@(xx,yy) 3*(1-xx).^2.*exp(-xx.^2-(yy+1).^2)....
    %-10*(xx./5-xx.^3-yy.^5).*exp(-xx.^2-yy.^2)....
    %-1/3*exp(-(xx+1).^2-yy.^2);
z=@(x,y) (x-y)+2.*x.^2.+(2.*x.*y+y.^2.);
a1=input('希望初始點x=0');
b1=input('希望初始點y=0');
a2=input('希望初始點x=0');
b2=input('希望初始點y=0.2');
a3=input('希望初始點x=-0.2');  
b3=input('希望初始點y=0');
err1=1;
t=1;
a=0;%原來的x值
b=0;%原來的y值
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
%3個點比較
    %最大點是(a1,b1)
    if M==A
    %找方向
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
        if m<M %當擴張比較好

            if m==z(a5,b5)
                a1=a5;
                b1=b5;
                %fprintf("m==z(a5,b5)，1\n");
            elseif m==z(a6,b6)  
                a1=a6;
                b1=b6;
                %fprintf("m==z(a6,b6)，1\n");
            else
             fprintf("其他，1");  
            end
        else    %收縮比較好
            a7=a1+da*0.5;
            b7=b1+db*0.5;
            n=3;
            fprintf("縮小1\n");
            err1=sqrt((z(a7,b7)-M)^2/n);
                while z(a7,b7)>M %縮小的值不好
                    fprintf("縮小1\n");
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
       %設為矩陣 
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
    
    %最大點是(a2,b2)
    elseif M==B
    %找方向
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
        if m<M %當擴張比較好

            if m==z(a5,b5)
                a2=a5;
                b2=b5;
                %fprintf("m==z(a5,b5)，2\n");
            elseif m==z(a6,b6)    
                a2=a6;
                b2=b6;
                %fprintf("m==z(a6,b6)，2\n");
            else
                fprintf("其他，2");
            end
        else    %收縮比較好
            a7=a2+da*0.5;
            b7=b2+db*0.5;
            n=3;
            fprintf("縮小2\n");
            err1=sqrt((z(a7,b7)-M)^2/n);
                while z(a7,b7)>M %縮小的值不好
                    fprintf("縮小2\n");
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
    %最大點是(a3,b3)    
    elseif M==C
    %找方向
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
        if m<M %當擴張比較好
            if m==z(a5,b5)
                a3=a5;
                b3=b5;
                %fprintf("m==z(a5,b5)，3\n");
            elseif m==z(a6,b6)    
                a3=a6;
                b3=b6;
                %fprintf("m==z(a6,b6)，3\n");
            else
                fprintf("其他，3");
            end    
        else    %收縮比較好
            a7=a3+da*0.5;
            b7=b3+db*0.5;
            n=3;
            fprintf("縮小3\n");
            err1=sqrt((z(a7,b7)-M)^2/n);
                while z(a7,b7)>M %縮小的值不好
                    fprintf("縮小3\n");
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
        %設為矩陣
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
    fprintf("輸入的值不太好，有兩個點重複\n");
    err1=0.000001;
    end
end 
fprintf("  最後一個三角形\n")
fprintf('%5d %10.8f %10.8f\n %16.8f %10.8f\n %16.8f %10.8f\n',t,a1,b1,a2,b2,a3,b3);
z(-1.00787024,1.50950227)
z(-1.00978012,1.50514297)
z(-0.99665813,1.49418812)
%開始畫圖
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