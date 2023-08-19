%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'adaptive residual interpolation' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices)
function [I0_d,I45_d,I90_d,I135_d] = ARI1(mosaic,mask)
% 90 45
% 135 0
%% initial
eps = 1e-10;
h = 5; v = 5; 
%% guide image
I=sum(mosaic,3);
H=[0.5 0.5;0.5 0.5];
G=conv2(I,H,"same");
%% interpolation
I0_d=I0_interpolation(G, mosaic, mask, h, v, eps);
I45_d=I45_interpolation(G, mosaic, mask, h, v, eps);
I135_d=I135_interpolation(G, mosaic, mask, h, v, eps);
I90_d=I90_interpolation(G, mosaic, mask, h, v, eps);
end