%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'B3' kernel
%
%% Input:
% The mosaic matrix, mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = B3(mosaic,mask)
a=0.4086;
b=0.2957;
H1=[0 b 0 0;0 0 0 0;0 a 0 b;0 0 0 0];
H2=[0 0 b 0;0 0 0 0;b 0 a 0;0 0 0 0];
H3=[0 0 0 0;b 0 a 0;0 0 0 0;0 0 b 0];
H4=[0 0 0 0;0 a 0 b;0 0 0 0;0 b 0 0];

raw=sum(mosaic,3);
I0_d=conv2(raw,H4,'same');
I135_d=conv2(raw,H3,'same');
I45_d=conv2(raw,H1,'same');
I90_d=conv2(raw,H2,'same');

end