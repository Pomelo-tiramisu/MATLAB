function [X_total0,err]=overallcontrac(X_total_overall,N_unk,X_in,D_in,f)
for i=1:N_unk+1
    for j=1:N_unk
        c(j)=X_total_overall(i,j);
    end
    for k=1:200
        Y(k)=f(c(3)*f(X_in(k)*c(1)+c(5))+c(4)*f(X_in(k)*c(2)+c(6))+c(7));
        var(k)=(Y(k)-D_in(k))^2;
    end
    var_f(i)=sum(var(:));
end
X_total0=X_total_overall;
err=sqrt((sum(var_f)/N_unk));
end