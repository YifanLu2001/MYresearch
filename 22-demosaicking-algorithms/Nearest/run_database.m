%% Describe:
% This function can calculate one scenario (4 RGB pics)'s 10 evaluation indexes.  
% It will mosaic a ground-truth scenario first, demosaic it with the
%   specific algorithm discussed in this folder, and then compare 
%   the polarization parameters before and after demosaicing.
% It will use objective indicators to describe the demosaicing performance. 
%
%% Note:
% This function should be used as one process of the 'GET_EXCEL' code. 
%
%% Input:
% 4 RGB polarization images from one scenario.
%
%% Output:
% A 'result' matrix:
%   record 10 evaluation indexes of the demosaicing process with this
%   algorithm, including PSNRs of I0, I45, I90, I135, S0, S1, S2, DOLP, 
%   AOLP and the running time.


function result=run_database(I0,I45,I90,I135)
% add functions folder
addpath('general_functions');
tic
% abstract monochrome polarization image by green channel: origin (I0 I45 I90 I135)
I0 = normalize2D(I0(:,:,2));
I45 = normalize2D(I45(:,:,2));
I90 = normalize2D(I90(:,:,2));
I135 = normalize2D(I135(:,:,2));
origin = cat(3,I90,I45,I135,I0);
% caculate polarization parameters of Origin Image (S0 S1 S2 DOLP AOLP)
[S0,S1,S2,DOLP,AOLP] = calculateStokes(I0,I45,I90,I135);
% set mosaic pattern: mask
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
% make the Mosaic Image: mosaic
mosaic(:,:,1) = origin(:,:,1) .* mask_90;
mosaic(:,:,2) = origin(:,:,2) .* mask_45;
mosaic(:,:,3) = origin(:,:,3) .* mask_135;
mosaic(:,:,4) = origin(:,:,4) .* mask_0;

% get the Demosaic Image: demosaic (I0_d,I45_d,I90_d,I135_d)
[I0_d,I45_d,I90_d,I135_d] = Nearest(mosaic,mask);
toc
t=toc;

% caculate Stokes parameters of Demosaic Image (S0_d,S1_d,S2_d,DOLP_d,AOLP_d)
[S0_d,S1_d,S2_d,DOLP_d,AOLP_d] = calculateStokes(I0_d,I45_d,I90_d,I135_d);
% caculate PSNRs
psnr_90 = Impsnr(I90_d,I90,1,15);
psnr_45 = Impsnr(I45_d,I45,1,15);  
psnr_135 = Impsnr(I135_d,I135,1,15);  
psnr_0 = Impsnr(I0_d,I0,1,15);
psnr_S0 = Impsnr(S0_d,S0,1,15);
psnr_S1 = Impsnr(S1_d,S1,1,15);
psnr_S2 = Impsnr(S2_d,S2,1,15);
psnr_DOLP = Impsnr(DOLP_d,DOLP,1,15);
psnr_AOLP = Impsnr_AOLP(AOLP_d,AOLP,15);
PSNR=[psnr_0 psnr_45 psnr_90 psnr_135 ;psnr_S0 psnr_S1 psnr_S2 0 ;psnr_DOLP psnr_AOLP 0 0];

% get the 'result' matrix
result = [psnr_0 psnr_45 psnr_90 psnr_135 psnr_S0 psnr_S1 psnr_S2 psnr_DOLP psnr_AOLP t];

end