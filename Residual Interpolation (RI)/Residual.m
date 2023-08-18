%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'residual interpolation' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = Residual(mosaic,mask)
% 90 45
% 135 0
%% guide image
I=sum(mosaic,3);
h=[0.5 0.5;0.5 0.5];
G=conv2(I,h,"same");
%% tentative estimates
I90=mosaic(:,:,1);
I45=mosaic(:,:,2);
I135=mosaic(:,:,3);
I0=mosaic(:,:,4);
I90t=imguidedfilter(I90,G);
I45t=imguidedfilter(I45,G);
I135t=imguidedfilter(I135,G);
I0t=imguidedfilter(I0,G);
%% residual
I90r=(I90-I90t).*mask(:,:,1);
I45r=(I45-I45t).*mask(:,:,2);
I135r=(I135-I135t).*mask(:,:,3);
I0r=(I0-I0t).*mask(:,:,4);
%% interpolate the residual channel by bilinear interpolation
mosaic2=zeros(size(mosaic));
mosaic2(:,:,1) = I90r;
mosaic2(:,:,2) = I45r;
mosaic2(:,:,3) = I135r;
mosaic2(:,:,4) = I0r;
[I0_r,I45_r,I90_r,I135_r] = Bilinear(mosaic2);
%% add
I90_d=I90_r+I90t;
I45_d=I45_r+I45t;
I135_d=I135_r+I135t;
I0_d=I0_r+I0t;

end