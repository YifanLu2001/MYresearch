% bicubic interpolation 
function q=dia(a,b,c,d)
x=[1 2 3 4];
y=[a b c d];
x1=[1:0.5:4];
s = interp1(x,y,x1,"cubic");
q=s(4);
end