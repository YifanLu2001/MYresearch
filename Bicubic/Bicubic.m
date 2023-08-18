%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'Bicubic' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = Bicubic(mosaic)

compact = cat(3,mosaic(1:2:end,1:2:end,1),mosaic(1:2:end,2:2:end,2),mosaic(2:2:end,1:2:end,3),mosaic(2:2:end,2:2:end,4));

  fourD_image=imresize(compact,2,"bicubic");
  I90_d=fourD_image(:,:,1);
  I45_d=fourD_image(:,:,2);
  I135_d=fourD_image(:,:,3);
  I0_d=fourD_image(:,:,4);
end