function I_full=bicubic(I_sp)
% bicubic interpolation
s_32 = s(3/2);
s_12 = s(1/2);
s_0 = s(0);
s_1 = s(1);
a = s_32^2;
b = s_32*s_12;
c = s_12^2;
d = s_0*s_12;
e = s_0*s_32;
f = s_1*s_12;
g = s_1*s_32;
H = [a, g, b, e, b, g, a;
     g, 0, f, 0, f, 0, g;
     b, f, c, d, c, f, b;
     e, 0, d, 1, d, 0, e;
     b, f, c, d, c, f, b;
     g, 0, f, 0, f, 0, g;
     a, g, b, e, b, g, a];

I_full = imfilter(I_sp, H, 'replicate'); 


end