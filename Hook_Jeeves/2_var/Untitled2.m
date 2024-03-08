clc;clear;
n=input('how many variable');
d=input('steps = ');
% f=@(x,y) (x-y)+2.*x.^2.+(2.*x.*y+y.^2.);
f=@(x,y) x.^2-2.*y.^2-4.*x;
g1=@(x,y) x+y-6;


t=1;k=1;err=10;
for i=1:n
    x(i,1)=input('initial point = ?');
end
fm=f(x(1,1),x(2,1));z(k)=fm;m(k,1)=x(1,1);m(k,2)=x(2,1);

while err>0.1 && t<10 && g1(x(1,1),x(2,1))<=0
    for i=1:n
        x(i,2)=x(i,1)-d;x(i,3)=x(i,1)+d;
        x(x(2,:)>3)=3;
        switch i
            case 1
                A=f(x(i,1),x(2,1));
                B=f(x(i,2),x(2,1));
                C=f(x(i,3),x(2,1));
                X(i)=min([A,B,C]);k=k+1;z(k)=X(i);
                if X(i)==A; D(i)=0; x(i,:)=x(i,1);end
                if X(i)==B; D(i)=-d; x(i,:)=x(i,2);end
                if X(i)==C; D(i)=d; x(i,:)=x(i,3);end
                m(k,1)=x(1,1);m(k,2)=x(2,1);
            case 2
                A=f(x(1,1),x(i,1));
                B=f(x(1,1),x(i,2));
                C=f(x(1,1),x(i,3));
                X(i)=min([A,B,C]);k=k+1;z(k)=X(i);
                if X(i)==A; D(i)=0; x(i,:)=x(i,1);end
                if X(i)==B; D(i)=-d; x(i,:)=x(i,2);end
                if X(i)==C; D(i)=d; x(i,:)=x(i,3);end
                m(k,1)=x(1,1);m(k,2)=x(2,1);
        end
    end
    if D == [0,0]
        d=d/2;t=t+1;
        k=k+1;m(k,1)=x(1,1);m(k,2)=x(2,1);z(k)=f(x(1,1),x(2,1));
    else
        x(1,2)=x(1,1)-D(1,1); x(2,2)=x(2,1)-D(1,2); % PT2
        x(1,3)=x(1,1)+D(1,1); x(2,3)=x(2,1)+D(1,2); % PT3
        A=f(x(1,1),x(2,1));
        B=f(x(1,2),x(2,2));
        C=f(x(1,3),x(2,3));
        X(i+1)=min([A,B,C]);k=k+1;z(k)=X(i+1);
        if X(i+1)==A; x(1,:)=x(1,1); x(2,:)=x(2,1);end
        if X(i+1)==B; x(1,:)=x(1,2); x(2,:)=x(2,2);end
        if X(i+1)==C; x(1,:)=x(1,3); x(2,:)=x(2,3);end
        m(k,1)=x(1,1);m(k,2)=x(2,1);
    end
    err=abs((fm-z(k))/fm);
    fm=z(k);
end
plot(m(:,1),m(:,2),'-o') ; hold on;
j=0;
for x1=0:0.1:5
    j=j+1;
    i=0;
    for y1=0:0.1:5
        i=i+1;
        top(i,j)=x1.^2-2.*y1.^2-4.*x1;
    end
end
x2 = linspace(0,5,51);
y2 = linspace(0,5,51);
contour (x2,y2,top);
hold on;
figure
plot(z,'-o')