clc;clear;
Var_min=1000000000;
filename='.\simplex_data.txt';
[X,D]=textread(filename,'%f%f');
f=@(s) 2/(1+exp(-2*s))-1;
tic
for i1=-1:0.5:1
    for i2=-1:0.5:1
        for i3=-1:0.5:1
            for i4=-1:0.5:1
                for i5=-1:0.5:1
                    for i6=-1:0.5:1
                        for i7=-1:0.5:1
                            for j=1:200
                                
                                Y(j)=f(i3*f(X(j)*i1+i5)+i4*f(X(j)*i2+i6)+i7);
                                var(j)=(Y(j)-D(j))^2;
                            end
                            sum_Var=sum(var(:));
                            if sum_Var<Var_min
                                Var_min=sum_Var;
                                c1=i1;c2=i2;c3=i3;c4=i4;b1=i5;b2=i6;b3=i7;
                            end
                        end
                    end
                end
            end
        end
    end
end
toc
for j=1:200
    Y_best(j)=f(c3*f(X(j)*c1+b1)+c4*f(X(j)*c2+b2)+b3);
end
figure(1);hold on;
plot(X,Y_best,'*')