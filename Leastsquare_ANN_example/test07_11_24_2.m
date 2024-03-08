% The coding is to construct an ANN model to curve fit polynomials with one variable (x) of various degrees
% a = tansig(n) = 2/(1+exp(-2*n))-1
function test07_11_24_2
% clear;
% clc;
% parpool local 4
ty=input('Choose your data source? (1)New data (2)Load before data: ');
switch ty
    case 1
        fprintf('The coding is to construct an ANN model to curve fit polynomials with one variable (x) of various degrees.\n')
        order=input('Order of the polynomial(1 = linear) =? ');
        i=order+1;
        fprintf("First, input the constant, then input coefficient(s) from high to low order. (i.e. coefficient(n)): \n")
        
        while i>=1
            coefficient(i)=input('coefficient(n)=? ');%Unlimited store required coefficients
            i=i-1;
        end
        
        %show polynomial
        i=order;
        fprintf('\n')
        fprintf("f(x)=");
        while i>=1
            equ=' %2i x^ %2i +';
            fprintf(equ,coefficient(i),i);
            i=i-1;
        end
        fprintf('%3i',coefficient(order+1));
        
        fprintf('\n')
        trig_f=input('Wanna add trigonometric function? (1)Yes(2)No: ');
        switch trig_f
            case 1
                fprintf("Follow cosx(pi)->sinx(pi)->cosx(pi)sinx(pi) enter your trigonometric coefficient.\n");
                for i=1:3
                    tri_coefficient(i)=input('tri_coefficient(n)=? ');%Unlimited store required coefficients
                end
                %show polynomial
                i=order;
                fprintf('\n')
                fprintf("f(x)=");
                while i>=1
                    equ=' %2i x^ %2i +';
                    fprintf(equ,coefficient(i),i);
                    i=i-1;
                end
                fprintf('%3i',coefficient(order+1));
                fprintf("+");
                equ2=' %3i cos(x)+ %3i sin(x)+ %3i cos(x)sin(x)';
                fprintf(equ2,tri_coefficient(1),tri_coefficient(2),tri_coefficient(3));
        end
        
        
        fprintf('\n')
        fprintf('Follow the steps below to build your ANN model: \n')
        IN_N=input('Enter how many data sets you wanna train your ANN :  ');
        
        % Choose which types of error you wanna put in original data(s).
        fprintf('\n')
        fprintf('Choose the error type of your data: \n')
        B=input('(1)Max error (2)Medium error (3)Small error (4)Others:  ');
        
        switch B
            case 1;  B={'Max error'}; err=20;
            case 2;  B={'Medium error'}; err=10;
            case 3;  B={'Small error'}; err=5;
            case 4;  err=input('error=?'); B={'error= :',err};
        end
        
        switch trig_f
            case 1
                [X,D]=random_data_tri(order,IN_N,err,coefficient,tri_coefficient);
                [XX,DD]=random_data_tri(order,50,err,coefficient,tri_coefficient);
            case 2
                [X,D]=random_data(order,IN_N,err,coefficient);
                [XX,DD]=random_data(order,50,err,coefficient);
        end
        % save('output.txt','X','D');
        figure;
        scatter(X,D,'*');xlim([min(X) max(X)]);ylim([min(D) max(D)]); % plot the input data
        lgd=legend('original data');
        title(lgd,B);xlim([0 1]);ylim([0 1.2]);
        % pathname = 'D:\DVS\ActionRecording\';
        % filename = 'white_boxing_fastly_side.bin.csv ';
        % save(strcat(pathname,filename, '.mat'), 'data_1' );
        
        save(['C:\Users\user\Desktop\matlab\','test_orig'], 'X','D');
        save(['C:\Users\user\Desktop\matlab\','test_vert'], 'XX','DD');
    case 2
%         load 'test_orig.mat';
%         load 'test_vert.mat';
%         filename='C:\Users\user\Desktop\px_in.txt';
%         filename='C:\Users\user\Desktop\data2.txt';
        filename='.\data4.txt';
%         filename='.\data2.txt';
        [X,D]=textread(filename,'%f%f','delimiter', ',');
        X=X';D=D';
        X=(X+1);X_plot=X-1;
        figure(1)
%         plot(X,D,'o');xlim([0 1]);ylim([0 1.2]); % plot the input data
        scatter(X_plot,D,'o');xlim([min(X_plot) max(X_plot)]);ylim([min(D) max(D)]);
        lgd=legend('original data');
        B='Old Data';
        title(lgd,B);
        IN_N=size(X);
        IN_N=IN_N(1)*IN_N(2);
end


%number of hidden layers
fprintf('\n')
N=input('How many HIDDEN layers: ( > = 3) ');

for i=1:N
  fprintf('Enter the number of neurons in layer %2i',i)
  n(i)=input(': ');
end
figure(3)
plot(X_plot,D,'o');xlim([min(X_plot) max(X_plot)]);ylim([min(D) max(D)]);
hold on
% e.g. n1=input('first layer = ');n2=input('second layer = ');n3=input('third layer = ');
while true
fprintf('Choose your fit function.\n')
for i=1:N+1
fprintf('Enter the fit function of neurons in layer %2i',i)
A=input(' (1)logsig (2)purelin (3)tansig : ');A0(i)=A;
    switch A
        case 1; a(i)={'logsig'};
        case 2; a(i)={'purelin'};
        case 3; a(i)={'tansig'};
    end
end

%Build AI
%Call ANN model
nn=[n 1];
nn_name=a;
% P=minmax(X);
%traingd | traingda | traingdm | trainlm | traingdx
net = newff([min(X) max(X)],nn,nn_name,'trainlm');

% Set training parameters
net.trainparam.show = 50 ;
net.trainParam.epochs = 10000; %癡絤程Ω计
net.trainParam.goal = 0.0005; %办┦程粇畉
net.trainParam.lr = 0.01 ;
net.trainParam.min_grad = 10^-7;
tic
net = train(net,X,D); 
O = sim(net,X); 

toc

% figure (4)
% % plot(X,O);xlim([0 1]);ylim([0 1.2]);
% plot(X_plot,D,'o');hold on
% plot(X_plot,O,'r+');xlim([min(X_plot) max(X_plot)]);ylim([min(D) max(D)]);
% lgd4=legend('Original data','ANN');title(lgd4,'ANN simulate');
% hold on

figure (1);hold on;
% plot(X,O);xlim([0 1]);ylim([0 1.2]);

plot(X_plot,O,'>');xlim([min(X_plot) max(X_plot)]);ylim([min(D) max(D)]);



%Show if your assume reasonable (i.e. unknown(s)< data)
%e.g. number=nn1*1+n1+n2*n1+n2+n3*n2+n3+1*n3+1;
number=nn(1)*1+nn(1);
for i=2:N+1
    number=number+nn(i)*nn(i-1)+nn(i);
end
fprintf('number of unknowns: %2i',number);
fprintf('\n');

%calculate if X in sim line and its D
for j=1:IN_N
AA=X(j);
for i=1:N+1    
    if strcmpi(nn_name(i),'logsig') == 1
        if i==1
            W=[];W=net.iw{1,1};theta=[];theta=net.b{1};
            [A1]=logsigfunc(AA,W,theta,1,nn(i));
            AA=[];AA=A1;
        else
            W=[];W=net.lw{i,i-1};theta=[];theta=net.b{i};
            [A1]=logsigfunc(AA,W,theta,nn(i-1),nn(i));
            AA=[];AA=A1;
        end
    elseif strcmpi(nn_name(i),'tansig') == 1
        if i==1
            W=[];W=net.iw{1,1};theta=[];theta=net.b{1};
            [A1]=tansigfunc(AA,W,theta,1,nn(i));
            AA=[];AA=A1;
        else
            W=[];W=net.lw{i,i-1};theta=[];theta=net.b{i};
            [A1]=tansigfunc(AA,W,theta,nn(i-1),nn(i));
            AA=[];AA=A1;
        end
    else
        if i==1
            W=[];W=net.iw{1,1};theta=[];theta=net.b{1};
            [A1]=linfunc(AA,W,theta,1,nn(i));
            AA=[];AA=A1;
        else
            W=[];W=net.lw{i,i-1};theta=[];theta=net.b{i};
            [A1]=linfunc(AA,W,theta,nn(i-1),nn(i));
            AA=[];AA=A1;
        end
    end
end
D_pre(j)=AA; S(j)=sqrt((D_pre(j)-D(j))^2);
end
variance=sum(S(1:IN_N));

%Start to put unknown(s) in function AND draw continue line.
j=0;
for x=min(X):0.0001:max(X)
    j=j+1;X0(j)=x;%XX=X(j);
%Decide which method(s) you used in ANN model.    
for i=1:N+1
    if strcmpi(nn_name(i),'logsig') == 1
        if i==1
            W=[];W=net.iw{1,1};theta=[];theta=net.b{1};
            [A]=logsigfunc(x,W,theta,1,nn(i));
            x=[];x=A;
        else
            W=[];W=net.lw{i,i-1};theta=[];theta=net.b{i};
            [A]=logsigfunc(x,W,theta,nn(i-1),nn(i));
            x=[];x=A;
        end
    elseif strcmpi(nn_name(i),'tansig') == 1
        if i==1
            W=[];W=net.iw{1,1};theta=[];theta=net.b{1};
            [A]=tansigfunc(x,W,theta,1,nn(i));
            x=[];x=A;
        else
            W=[];W=net.lw{i,i-1};theta=[];theta=net.b{i};
            [A]=tansigfunc(x,W,theta,nn(i-1),nn(i));
            x=[];x=A;
        end
    else
        if i==1
            W=[];W=net.iw{1,1};theta=[];theta=net.b{1};
            [A]=linfunc(x,W,theta,1,nn(i));
            x=[];x=A;
        else
            W=[];W=net.lw{i,i-1};theta=[];theta=net.b{i};
            [A]=linfunc(x,W,theta,nn(i-1),nn(i));
            x=[];x=A;
        end
    end
end
    Y0(j)=x;
end
% parpool close
X0_plot=X0-1;
figure(3)
% plot(X0,Y0);xlim([0 1]);ylim([0 1.2]);
plot(X0_plot,Y0,'*');xlim([min(X_plot) max(X_plot)]);ylim([min(D) max(D)]);
hold on

% lgd=legend('Data','Polynomial fit');
% title(lgd,B);
%s=sum(S(1:j));
%fprintf('%8.3f %8.3f\n',"s = ",s);

ave_variance=variance/IN_N;
equ3='\nVariance of data in the ANN model: %.2f';
fprintf(equ3,variance);
fprintf("\n")
equ4='Average variance of data in the ANN model: %.6f';
fprintf(equ4,ave_variance);

fprintf('\n');
fin=input('Satisfied your ANN ? (1)Yes (2)NO : ');
% [Y]=ANN_model(nn_name,X,net.iw,net.lw,net.b,N,IN_N,nn);
if fin==1
    break
end
end

% figure
% plot(XX,DD,'o',X0,Y0);
% lgd=legend('verification deta','simulate line');
% title(lgd,'Result');

% for i=1:j
%     fprintf('%8.3f %8.3f\n',i,S(i));
% end

%logsig%   A(n)=1/(1+exp(-(x*W1(n)+theta1(n))));
end
function [A4]=logsigfunc(x,W1,theta3,n2,n3)
    for j=1:n3
        for i=1:n2
            A3(j,i)=x(i)*W1(j,i);
        end
    end
    for i=1:n3
        A4(i)=1/(1+exp(-(sum(A3(i,1:n2))+theta3(i))));
    end
end

%tansig(n) = 2/(1+exp(-2*n))-1
function [A4]=tansigfunc(x,W1,theta3,n2,n3)
    for j=1:n3
        for i=1:n2
            A3(j,i)=x(i)*W1(j,i);
        end
    end
    for i=1:n3
%         A4(i)=1/(1+exp(-(sum(A3(i,1:n2))+theta3(i))));
        A4(i)=2/(1+exp(-2*(sum(A3(i,1:n2))+theta3(i))))-1;
    end
%   A(n)=1/(1+exp(-(x*W1(n)+theta1(n))));

end

%pure line
function [A4]=linfunc(A2,W3,theta3,n2,n3)
    for j=1:n3
        for i=1:n2
            A3(j,i)=A2(i)*W3(j,i);
        end
    end
    for i=1:n3
        A4(i)=sum(A3(i,1:n2))+theta3(i);
    end
end




