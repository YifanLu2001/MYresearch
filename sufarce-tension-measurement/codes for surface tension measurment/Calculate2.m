% droplet: scenario 2
% steel rod: get the edge manually (select a point on the left and right edges respectively)

function f = Calculate2(r1,r2,g,D,handles2)

%% pre
addpath('functions');
rou=r2-r1;
global I1;
global I2;
global I1_edge;

%% droplet
[I11,I12]=seperate(I1);
[I12_edge]=half_1(I12);
[I11_edge]=half_2(I11);
[I1_edge]=joint(I11_edge,I12_edge);
[de,ds]=drop(I1_edge);
axes(handles2.axes2);
imshow(I1_edge);
title('');

%% steel rod
axes(handles2.axes3);
imshow(I2);
title('Select out the 2 sides:');
[x,y]=ginput(2);
d=abs(x(2,1)-x(1,1));
ratio=D/d;
axes(handles2.axes3);
imshow(I2);
title('');

%% get the coefficient
De=de*ratio;
Ds=ds*ratio;
s = ds/de ;
num = xlsread('S_H.xlsx');
S=num(:,1);
H=num(:,2);
h=interp1(S,H,s);
st_water=g*rou*De^2*(1/h)/1000;
set(handles2.edit5,'string',num2str(st_water));
