%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'B1' kernel
%
%% Input:
% The mosaic matrix, mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = B1(mosaic,mask)
H1=[0 0 0;0 1 0;0 0 0];
H2=[0 0 0;0.5 0 0.5;0 0 0];
H3=[0 0.5 0;0 0 0;0 0.5 0];

raw_image=sum(mosaic,3);
I0_d=conv2(raw_image,H1,'same');
I45_d=conv2(raw_image,H3,'same');
I135_d=conv2(raw_image,H2,'same');
I90_d=I135_d+I45_d-I0_d;


end