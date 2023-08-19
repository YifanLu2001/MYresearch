%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'pseudo-panchromatic image difference' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = PPID(mosaic,mask)
% 90 45
% 135 0
%% normalized raw image
[r,c,h]=size(mosaic);
Max=max(max(max(mosaic)));
Max_90=max(max(mosaic(:,:,1)));
Max_45=max(max(mosaic(:,:,2)));
Max_135=max(max(mosaic(:,:,3)));
Max_0=max(max(mosaic(:,:,4)));

I90=mosaic(:,:,1)*(Max/Max_90);
I45=mosaic(:,:,2)*(Max/Max_45);
I135=mosaic(:,:,3)*(Max/Max_135);
I0=mosaic(:,:,4)*(Max/Max_0);

raw_e=I90+I45+I135+I0;

%% PPI
M=1/16*[1 2 1;2 4 2;1 2 1];
PPI=conv2(raw_e,M,"same");

%% get the difference channel
d_90=I90-PPI.*mask(:,:,1);
d_45=I45-PPI.*mask(:,:,2);
d_135=I135-PPI.*mask(:,:,3);
d_0=I0-PPI.*mask(:,:,4);

%% interpolate the difference channel
mosaic1=cat(3,d_90,d_45,d_135,d_0);
[I0_d1,I45_d1,I90_d1,I135_d1] = BT(mosaic1);

%% add
I0_d=PPI+I0_d1;
I45_d=PPI+I45_d1;
I90_d=PPI+I90_d1;
I135_d=PPI+I135_d1;

end