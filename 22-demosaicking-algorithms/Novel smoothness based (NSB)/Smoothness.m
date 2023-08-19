%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'novel smoothness based' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = Smoothness(mosaic)
% 90 45
% 135 0
I90=mosaic(:,:,1);
I45=mosaic(:,:,2);
I135=mosaic(:,:,3);
I0=mosaic(:,:,4);
I90=padarray(I90,[3 3]);
I45=padarray(I45,[3 3]);
I135=padarray(I135,[3 3]);
I0=padarray(I0,[3 3]);

I=sum(mosaic,3);
I=padarray(I,[3 3]);
[r,c]=size(I);
%% sigma 
S=zeros(r,c);
n=0;
for i=4:2:r-3
    for j=4:2:c-3
        E=(I(i,j)+I(i,j+1)+I(i+1,j)+I(i+1,j+1))/4;
        J=1/3*((I(i,j)-E)^2+(I(i,j+1)-E)^2+(I(i+1,j)-E)^2+(I(i+1,j+1)-E)^2);
        s=sqrt(J);
        S(i,j)=s;
        n=n+1;
    end
end
S_m=sum(sum(S))/n;
%% compare and interpolate
for i=4:2:r-3
    for j=4:2:c-3
        if S(i,j)<S_m
            % bilinear
            % 90
            I90(i+1,j+1)=(I90(i,j)+I90(i,j+2)+I90(i+2,j)+I90(i+2,j+2))/4;
            I90(i,j+1)=(I90(i,j)+I90(i,j+2))/2;
            I90(i+1,j)=(I90(i,j)+I90(i+2,j))/2;
            %45
            I45(i+1,j)=(I45(i,j-1)+I45(i,j+1)+I45(i+2,j-1)+I45(i+2,j+1))/4;
            I45(i,j)=(I45(i,j-1)+I45(i,j+1))/2;
            I45(i+1,j+1)=(I45(i,j+1)+I45(i+2,j+1))/2;
           %135
            I135(i,j+1)=(I135(i+1,j)+I135(i-1,j)+I135(i-1,j+2)+I135(i+1,j+2))/4;
            I135(i,j)=(I135(i-1,j)+I135(i+1,j))/2;
            I135(i+1,j+1)=(I135(i+1,j)+I135(i+1,j+2))/2;
            %0
            I0(i,j)=(I0(i-1,j-1)+I0(i-1,j+1)+I0(i+1,j-1)+I0(i+1,j+1))/4;
            I0(i,j+1)=(I0(i-1,j+1)+I0(i+1,j+1))/2;
            I0(i+1,j)=(I0(i+1,j-1)+I0(i+1,j+1))/2;
        else
            % bicubic
           B90=I(i-2:2:i+4,j-2:2:j+4);
           I90(i+1,j+1)=bicu(B90,0.5,0.5);
           I90(i,j+1)=bicu(B90,0,0.5);
           I90(i+1,j)=bicu(B90,0.5,0);

           B45=I(i-2:2:i+4,j-3:2:j+3);
           I45(i+1,j)=bicu(B45,0.5,0.5);
           I45(i,j)=bicu(B45,0,0.5);
           I45(i+1,j+1)=bicu(B45,0.5,0);

           B135=I(i-3:2:i+3,j-2:2:j+4);
           I135(i,j+1)=bicu(B135,0.5,0.5);
           I135(i,j)=bicu(B135,0.5,0);
           I135(i+1,j+1)=bicu(B135,0,0.5);

           B0=I(i-3:2:i+3,j-3:2:j+3);
           I0(i,j)=bicu(B0,0.5,0.5);
           I0(i,j+1)=bicu(B0,0.5,0);
           I0(i+1,j)=bicu(B0,0,0.5);
          end
    end
end

I0_d=I0(4:r-3,4:c-3);
I45_d=I45(4:r-3,4:c-3);
I135_d=I135(4:r-3,4:c-3);
I90_d=I90(4:r-3,4:c-3);

end