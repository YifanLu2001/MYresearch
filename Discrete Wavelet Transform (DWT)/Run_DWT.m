%% Describe:
% This code shows the algorithm's demosaicing ability intuitively. 
% It will mosaic a ground-truth scenario first, demosaic it with the
%   specific algorithm discussed in this folder, and then compare 
%   the polarization parameters before and after demosaicing.
% It will use subjective and objective indicators to describe the demosaicing 
%   performance.  
%
%% Note:
% Make sure to put this code and the 'general_functions' folder in the 
%   same folder.
%
%% Input: 
% 4 RGB polarization images from the scenario 'woodwall'.
%
%% Output:
% 5 figures: showing 9 pairs of ground-truth and demosaiced polarization-
%   parameter images, including I0, I45, I90, I135, S0, S1, S2, DOLP and AOLP.
% A 'result' excel: PSNRs of these 9 pairs of images. 


%% PRE
clc
close all;
clear all;
% add functions folder
addpath('general_functions');
% Result folder
if exist('Results') == 0 
    mkdir('Results')
end
tic
% read polarization images (4 RGB pics)
I0 = double(imread('woodwall_0.png'));
I45 = double(imread('woodwall_45.png'));
I90 = double(imread('woodwall_90.png'));
I135 = double(imread('woodwall_135.png'));
% abstract monochrome polarization image by green channel: origin 
I0 = normalize2D(I0(:,:,2));
I45 = normalize2D(I45(:,:,2));
I90 = normalize2D(I90(:,:,2));
I135 = normalize2D(I135(:,:,2));
origin = cat(3,I90,I45,I135,I0);
%% caculate polarization parameters of Origin Image (I0,I45,I90,I135)
[S0,S1,S2,DOLP,AOLP] = calculateStokes(I0,I45,I90,I135);


%% set mosaic pattern: mask
% 90 45
% 135 0
r = size(I0,1);
c = size(I0,2);
mask = [];
for i = 1:2
    for j = 1:2
        temp_mask = zeros(r,c);
        temp_mask(i:2:end,j:2:end) = 1;
        mask = cat(3,mask,temp_mask);
    end
end
mask_90 = mask(:,:,1);
mask_45 = mask(:,:,2);
mask_135 = mask(:,:,3);
mask_0 = mask(:,:,4);
%% make the Mosaic Image: mosaic
mosaic(:,:,1) = origin(:,:,1) .* mask_90;
mosaic(:,:,2) = origin(:,:,2) .* mask_45;
mosaic(:,:,3) = origin(:,:,3) .* mask_135;
mosaic(:,:,4) = origin(:,:,4) .* mask_0;


%% get the Demosaic Image: demosaic (I0_d,I45_d,I90_d,I135_d)
[I0_d,I45_d,I90_d,I135_d] =  DWT(mosaic,mask);
toc
t=toc;
%% caculate polarization parameters of Demosaic Image (S0_d,S1_d,S2_d,DOLP_d,AOLP_d)
[S0_d,S1_d,S2_d,DOLP_d,AOLP_d] = calculateStokes(I0_d,I45_d,I90_d,I135_d);


%% caculate PSNR, and use images 
% show 10 image pairs 
DrawPairs(I0,I45,I90,I135,S0,S1,S2,DOLP,AOLP,I0_d,I45_d,I90_d,I135_d,S0_d,S1_d,S2_d,DOLP_d,AOLP_d);
% calculate PSNRs by excluding a 15(or 14) pixel wide margin each side
psnr_90 = Impsnr(I90_d,I90,1,15);
psnr_45 = Impsnr(I45_d,I45,1,15);  
psnr_135 = Impsnr(I135_d,I135,1,15);  
psnr_0 = Impsnr(I0_d,I0,1,15);
psnr_S0 = Impsnr(S0_d,S0,1,15);
psnr_S1 = Impsnr(S1_d,S1,1,15);
psnr_S2 = Impsnr(S2_d,S2,1,15);
psnr_DOLP = Impsnr(DOLP_d,DOLP,1,15);
psnr_AOLP = Impsnr_AOLP(AOLP_d,AOLP,15);
PSNR=[psnr_0 psnr_45 psnr_90 psnr_135 ;psnr_S0 psnr_S1 psnr_S2 0 ;psnr_DOLP psnr_AOLP 0 0]
%% write down the results (create a folder)
result = [psnr_0 psnr_45 psnr_90 psnr_135 psnr_S0 psnr_S1 psnr_S2 psnr_DOLP psnr_AOLP t];
csvwrite('Results/result.csv',result);

