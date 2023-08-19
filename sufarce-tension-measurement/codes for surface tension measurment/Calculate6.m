% droplet: scenario 2
% steel rod: get the edge automatically
function f = Calculate6(r1,r2,g,D,handles2)
addpath('functions');
rou=r2-r1;
global I1;
global I2;
global I1_edge;
global d;
global ratio;


[I11,I12]=seperate(I1);
[I12_edge]=half_1(I12);
[I11_edge]=half_2(I11);
[I1_edge]=joint(I11_edge,I12_edge);

[de,ds]=drop(I1_edge);
axes(handles2.axes2);
imshow(I1_edge);
title('the edge of the droplet');


t2=graythresh(I2);
I2_bw=im2bw(I2,t2);
I2_edge=edge(I2_bw, 'canny');
axes(handles2.axes3);
imshow(I2_edge);
title('the edge of the steel rod');

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