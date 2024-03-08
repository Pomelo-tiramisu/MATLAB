function [X_total0,err]=contrac(X_total_con,X_total,t_max0,t_min0,N_unk,max_var_f0,X_in,D_in,f)
for i=N_unk+4:N_unk+4
    for j=1:N_unk
        c(j)=X_total_con(i,j);
    end
    for k=1:200
        Y(k)=f(c(3)*f(X_in(k)*c(1)+c(5))+c(4)*f(X_in(k)*c(2)+c(6))+c(7));
        var(k)=(Y(k)-D_in(k))^2;
    end
    var_f(i)=sum(var(:));
end
max_var_f=max(var_f);

if max_var_f == max_var_f0
    for i=1:N_unk+1
        X_total_overall(i,:)=(X_total(t_min0,:)+X_total(i,:))/2;
    end
    [X_total0,err]=overallcontrac(X_total_overall,N_unk,X_in,D_in,f);
else
    X_total(t_max0,:)=X_total_con(N_unk+4,:);
    X_total0=X_total;err=sqrt((sum(var_f)/N_unk));
end

end