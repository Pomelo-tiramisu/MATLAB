%First, show the original data.
%Second, Choose thh level of linear function.
%Third, show sim line.
%Satisfied, than show sim line and vertification data.
function least_square_one_12_8
        % clc;clear;
        fprintf("This program help you solve the coefficient(s) of function from unknown data with least square method.\n")
        trytime=1;
        color=['mbrgmbrg'];
        dots=['+*>x+*>x'];%ploting symbols
%         filename='C:\Users\user\Desktop\px_in.txt';
%         filename='C:\Users\user\Desktop\data2.txt';
        filename='.\data3.txt';
        [X,D]=textread(filename,'%f%f','delimiter', ',');
        figure(1)
%         plot(X,D,'o');xlim([0 1]);ylim([0 1.2]);
        plot(X,D,'o');xlim([min(X),max(X)]);ylim([min(D),max(D)]);
        legend('Original Data');title('Original data');
        
        % X=X';D=D';
        figure(2)
        plot(X,D,'o');xlim([min(X),max(X)]);ylim([min(D),max(D)]);hold on;
        while true
            n=input('Enter the order of your "Regression Equation"= ');
            p = polyfit(X,D,n);
            D2 = polyval(p,X);
            
            figure(2)            
%             plot(X,D,'o',X,D2,dots(trytime));xlim([0 1]);ylim([0 1.2]);
            plot(X,D2,dots(trytime));xlim([min(X),max(X)]);ylim([min(D),max(D)]);hold on;
            lgd=legend('Original Data','Polynomial fit');hold on;
            title(lgd,n);
            %Show the equation
            fprintf("The result of Regression Equation: \n")
            fprintf("f(x)= ")
            j=n;
            for i=1:n+1
                if j==0
                    if p(i)<0
                        equ='%.2f';
                    else
                        equ='+ %.2f';
                    end
                    fprintf(equ,p(i));
                else
                    if p(i)<0
                        equ='%.2f x^ %d ';
                    else
                        equ='+%.2f x^ %d ';
                    end
                    fprintf(equ,p(i),j);
                end
                j=j-1;
            end
            p0=p(n+1);
            %determine varience
            number_X=size(X);var=0;number_X=number_X(1)*number_X(2);
            for i=1:number_X
                x1(i)=0;q=n;
                for j=1:n
                    x1(i)=x1(i)+(X(i)^q)*p(j);
                    q=q-1;
                end
                x1(i)=x1(i)+p0;D1(i)=x1(i);
                var=var+sqrt((D1(i)-D(i))^2);
            end
            ave_var=var/number_X;
            fprintf('\n\n');
            var_word='Variance of data in the Least-Square-Method model= %.2f';
            ave_var_word='Average variance of data in the Least-Square-Method model= %.6f';
            fprintf(var_word,var);
            fprintf('\n');
            fprintf(ave_var_word,ave_var);
            
            fprintf('\n\n');
            fin=input('Satisfied your least square ? (1)Yes (2)NO : ');
            if fin==1
                break
            end
            trytime=trytime+1;
        end
        i=1;
        for x=min(X):(max(X)-min(X))/1000:max(X)
            q=n;x2(i)=0;
            for j=1:n
                x2(i)=x2(i)+(x^q)*p(j);
                q=q-1;
            end
            x2(i)=x2(i)+p0;D3(i)=x2(i);
            i=i+1;
        end
        
        figure(3)
        x5=min(X):(max(X)-min(X))/1000:max(X);
%         plot(x,D3);xlim([0 1]);ylim([0 1.2]);
        plot(x5,D3,'>');xlim([min(X),max(X)]);ylim([min(D),max(D)])
        lgd3=legend('Polynomial fit');title(lgd3,'Method');
        hold on
             
end


