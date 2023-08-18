% bicubic interpolation
function q=bicu(B,u,v)
A=[SW(1+u) SW(u) SW(1-u) SW(2-u)];
C=[SW(1+v) SW(v) SW(1-v) SW(2-v)]';
q=A*B*C;
end

function s=SW(w)
W=abs(w);
if W<1
    s=1-2*W^2+W^3;
elseif W>=1 && W<2
    s=4-8*W+5*W^2-W^3;
else
    s=0;
end
end