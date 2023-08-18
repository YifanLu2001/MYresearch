%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'modified residual interpolation' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = Residual_GF(mosaic,mask)
% 90 45
% 135 0
mosaic2=zeros(size(mosaic));
I=sum(mosaic,3);
%% 4 original sparse channels & full guided filter
I90_osp=mosaic(:,:,1);
I45_osp=mosaic(:,:,2);
I135_osp=mosaic(:,:,3);
I0_osp=mosaic(:,:,4);
[I0_g,I45_g,I90_g,I135_g] = Bilinear(mosaic);
%% tentative estimate by guided filtering (full)
I90_e = imguidedfilter(I90_osp,I90_g);
I45_e = imguidedfilter(I45_osp,I45_g);
I135_e = imguidedfilter(I135_osp,I135_g);
I0_e = imguidedfilter(I0_osp,I0_g);

%% make residuals and interpolate then plus
I90_r=I90_osp-I90_e;
I45_r=I45_osp-I45_e;
I135_r=I135_osp-I135_e;
I0_r=I0_osp-I0_e;
mosaic2(:,:,1) = I90_r .* mask(:,:,1);
mosaic2(:,:,2) = I45_r .* mask(:,:,2);
mosaic2(:,:,3) = I135_r .* mask(:,:,3);
mosaic2(:,:,4) = I0_r .* mask(:,:,4);
[I0_r,I45_r,I90_r,I135_r] = Bilinear(mosaic2);

I90_d=I90_r+I90_e;
I45_d=I45_r+I45_e;
I135_d=I135_r+I135_e;
I0_d=I0_r+I0_e;
end