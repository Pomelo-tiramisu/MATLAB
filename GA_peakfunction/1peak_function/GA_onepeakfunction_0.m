% One peak function
% Gene Alogorithm(GA)
% Step 1. Generate 10 points(Wheel_1)
% Step 2. Mating (Wheel_2)(e.g change part(length) of chromosome)
% Step 3. Mutation (Wheel_3,4)(e.g change special DNA part)

clc;clear;
% 
% f =@(x,y) 3*(1-x).^2.*exp(-(x.^2) - (y+1).^2) ...
%     - 10*(x/5 - x.^3 - y.^5).*exp(-x.^2-y.^2) ...
%     - 1/3*exp(-(x+1).^2 - y.^2) ;
% 
f=@(x1,x2) 10*2+[x1.^2-10*cos(2*pi*x1)]+[x2.^2-10*cos(2*pi*x2)];

seed=1234567;
rng(seed);
N=20; % to deal with length of "dec2bin" from (decimal to binary)
P=0.4; % To satisfy the probability in mutation.

fprintf("The length of Binary is 20, and the probability in mutation is 40 percent\n")
p=input('How many individual("even")(e.g.2,4,...,20)=? ');
iter=input('How many iter=? ');

% Generate all points
for i=1:p
    X(1,i)=1000*(0.25+(rand()-0.5));Y(1,i)=1000*(0.25+(rand()-0.5));
    Z(1,i)=f(X(1,i),Y(1,i));
end

% Arrangement
z = sort(Z,2); % 2 prsent on column;


for k=1:iter
% to arrange x,y from max to min with the value of z
for i=1:p
    for j=1:p
        if z(k,i)==Z(k,j)
            x(k,i)=X(k,j);y(k,i)=Y(k,j);
        end
    end
end


% Probability (wheel_1)
% Ensure every value >0 to design wheel_1
z_abs=abs(z);z_abs_max=2*max(max(z_abs(k,:)));z_prob=z_abs_max+z(k,:);
D=sum(z_prob);prob=z_prob/D;

% Denominator
for i=1:p;wh_prob1(i)=D*rand();end

% Flag
for i=1:p;flag1(i)=sum(z_prob(1:i));end

% filter which point can still alive.
for i=1:p
    for j=1:(p-1)
        if wh_prob1(i)>flag1(j)
            x(k+1,i)=x(k,j+1);y(k+1,i)=y(k,j+1);
        end
    end
    if wh_prob1(i)<flag1(1)
        x(k+1,i)=x(k,1);y(k+1,i)=y(k,1);
    end
end

% https://www.itread01.com/content/1549854564.html
% http://mirlab.org/jang/books/matlabProgramming4beginner/10-4_stringConversion.asp?title=10-4%20%A6r%A6%EA%A1B%BC%C6%AD%C8%BBP%B0%7D%A6C%AA%BA%C2%E0%B4%AB

% Mating
% Decimal to Binary
fprintf("Chromosome\t");fprintf('%2d\n',k);
fprintf("\tx\t\t\t\t\ty\n");
for i=1:p
    if x(k+1,i)>= 0
        bin_x = dec2bin(x(k+1,i), N);xx1(k,i)={bin_x};
    else
        bin_x = dec2bin(2^N + x(k+1,i), N);xx1(k,i)={bin_x};
    end
    if y(k+1,i)>= 0
        bin_y = dec2bin(y(k+1,i), N);yy1(k,i)={bin_y};
    else
        bin_y = dec2bin(2^N + y(k+1,i), N);yy1(k,i)={bin_y};
    end
    fprintf('%2d\t',i);fprintf(bin_x);fprintf("\t");fprintf(bin_y);fprintf("\n");
end
% To ensure xx is 'char'
for i=1:p
xx(p*(k-1)+i,1:N)=char(xx1(k,i));
yy(p*(k-1)+i,1:N)=char(yy1(k,i));
end
xx0=xx;yy0=yy;
% wheel2
% To determine where change chromosome
for i=1:(p/2)
    ww=N+1;
    while ww>N
        wh_prob2(i)=round((N-1)*(0.1+rand()));
        ww=wh_prob2(i);
    end
end

% xx(1,1:wh_prob2(1))=xx0(2,1:wh_prob2(1));
% xx(2,1:wh_prob2(1))=xx0(1,1:wh_prob2(1));

% Start change chromosome
fprintf("Mating\t");fprintf('%2d\n',k);
fprintf("\tx\t\t\t\t\ty\n");
I=1;
for i=1:p
    switch mod(i,2)
        case 1
            xx(p*(k-1)+i,1:wh_prob2(I))=xx0(p*(k-1)+i+1,1:wh_prob2(I));
            yy(p*(k-1)+i,1:wh_prob2(I))=yy0(p*(k-1)+i+1,1:wh_prob2(I));
            I0=I;
        case 0
            xx(p*(k-1)+i,1:wh_prob2(I))=xx0(p*(k-1)+i-1,1:wh_prob2(I));
            yy(p*(k-1)+i,1:wh_prob2(I))=yy0(p*(k-1)+i-1,1:wh_prob2(I));
            I0=I;I=I+1;
    end
    fprintf('%2d\t',i);fprintf(xx(p*(k-1)+i,:));
    fprintf("\t");fprintf(yy(p*(k-1)+i,:));
    fprintf('\t%2d\n',wh_prob2(I0));
end

% Mutation
% wheel3
% If myth?
for i=1:p
    wh_prob3(i)=rand();
    ww=N+1;
    while ww>N
        wh_prob4(i)=round(N*(0.1+rand()));
        ww=wh_prob4(i);
    end
end
% Start myth
fprintf("Mutation\t");fprintf('%2d\n',k);
fprintf("\tx\t\t\t\t\ty\n");
for i=1:p
    if wh_prob3(i)<P
        if xx(p*(k-1)+i,wh_prob4(i))=='0'
            xx(p*(k-1)+i,wh_prob4(i))='1';
        else
            xx(p*(k-1)+i,wh_prob4(i))='0';
        end
        if yy(p*(k-1)+i,wh_prob4(i))=='0'
            yy(p*(k-1)+i,wh_prob4(i))='1';
        else
            yy(p*(k-1)+i,wh_prob4(i))='0';
        end
    end
    fprintf('%2d\t',i);fprintf(xx(p*(k-1)+i,:));
    fprintf("\t");fprintf(yy(p*(k-1)+i,:));
    if wh_prob3(i)>0.6
        fprintf('\tmyth%2d\n',wh_prob4(i));
    else
        fprintf("\n");
    end
end

% Binary to Decimal  
for i=1:p
    x(k+1,i)=bin2dec(xx(p*(k-1)+i,:));
    y(k+1,i)=bin2dec(yy(p*(k-1)+i,:));
    z(k+1,i)=f(x(k+1,i),y(k+1,i));
end

Z(k+1,:)=z(k+1,:);Y(k+1,:)=y(k+1,:);X(k+1,:)=x(k+1,:);
z(k+1,:)=sort(Z(k+1,:));

% figure
% plot(x(k+1,:),z(k+1,:),'o','MarkerFaceColor','b');xlim([-3,4500]);ylim([-3,3])
% figure
% plot(y(k+1,:),z(k+1,:),'>','MarkerFaceColor','r');xlim([-3,4500]);ylim([-3,3])
end

% figure
% plot(x,z,'<');
% 
% figure
% plot(y,z,'+');

XX=max(max(x));YY=max(max(y));

% draw
% draw contour
for j=1:k+1
    figure
    xxx = linspace(0, XX, 70);		% in x-axis,[0,XX] choose 70 pts.
    yyy = linspace(0, YY, 70);		% in y-axis,[0,YY] choose 70 pts.
    [xxx,yyy] = meshgrid(xxx, yyy); % xxx,yyy are all array.
    zzz = f(xxx,yyy);	% zzz same as xxx,yyy type
    contour(xxx, yyy, zzz,30);hold on
    colormap('default');				% colar default
    xlim([0,XX]);ylim([0,YY]);xlabel('x');ylabel('y');
    title('f(x1,x2)=A*n+[x1.^2-A*cos(2*pi*x1)]+[x2.^2-A*cos(2*pi*x2)]')
    plot3(x(j,:),y(j,:),z(j,:),'o');
end

% draw the best value after the GA method.
for i=1:k+1
    for j=1:p
        switch max(max(z(i,:)));case z(i,j);X1(i)=x(i,j);Y1(i)=y(i,j);Z1(i)=z(i,j);break;end
    end
end
A=1:k+1;
figure
plot(A,X1,'-o',A,Y1,'-.>',A,Z1,':+');
title('The best value after the GA method in every step');xlabel('Steps');ylabel('f(x1,x2)');

% draw every value steps by step in GA method.
figure
for i=1:p
    title('All value in GA method');xlabel('Steps');ylabel('f(x1,x2)');
    plot(1:k+1,z(:,i),'-*')
    hold on
end


