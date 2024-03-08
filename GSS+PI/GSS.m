% GSS
clc;clear;
f=@(x) 2-4.*x + exp(x);
al=input('al= (e.g.1) ?');au=input('au= (e.g.7) ?');
I=au-al;
aa=al+0.382*I;ab=al+0.618*I;
t=1;Au(t)=au;Aa(t)=aa;Ab(t)=ab;Al(t)=al;
while I>0.001
    if f(aa)<f(ab)
        al=al;
        ab=aa;
        au=ab;
        aa=al+0.382*(au-al);
    elseif f(aa)>f(ab)
        al=aa;
        aa=ab;
        au=au;
        ab=al+0.618*(au-al);
    else
        al=aa;
        au=ab;
        aa=al+0.382*(au-al);
        ab=al+0.618*(au-al);
    end
    I=au-al;t=t+1;
    Au(t)=au;Aa(t)=aa;Ab(t)=ab;Al(t)=al;
end

% draw
i = 0:pi/10:2*pi;
z=f(i);
plot(i,z);

hold on
for i=1:t
    plot(Au(i),f(Au(i)),'o',Aa(i),f(Aa(i)),'*',Ab(i),f(Ab(i)),'<',Al(i),f(Al(i)),'>')
end

Amin=0.5*(Au+Al);
fmin=f(Amin);

figure
plot(fmin,'-o')