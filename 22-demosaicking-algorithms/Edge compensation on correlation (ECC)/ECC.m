%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'edge compensation on correlation' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = ECC(mosaic,mask)
% 90 45
% 135 0
[r,c,h]=size(mosaic);
%% initial interpolation
i90=mosaic(:,:,1);
i45=mosaic(:,:,2);
i135=mosaic(:,:,3);
i0=mosaic(:,:,4);
F=0.25*[1 2 1;
        2 4 2;
        1 2 1];
i90_F=conv2(i90,F,"same");
i45_F=conv2(i45,F,"same");
i135_F=conv2(i135,F,"same");
i0_F=conv2(i0,F,"same");

i90_F=padarray(i90_F,[2 2]);
i45_F=padarray(i45_F,[2 2]);
i135_F=padarray(i135_F,[2 2]);
i0_F=padarray(i0_F,[2 2]);
%% second-order differential
de_h90=zeros(r+4,c+4);
de_v90=zeros(r+4,c+4);
de_h45=zeros(r+4,c+4);
de_v45=zeros(r+4,c+4);
de_h135=zeros(r+4,c+4);
de_v135=zeros(r+4,c+4);
de_h0=zeros(r+4,c+4);
de_v0=zeros(r+4,c+4);
for i=3:r+2
    for j=3:c+2
        de_h90(i,j)=(i90_F(i,j+2)+i90_F(i,j-2)-2*i90_F(i,j))/4;
        de_v90(i,j)=(i90_F(i+2,j)+i90_F(i-2,j)-2*i90_F(i,j))/4;

        de_h45(i,j)=(i45_F(i,j+2)+i45_F(i,j-2)-2*i45_F(i,j))/4;
        de_v45(i,j)=(i45_F(i+2,j)+i45_F(i-2,j)-2*i45_F(i,j))/4;

        de_h135(i,j)=(i135_F(i,j+2)+i135_F(i,j-2)-2*i135_F(i,j))/4;
        de_v135(i,j)=(i135_F(i+2,j)+i135_F(i-2,j)-2*i135_F(i,j))/4;

        de_h0(i,j)=(i0_F(i,j+2)+i0_F(i,j-2)-2*i0_F(i,j))/4;
        de_v0(i,j)=(i0_F(i+2,j)+i0_F(i-2,j)-2*i0_F(i,j))/4;
    end
end

%% average
av_h90=zeros(r+4,c+4);
av_v90=zeros(r+4,c+4);
av_h45=zeros(r+4,c+4);
av_v45=zeros(r+4,c+4);
av_h135=zeros(r+4,c+4);
av_v135=zeros(r+4,c+4);
av_h0=zeros(r+4,c+4);
av_v0=zeros(r+4,c+4);
for i=3:r+2
    for j=3:c+2
        av_h90(i,j)=0.5*(i90_F(i,j+1)+i90_F(i,j-1));
        av_v90(i,j)=0.5*(i90_F(i+1,j)+i90_F(i-1,j));
        av_h45(i,j)=0.5*(i45_F(i,j+1)+i45_F(i,j-1));
        av_v45(i,j)=0.5*(i45_F(i+1,j)+i45_F(i-1,j));
        av_h135(i,j)=0.5*(i135_F(i,j+1)+i135_F(i,j-1));
        av_v135(i,j)=0.5*(i135_F(i+1,j)+i135_F(i-1,j));
        av_h0(i,j)=0.5*(i0_F(i,j+1)+i0_F(i,j-1));
        av_v0(i,j)=0.5*(i0_F(i+1,j)+i0_F(i-1,j));
    end
end

%% second interpolation
i90_2d=0.5*((av_h90-de_h90)+(av_v90-de_v90));
i45_2d=0.5*((av_h45-de_h45)+(av_v45-de_v45));
i135_2d=0.5*((av_h135-de_h135)+(av_v135-de_v135));
i0_2d=0.5*((av_h0-de_h0)+(av_v0-de_v0));

i90_2d=i90_2d(3:r+2,3:c+2);
i45_2d=i45_2d(3:r+2,3:c+2);
i135_2d=i135_2d(3:r+2,3:c+2);
i0_2d=i0_2d(3:r+2,3:c+2);

%% difference interpolation
% 90
d90_45=i45_2d.*mask(:,:,1)-i90;
d90_135=i135_2d.*mask(:,:,1)-i90;
d90_45=conv2(d90_45,F,"same");
d90_135=conv2(d90_135,F,"same");
i90_45=i45_2d-d90_45;
i90_135=i135_2d-d90_135;
I90_d=0.5*(i90_45+i90_135);
% 45
d45_0=i0_2d.*mask(:,:,2)-i45;
d45_90=i90_2d.*mask(:,:,2)-i45;
d45_0=conv2(d45_0,F,"same");
d45_90=conv2(d45_90,F,"same");
i45_0=i0_2d-d45_0;
i45_90=i90_2d-d45_90;
I45_d=0.5*(i45_0+i45_90);
% 135
d135_0=i0_2d.*mask(:,:,3)-i135;
d135_90=i90_2d.*mask(:,:,3)-i135;
d135_0=conv2(d135_0,F,"same");
d135_90=conv2(d135_90,F,"same");
i135_0=i0_2d-d135_0;
i135_90=i90_2d-d135_90;
I135_d=0.5*(i135_0+i135_90);
% 0
d0_45=i45_2d.*mask(:,:,4)-i0;
d0_135=i135_2d.*mask(:,:,4)-i0;
d0_45=conv2(d0_45,F,"same");
d0_135=conv2(d0_135,F,"same");
i0_45=i45_2d-d0_45;
i0_135=i135_2d-d0_135;
I0_d=0.5*(i0_45+i0_135);

end