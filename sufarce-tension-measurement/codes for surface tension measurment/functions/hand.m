%% get 2 parameters by choosing edge points manually from users
% input: the image of the steel rod 'I'; 
%        the real width of the steel rod 'D' (mm); 
% output:the number of pixels of the rod's width 'd';
%        the ratio of the real length over the number of pixels in an image 'ratio'

function [d,ratio]=hand(I,D)

%% select 2 points as the positions of left and right edges of the rod
figure;
imshow(I);
title('Please select a point on left and right edges respectively£º');

%% get the 2 parameters
[x,y]=ginput(2)
d=abs(x(2,1)-x(1,1));
ratio=D/d;
end