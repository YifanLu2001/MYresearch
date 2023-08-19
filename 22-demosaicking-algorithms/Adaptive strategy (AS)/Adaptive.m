%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'adaptive strategy' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices)

function [I0_d,I45_d,I90_d,I135_d] = Adaptive(mosaic,mask)
raw_image=sum(mosaic,3);
hv=[0 0.5 0;0 0 0;0 0.5 0];
hh=[0 0 0;0.5 0 0.5;0 0 0];
hd=[0.25 0 0.25;0 0 0;0.25 0 0.25];
[r,c]=size(raw_image);
I00=zeros(r,c);
I045=zeros(r,c);
I090=zeros(r,c);
I0135=zeros(r,c);
raw_image=padarray(raw_image,[1 1],'symmetric');

for i=2:(r+1)
    for j=2:(c+1)
        hi=Hi(raw_image,i,j); 
        bv=normalizing(hv.*hi);
        bh=normalizing(hh.*hi);
        bd=normalizing(hd.*hi);
        
        D=sum(sum(bd.*raw_image((i-1):(i+1),(j-1):(j+1))));
        V=sum(sum(bv.*raw_image((i-1):(i+1),(j-1):(j+1))));
        H=sum(sum(bh.*raw_image((i-1):(i+1),(j-1):(j+1))));
        C=raw_image(i,j);

        if (rem(i,2)==0)&(rem(j,2)==0) % This is 0° pixel
        I00(i-1,j-1)=C;
        I045(i-1,j-1)=V;
        I090(i-1,j-1)=D;
        I0135(i-1,j-1)=H;
        elseif(rem(i,2)==0)&(rem(j,2)==1) % This is 135° pixel
        I00(i-1,j-1)=H;
        I045(i-1,j-1)=D;
        I090(i-1,j-1)=V;
        I0135(i-1,j-1)=C;
        elseif(rem(i,2)==1)&(rem(j,2)==0) % This is 45° pixel
        I00(i-1,j-1)=V;
        I045(i-1,j-1)=C;
        I090(i-1,j-1)=H;
        I0135(i-1,j-1)=D;
        else                              % This is 90° pixel
        I00(i-1,j-1)=D;
        I045(i-1,j-1)=H;
        I090(i-1,j-1)=C;
        I0135(i-1,j-1)=V;
   
        end

    end
end
I0_d=I045+I0135-I090;
I45_d=I00+I090-I0135;
I90_d=I045+I0135-I00;
I135_d=I00+I090-I045;

end