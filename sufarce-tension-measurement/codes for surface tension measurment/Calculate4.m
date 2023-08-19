% droplet: scenario 4
% steel rod: get the edge manually
function f = Calculate4(r1,r2,g,D,handles2)
addpath('functions');
rou=r2-r1;
global I1;
global I2;
global I1_edge;

[I1_edge]=ALL_3(I1);

[de,ds]=drop(I1_edge);
axes(handles2.axes2);
imshow(I1_edge);
title('');

axes(handles2.axes3);
imshow(I2);
title('');
[x,y]=ginput(2);
d=abs(x(2,1)-x(1,1));
ratio=D/d;


De=de*ratio;
Ds=ds*ratio; 
s = ds/de;
num = xlsread('S_H.xlsx');
S=num(:,1);
H=num(:,2);
h=interp1(S,H,s);
st_water=g*rou*De^2*(1/h)/1000;
set(handles2.edit5,'string',num2str(st_water));