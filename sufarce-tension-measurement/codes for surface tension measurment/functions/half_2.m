%% process the droplet image in scenario 2
% get the edge of the blurry half droplet 

function [I11_edge]=half_2(I11)
%% use binary image to sharpen the half droplet
I11=adapthisteq(I11);
t1=graythresh(I11);
I11=im2bw(I11,t1);

%% get the edge
I11_edge=edge(I11,'sobel');

end