%n:N_unk of hidden layers;N:N_unk of neuron in every
%layers;N_unk:unknowns
clc;clear;
filename='.\simplex_data.txt';
f=@(s) 2/(1+exp(-2*s))-1;err=10;a=0.005;
[X_in,D_in]=textread(filename,'%f%f');
n=input('How many hidden layers?');
for i=1:n
    N(i)=input('Number of neurons: ');
end
nn=[1 N 1];
N_unk=0;
for i=1:n+1
    N_unk=N_unk+nn(i+1)*nn(i)+nn(i+1);
end
fprintf('N_unk of unknowns: %2i',N_unk);
fprintf('\n');

%build simplex original points

for i=1:N_unk
    fprintf('Enter the unknown %2i',i)
     X(i)=input(': ');
end
t=0;
p=a/(N_unk*sqrt(2))*(sqrt(N_unk+1)+N_unk-1);
q=a/(N_unk*sqrt(2))*(sqrt(N_unk+1)-1);
X0=X;
% X1=[X(1)+p,X(2:N_unk)+q];
% X2=[X(1)+q,X(2)+p,X(2+1:N_unk)+q];
for i=1:N_unk
    if i==1
        X(i,:)=[X0(1)+p,X0(2:N_unk)+q];
    elseif i==N_unk
        X(i,:)=[X0(1:i-1)+q,X0(i)+p];
    else
        X(i,:)=[X0(1:i-1)+p,X0(i)+p,X0(i+1:N_unk)+p];
    end
end
for i=1:N_unk+1
    if i==1
        X_total(i,:)=X0(1,:);
    else
        X_total(i,:)=X(i-1,:);
    end
end

minX=min(X_total);minX=min(minX);minX=min(minX);
maxX=max(X_total);maxX=max(maxX);maxX=max(maxX);
times=0;
tic
while (err>0.01)&& (times<10000)
    times=times+1
    
    minX=min(X_total);minX=min(minX);minX=min(minX);
    maxX=max(X_total);maxX=max(maxX);maxX=max(maxX);
    if minX <= 1
        [X_total]=changeminX(X_total,N_unk);
    elseif maxX> 1
        [X_total]=changemaxX(X_total,N_unk);
    end
    for i=1:N_unk+1
        for j=1:N_unk
            c(j)=X_total(i,j);
        end
        for k=1:200
            Y(k)=f(c(3)*f(X_in(k)*c(1)+c(5))+c(4)*f(X_in(k)*c(2)+c(6))+c(7));
            var(k)=(Y(k)-D_in(k))^2;
        end
        var_f(i)=sum(var(:));
    end
    
    %Decide which point is the worst and best
    min_var_f=min(var_f);min_var_f0=min_var_f;
    max_var_f=max(var_f);max_var_f0=max_var_f;
    for i=1:N_unk+1
        if max_var_f==var_f(i)
            t_max=i;
        end
        if min_var_f==var_f(i)
            t_min=i;
        end
    end
    
    %Decide the vector
    X_total_minus=X_total;t_max0=t_max;
    X_total_minus(t_max0, :)=0;t_min0=t_min;
    
    for j=1:N_unk
        X_all(1,j)=sum(X_total_minus(1:N_unk+1,j));
    end
    X_all=X_all/N_unk;
    vector=X_all-X_total(t_max0,:);
    vector_2=(X_all-X_total(t_max0,:))*2;
    
    X_total_re=X_total;X_total_con=X_total;
    X_total_re(N_unk+2,:)=X_total(t_max0,:)+vector_2;
    X_total_re(N_unk+3,:)=X_total(t_max0,:)+vector_2*3/2;
    X_total_con(N_unk+4,:)=X_total(t_max0,:)-vector/2;
    
    % decide if reflec
    for i=N_unk+2:N_unk+3
        for j=1:N_unk
            c(j)=X_total_re(i,j);
        end
        for k=1:200
            Y(k)=f(c(3)*f(X_in(k)*c(1)+c(5))+c(4)*f(X_in(k)*c(2)+c(6))+c(7));
            var(k)=(Y(k)-D_in(k))^2;
        end
        var_f(i)=sum(var(:));
    end
    max_var_f=max(var_f);
    min_var_f=min(var_f(N_unk+2),var_f(N_unk+3));
    
    for i=N_unk+2:N_unk+3
        if max_var_f==var_f(i)
            t_min_re=i;
            break;
        end
    end
    
    if max_var_f == max_var_f0
        [X_total,err]=contrac(X_total_con,X_total,t_max0,t_min0,N_unk,max_var_f0,X_in,D_in,f);
    else
        X_total(t_max0,:)=X_total_re(t_min_re,:);
    end
end
toc
var_min=1000;
for i=1:N_unk+1
    for j=1:N_unk
        c(j)=X_total(i,j);
    end
    for k=1:200
        Y(k)=f(c(3)*f(X_in(k)*c(1)+c(5))+c(4)*f(X_in(k)*c(2)+c(6))+c(7));
        var(k)=(Y(k)-D_in(k))^2;
    end
    var_f(i)=sum(var(:));
    if var_f(i)<var_min
        var_min=var_f(i);
        c1=c(1);c2=c(2);c3=c(3);c4=c(4);b1=c(5);b2=c(6);b3=c(7);
    end
end
for j=1:200
    Y_sim(j)=f(c3*f(X_in(j)*c1+b1)+c4*f(X_in(j)*c2+b2)+b3);
end
figure (1);hold on;
plot(X_in,D_in,'o',X_in,Y_sim,'+')

function [X_total0]=changeminX(X_total,N_unk)
for i=1:N_unk+1
    for j=1:N_unk
        if X_total(i,j)<-1
            X_total0(i,j)=-1;
        else
            X_total0(i,j)=X_total(i,j);
        end
    end
end
end
function [X_total0]=changemaxX(X_total,N_unk)
for i=1:N_unk+1
    for j=1:N_unk
        if X_total(i,j)>1
            X_total0(i,j)=1;
        else
            X_total0(i,j)=X_total(i,j);
        end
    end
end
end

% for i=1:N_unk
%     if i==1
%         XX(i)=XX(i)+p;
%         XX(i+1:N_unk)=XX(i+1:N_unk)+q;
%     elseif i==N_unk
%         XX(N_unk)=XX(N_unk)+p;
%         XX(1:N_unk-1)=XX(1:N_unk-1)+q;
%     else
%         XX(i)=XX(i)+p;
%         XX(1:i-1)=XX(1:t-1)+q;
%         XX(i+1:N_unk)=XX(t+1:N_unk)+q;
%     end
% end
