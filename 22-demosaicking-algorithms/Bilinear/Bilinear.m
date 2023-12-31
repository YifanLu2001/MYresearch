%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'Bilinear' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = Bilinear(mosaic)

H=0.25*[1 2 1;2 4 2;1 2 1];
  I90=mosaic(:,:,1);
  I45=mosaic(:,:,2);
  I135=mosaic(:,:,3);
  I0=mosaic(:,:,4);
  
  I90_d=conv2( I90,H,"same");
  I45_d=conv2( I45,H,"same");
  I135_d=conv2( I135,H,"same");
  I0_d=conv2( I0,H,"same");

end