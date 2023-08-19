%% process the droplet image in scenario 2
% separate the left & right parts of the droplet evenly
% so that they can be edge-detected separately later 
function [I11,I12]=seperate(I1)
I1_gray=rgb2gray(I1);
[r,c]=size(I1_gray);
c_middle=round(c/2);
I11=I1_gray(:,1:c_middle);
I12=I1_gray(:,c_middle+1:c);
end