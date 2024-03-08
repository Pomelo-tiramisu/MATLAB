% GSS + PI
clc;clear;
f=@(x) 2-4.*x + exp(x);
al=input('al= (e.g.1) ?');au=input('au= (e.g.7) ?');
%%
% GSS
I=au-al;fmin=100;err=100;
aa=al+0.382*I;ab=al+0.618*I;

% Initial pt
t=1;Au(t)=au;Aa(t)=aa;Ab(t)=ab;Al(t)=al;ai=0.5*(au+al);Ai(t)=ai;

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
%%
%PI
ai=0.5*(au+al);Ai(t)=ai;
while I>0.01 && err>0.0001
    [a0,a1,a2,a]=GE(au,ai,al,f); % by 高斯消去法
    if ai<a
        if f(ai)<f(a)
            al=al;ai=ai;au=a;
        elseif f(ai)>f(a)
            al=ai;ai=a;au=au;
        end
    
    elseif ai>a
        if f(ai)>f(a)
            al=al;au=ai;ai=a;
        elseif f(ai)<f(a)
            al=a;ai=ai;au=au;
        end
    end
    I=au-al;t=t+1;
    Au(t)=au;Ai(t)=ai;Al(t)=al;
    err=abs((fmin-f(Ai(t)))/fmin);fmin=f(Ai(t));
end
amin=0.5*(au+al);
%%
% draw
i = 0:pi/10:2*pi;
z=f(i);
plot(i,z);
%
hold on
for i=1:t
    plot(Au(i),f(Au(i)),'o',Ai(i),f(Ai(i)),'*',Al(i),f(Al(i)),'>')
end
%
figure
plot(Ai,'-o')

function [a0,a1,a2,a]=GE(au,ai,al,f)
a2=1/(au-ai).*((f(au)-f(al))/(au-al)-(f(ai)-f(al))/(ai-al));
a1=(f(ai)-f(al))/(ai-al)-a2*(al+ai);
a0=f(al)-a1*al-a2*al.^2;
a=-a1/2/a2;
end