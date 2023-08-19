% droplet: scenario 1
% steel rod: get the edge automatically
function f = Calculate5(r1,r2,g,D,handles2)
rou=r2-r1;
addpath('functions');
global I1;
global I2;
global I1_edge;
global d;
global ratio;

[I1_edge]=ALL_1(I1);
[de,ds]=drop(I1_edge);
axes(handles2.axes2);
imshow(I1_edge);
title('');

t2=graythresh(I2);
I2_bw=im2bw(I2,t2);
I2_edge=edge(I2_bw, 'canny');
axes(handles2.axes3);
imshow(I2_edge);
title('');

[d,ratio]=contrast(I2_edge,D);


De=de*ratio;
Ds=ds*ratio; 
s = ds/de;
num = xlsread('S_H.xlsx');
S=num(:,1);
H=num(:,2);
h=interp1(S,H,s);
st_water=g*rou*De^2*(1/h)/1000;
set(handles2.edit5,'string',num2str(st_water));

