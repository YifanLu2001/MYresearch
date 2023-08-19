%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'discrete wavelet transform' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = DWT(mosaic,mask)
% 90 45
% 135 0
%% bilinear interpolation 
[r,c,h]=size(mosaic);
I90=mosaic(:,:,1);
I45=mosaic(:,:,2);
I135=mosaic(:,:,3);
I0=mosaic(:,:,4);
H=0.25*[1 2 1;2 4 2;1 2 1];
I90_b=conv2(I90,H,"same");
I45_b=conv2(I45,H,"same");
I135_b=conv2(I135,H,"same");
I0_b=conv2(I0,H,"same");
%% get DS
% 90
DS90_90=I90_b(1:2:end,1:2:end);
DS90_45=I90_b(1:2:end,2:2:end);
DS90_135=I90_b(2:2:end,1:2:end);
DS90_0=I90_b(2:2:end,2:2:end);
% 45
DS45_90=I45_b(1:2:end,1:2:end);
DS45_45=I45_b(1:2:end,2:2:end);
DS45_135=I45_b(2:2:end,1:2:end);
DS45_0=I45_b(2:2:end,2:2:end);
% 135
DS135_90=I135_b(1:2:end,1:2:end);
DS135_45=I135_b(1:2:end,2:2:end);
DS135_135=I135_b(2:2:end,1:2:end);
DS135_0=I135_b(2:2:end,2:2:end);
% 0
DS0_90=I0_b(1:2:end,1:2:end);
DS0_45=I0_b(1:2:end,2:2:end);
DS0_135=I0_b(2:2:end,1:2:end);
DS0_0=I0_b(2:2:end,2:2:end);

%% decompose 
% 90
[CA90_90,CH90_90,CV90_90,CD90_90]=dwt2(DS90_90,'haar');
[CA90_45,CH90_45,CV90_45,CD90_45]=dwt2(DS90_45,'haar');
[CA90_135,CH90_135,CV90_135,CD90_135]=dwt2(DS90_135,'haar');
[CA90_0,CH90_0,CV90_0,CD90_0]=dwt2(DS90_0,'haar');
% 45
[CA45_90,CH45_90,CV45_90,CD45_90]=dwt2(DS45_90,'haar');
[CA45_45,CH45_45,CV45_45,CD45_45]=dwt2(DS45_45,'haar');
[CA45_135,CH45_135,CV45_135,CD45_135]=dwt2(DS45_135,'haar');
[CA45_0,CH45_0,CV45_0,CD45_0]=dwt2(DS45_0,'haar');
% 135
[CA135_90,CH135_90,CV135_90,CD135_90]=dwt2(DS135_90,'haar');
[CA135_45,CH135_45,CV135_45,CD135_45]=dwt2(DS135_45,'haar');
[CA135_135,CH135_135,CV135_135,CD135_135]=dwt2(DS135_135,'haar');
[CA135_0,CH135_0,CV135_0,CD135_0]=dwt2(DS135_0,'haar');
% 0
[CA0_90,CH0_90,CV0_90,CD0_90]=dwt2(DS0_90,'haar');
[CA0_45,CH0_45,CV0_45,CD0_45]=dwt2(DS0_45,'haar');
[CA0_135,CH0_135,CV0_135,CD0_135]=dwt2(DS0_135,'haar');
[CA0_0,CH0_0,CV0_0,CD0_0]=dwt2(DS0_0,'haar');

%% replace
% 45
CH45_90=CH90_90; CV45_90=CV90_90; CD45_90=CD90_90;
CH45_135=CH90_135;CV45_135=CV90_135;CD45_135=CD90_135;
CH45_0=CH90_0;CV45_0=CV90_0;CD45_0=CD90_0;
% 135
CH135_90=CH90_90;CV135_90=CV90_90;CD135_90=CD90_90;
CH135_45=CH90_45;CV135_45=CV90_45;CD135_45=CD90_45;
CH135_0=CH90_0;CV135_0=CV90_0;CD135_0=CD90_0;
% 0
CH0_90=CH90_90;CV0_90=CV90_90;CD0_90=CD90_90;
CH0_45=CH90_45;CV0_45=CV90_45;CD0_45=CD90_45;
CH0_135=CH90_135;CV0_135=CV90_135;CD0_135=CD90_135;

%% inverse 
% 90
DS90_90=idwt2(CA90_90,CH90_90,CV90_90,CD90_90,'haar');
DS90_45=idwt2(CA90_45,CH90_45,CV90_45,CD90_45,'haar');
DS90_135=idwt2(CA90_135,CH90_135,CV90_135,CD90_135,'haar');
DS90_0=idwt2(CA90_0,CH90_0,CV90_0,CD90_0,'haar');
% 45
DS45_90=idwt2(CA45_90,CH45_90,CV45_90,CD45_90,'haar');
DS45_45=idwt2(CA45_45,CH45_45,CV45_45,CD45_45,'haar');
DS45_135=idwt2(CA45_135,CH45_135,CV45_135,CD45_135,'haar');
DS45_0=idwt2(CA45_0,CH45_0,CV45_0,CD45_0,'haar');
% 135
DS135_90=idwt2(CA135_90,CH135_90,CV135_90,CD135_90,'haar');
DS135_45=idwt2(CA135_45,CH135_45,CV135_45,CD135_45,'haar');
DS135_135=idwt2(CA135_135,CH135_135,CV135_135,CD135_135,'haar');
DS135_0=idwt2(CA135_0,CH135_0,CV135_0,CD135_0,'haar');
% 0
DS90_90=idwt2(CA0_90,CH0_90,CV0_90,CD0_90,'haar');
DS90_45=idwt2(CA0_45,CH0_45,CV0_45,CD0_45,'haar');
DS90_135=idwt2(CA0_135,CH0_135,CV0_135,CD0_135,'haar');
DS90_0=idwt2(CA0_0,CH0_0,CV0_0,CD0_0,'haar');

%% recompose
I90_d=recompose(DS90_90,DS90_45,DS90_135,DS90_0,r,c);
I45_d=recompose(DS45_90,DS45_45,DS45_135,DS45_0,r,c);
I135_d=recompose(DS135_90,DS135_45,DS135_135,DS135_0,r,c);
I0_d=recompose(DS0_90,DS0_45,DS0_135,DS0_0,r,c);
end