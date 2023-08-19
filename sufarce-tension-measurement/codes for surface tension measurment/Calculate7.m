% droplet: scenario 3
% steel rod: get the edge automatically
function f = Calculate7(r1,r2,g,D,handles2)
addpath('functions');
rou=r2-r1;
global I;
global I1;
global I2;
global I1_edge;
global d;
global ratio;
I1_gray=rgb2gray(I1);

axes(handles2.axes2);
imshow(I1_gray);
title('Select a fuzzy point on the inner edge：');
[x,y]=ginput(1);
gray=I1_gray(round(y),round(x));
[r1,c1]=size(I1_gray);
I_gray=rgb2gray(I);
[r,c]=size(I_gray);
if I_gray(round(r/2),round(c/2))<100
    max=300;
else
    max=0;
end
for m=1:r1
    for n=1:c1
        if abs(I1_gray(m,n)-gray)<0.001
            I1_gray(m,n)=max;
        end
    end
end

I1_edge=edge(I1_gray,'sobel');
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