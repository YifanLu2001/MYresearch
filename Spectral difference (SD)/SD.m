%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'spectral difference' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = SD(mosaic,mask)
% 90 45
% 135 0
I90=mosaic(:,:,1);
I45=mosaic(:,:,2);
I135=mosaic(:,:,3);
I0=mosaic(:,:,4);
H=0.25*[1 2 1;2 4 2;1 2 1];

I90_b=conv2(I90,H,"same");
I45_b=conv2(I45,H,"same");
I135_b=conv2(I135,H,"same");
I0_b=conv2(I0,H,"same");

%% 90
%45
K=(I45_b-I90).*mask(:,:,1);
K_b=conv2(K,H,"same");
I1=I45-K_b.*mask(:,:,2);
%135
K=(I135_b-I90).*mask(:,:,1);
K_b=conv2(K,H,"same");
I2=I135-K_b.*mask(:,:,3);
%0
K=(I0_b-I90).*mask(:,:,1);
K_b=conv2(K,H,"same");
I3=I0-K_b.*mask(:,:,4);
%sum
I90_d=I1+I2+I3+I90;

%% 45
%90
K=(I90_b-I45).*mask(:,:,2);
K_b=conv2(K,H,"same");
I1=I90-K_b.*mask(:,:,1);
%135
K=(I135_b-I45).*mask(:,:,2);
K_b=conv2(K,H,"same");
I2=I135-K_b.*mask(:,:,3);
%0
K=(I0_b-I45).*mask(:,:,2);
K_b=conv2(K,H,"same");
I3=I0-K_b.*mask(:,:,4);
%sum
I45_d=I1+I2+I3+I45;

%% 135
%90
K=(I90_b-I135).*mask(:,:,3);
K_b=conv2(K,H,"same");
I1=I90-K_b.*mask(:,:,1);
%45
K=(I45_b-I135).*mask(:,:,3);
K_b=conv2(K,H,"same");
I2=I45-K_b.*mask(:,:,2);
%0
K=(I0_b-I135).*mask(:,:,3);
K_b=conv2(K,H,"same");
I3=I0-K_b.*mask(:,:,4);
%sum
I135_d=I1+I2+I3+I135;

%% 0
%90
K=(I90_b-I0).*mask(:,:,4);
K_b=conv2(K,H,"same");
I1=I90-K_b.*mask(:,:,1);
%45
K=(I45_b-I0).*mask(:,:,4);
K_b=conv2(K,H,"same");
I2=I45-K_b.*mask(:,:,2);
%135
K=(I135_b-I0).*mask(:,:,4);
K_b=conv2(K,H,"same");
I3=I135-K_b.*mask(:,:,3);
%sum
I0_d=I1+I2+I3+I0;

end