%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'Bicubic spline' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices)  
function [I0_d,I45_d,I90_d,I135_d] = Bicubic_Spline(mosaic)

compact = cat(3,mosaic(1:2:end,1:2:end,1),mosaic(1:2:end,2:2:end,2),mosaic(2:2:end,1:2:end,3),mosaic(2:2:end,2:2:end,4));
 x=(1:size(compact,1));
 y=(1:size(compact,2));
 [X,Y]=meshgrid(y,x);
 xq=(1:0.5:(size(compact,1)+0.5));
 yq=(1:0.5:(size(compact,2)+0.5));
 [Xq,Yq]=meshgrid(yq,xq);

 I90_d=interp2(X,Y,compact(:,:,1),Xq,Yq,"spline");
 I135_d=interp2(X,Y,compact(:,:,3),Xq,Yq,"spline");
 I0_d=interp2(X,Y,compact(:,:,4),Xq,Yq,"spline");
 I45_d=interp2(X,Y,compact(:,:,2),Xq,Yq,"spline");
 
end