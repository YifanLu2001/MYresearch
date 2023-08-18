%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'Binary tree' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = BT(mosaic)
% 90 45
% 135 0
%% initial 
I90=mosaic(:,:,1);
I45=mosaic(:,:,2);
I135=mosaic(:,:,3);
I0=mosaic(:,:,4);
I90=padarray(I90, [3 3]);
I45=padarray(I45, [3 3]);
I135=padarray(I135, [3 3]);
I0=padarray(I0, [3 3]);
[r,c]=size(I90);
%% interpolate diagonal pixels
% 90
for i=5:2:r-3
    for j=5:2:c-3
        V1=1/(1 + abs(I90(i-1,j+1)-I90(i-3,j+3)) + abs(I90(i-1,j+1)-I90(i+1,j-1)) + 0.5*abs(I90(i-1,j-1)-I90(i-3,j+1)) + 0.5*abs(I90(i+1,j+1)-I90(i-1,j+3)));
        V2=1/(1 + abs(I90(i+1,j-1)-I90(i+3,j-3)) + abs(I90(i+1,j-1)-I90(i-1,j+1)) + 0.5*abs(I90(i-1,j-1)-I90(i+1,j-3)) + 0.5*abs(I90(i+1,j+1)-I90(i+3,j-1)));
        H1=1/(1 + abs(I90(i+1,j+1)-I90(i+3,j+3)) + abs(I90(i+1,j+1)-I90(i-1,j-1)) + 0.5*abs(I90(i-1,j+1)-I90(i+1,j+3)) + 0.5*abs(I90(i+1,j-1)-I90(i+3,j+1)));
        H2=1/(1 + abs(I90(i-1,j-1)-I90(i-3,j-3)) + abs(I90(i-1,j-1)-I90(i+1,j+1)) + 0.5*abs(I90(i-1,j+1)-I90(i-3,j-1)) + 0.5*abs(I90(i+1,j-1)-I90(i-1,j-3)));
        I90(i,j)=( V1*I90(i-1,j+1)+V2*I90(i+1,j-1)+H1*I90(i+1,j+1)+H2*I90(i-1,j-1) )/( V1+V2+H1+H2 );
    end
end
% 45
for i=5:2:r-3
    for j=4:2:c-3
        V1=1/(1 + abs(I45(i-1,j+1)-I45(i-3,j+3)) + abs(I45(i-1,j+1)-I45(i+1,j-1)) + 0.5*abs(I45(i-1,j-1)-I45(i-3,j+1)) + 0.5*abs(I45(i+1,j+1)-I45(i-1,j+3)));
        V2=1/(1 + abs(I45(i+1,j-1)-I45(i+3,j-3)) + abs(I45(i+1,j-1)-I45(i-1,j+1)) + 0.5*abs(I45(i-1,j-1)-I45(i+1,j-3)) + 0.5*abs(I45(i+1,j+1)-I45(i+3,j-1)));
        H1=1/(1 + abs(I45(i+1,j+1)-I45(i+3,j+3)) + abs(I45(i+1,j+1)-I45(i-1,j-1)) + 0.5*abs(I45(i-1,j+1)-I45(i+1,j+3)) + 0.5*abs(I45(i+1,j-1)-I45(i+3,j+1)));
        H2=1/(1 + abs(I45(i-1,j-1)-I45(i-3,j-3)) + abs(I45(i-1,j-1)-I45(i+1,j+1)) + 0.5*abs(I45(i-1,j+1)-I45(i-3,j-1)) + 0.5*abs(I45(i+1,j-1)-I45(i-1,j-3)));
        I45(i,j)=( V1*I45(i-1,j+1)+V2*I45(i+1,j-1)+H1*I45(i+1,j+1)+H2*I45(i-1,j-1) )/( V1+V2+H1+H2 );
    end
end
% 135
for i=4:2:r-3
    for j=5:2:c-3
        V1=1/(1 + abs(I135(i-1,j+1)-I135(i-3,j+3)) + abs(I135(i-1,j+1)-I135(i+1,j-1)) + 0.5*abs(I135(i-1,j-1)-I135(i-3,j+1)) + 0.5*abs(I135(i+1,j+1)-I135(i-1,j+3)));
        V2=1/(1 + abs(I135(i+1,j-1)-I135(i+3,j-3)) + abs(I135(i+1,j-1)-I135(i-1,j+1)) + 0.5*abs(I135(i-1,j-1)-I135(i+1,j-3)) + 0.5*abs(I135(i+1,j+1)-I135(i+3,j-1)));
        H1=1/(1 + abs(I135(i+1,j+1)-I135(i+3,j+3)) + abs(I135(i+1,j+1)-I135(i-1,j-1)) + 0.5*abs(I135(i-1,j+1)-I135(i+1,j+3)) + 0.5*abs(I135(i+1,j-1)-I135(i+3,j+1)));
        H2=1/(1 + abs(I135(i-1,j-1)-I135(i-3,j-3)) + abs(I135(i-1,j-1)-I135(i+1,j+1)) + 0.5*abs(I135(i-1,j+1)-I135(i-3,j-1)) + 0.5*abs(I135(i+1,j-1)-I135(i-1,j-3)));
        I135(i,j)=( V1*I135(i-1,j+1)+V2*I135(i+1,j-1)+H1*I135(i+1,j+1)+H2*I135(i-1,j-1) )/( V1+V2+H1+H2 );
    end
end
% 0
for i=4:2:r-3
    for j=4:2:c-3
        V1=1/(1 + abs(I0(i-1,j+1)-I0(i-3,j+3)) + abs(I0(i-1,j+1)-I0(i+1,j-1)) + 0.5*abs(I0(i-1,j-1)-I0(i-3,j+1)) + 0.5*abs(I0(i+1,j+1)-I0(i-1,j+3)));
        V2=1/(1 + abs(I0(i+1,j-1)-I0(i+3,j-3)) + abs(I0(i+1,j-1)-I0(i-1,j+1)) + 0.5*abs(I0(i-1,j-1)-I0(i+1,j-3)) + 0.5*abs(I0(i+1,j+1)-I0(i+3,j-1)));
        H1=1/(1 + abs(I0(i+1,j+1)-I0(i+3,j+3)) + abs(I0(i+1,j+1)-I0(i-1,j-1)) + 0.5*abs(I0(i-1,j+1)-I0(i+1,j+3)) + 0.5*abs(I0(i+1,j-1)-I0(i+3,j+1)));
        H2=1/(1 + abs(I0(i-1,j-1)-I0(i-3,j-3)) + abs(I0(i-1,j-1)-I0(i+1,j+1)) + 0.5*abs(I0(i-1,j+1)-I0(i-3,j-1)) + 0.5*abs(I0(i+1,j-1)-I0(i-1,j-3)));
        I0(i,j)=( V1*I0(i-1,j+1)+V2*I0(i+1,j-1)+H1*I0(i+1,j+1)+H2*I0(i-1,j-1) )/( V1+V2+H1+H2 );
    end
end
%% interpolate horizontal and vertical pixels
% 90
for i=4:2:r-3
    for j=5:2:c-3
        V1=1/(1 + abs(I90(i-1,j)-I90(i-3,j)) + abs(I90(i-1,j)-I90(i+1,j)) + 0.5*abs(I90(i,j+1)-I90(i-2,j+1)) + 0.5*abs(I90(i,j-1)-I90(i-2,j-1)) );
        V2=1/(1 + abs(I90(i+1,j)-I90(i-1,j)) + abs(I90(i+1,j)-I90(i+3,j)) + 0.5*abs(I90(i,j-1)-I90(i+2,j-1)) + 0.5*abs(I90(i,j+1)-I90(i+2,j+1)) );
        H1=1/(1 + abs(I90(i,j+1)-I90(i,j+3)) + abs(I90(i,j+1)-I90(i,j-1)) + 0.5*abs(I90(i+1,j)-I90(i+1,j+2)) + 0.5*abs(I90(i-1,j)-I90(i-1,j+2)) );
        H2=1/(1 + abs(I90(i,j-1)-I90(i,j-3)) + abs(I90(i,j-1)-I90(i,j+1)) + 0.5*abs(I90(i-1,j)-I90(i-1,j-2)) + 0.5*abs(I90(i+1,j)-I90(i+1,j-2)) );
        I90(i,j)=( V1*I90(i-1,j)+V2*I90(i+1,j)+H1*I90(i,j+1)+H2*I90(i,j-1) )/( V1+V2+H1+H2 );
    end
end
for i=5:2:r-3
    for j=4:2:c-3
        V1=1/(1 + abs(I90(i-1,j)-I90(i-3,j)) + abs(I90(i-1,j)-I90(i+1,j)) + 0.5*abs(I90(i,j+1)-I90(i-2,j+1)) + 0.5*abs(I90(i,j-1)-I90(i-2,j-1)) );
        V2=1/(1 + abs(I90(i+1,j)-I90(i-1,j)) + abs(I90(i+1,j)-I90(i+3,j)) + 0.5*abs(I90(i,j-1)-I90(i+2,j-1)) + 0.5*abs(I90(i,j+1)-I90(i+2,j+1)) );
        H1=1/(1 + abs(I90(i,j+1)-I90(i,j+3)) + abs(I90(i,j+1)-I90(i,j-1)) + 0.5*abs(I90(i+1,j)-I90(i+1,j+2)) + 0.5*abs(I90(i-1,j)-I90(i-1,j+2)) );
        H2=1/(1 + abs(I90(i,j-1)-I90(i,j-3)) + abs(I90(i,j-1)-I90(i,j+1)) + 0.5*abs(I90(i-1,j)-I90(i-1,j-2)) + 0.5*abs(I90(i+1,j)-I90(i+1,j-2)) );
        I90(i,j)=( V1*I90(i-1,j)+V2*I90(i+1,j)+H1*I90(i,j+1)+H2*I90(i,j-1) )/( V1+V2+H1+H2 );
    end
end
% 45
for i=4:2:r-3
    for j=4:2:c-3
        V1=1/(1 + abs(I45(i-1,j)-I45(i-3,j)) + abs(I45(i-1,j)-I45(i+1,j)) + 0.5*abs(I45(i,j+1)-I45(i-2,j+1)) + 0.5*abs(I45(i,j-1)-I45(i-2,j-1)) );
        V2=1/(1 + abs(I45(i+1,j)-I45(i-1,j)) + abs(I45(i+1,j)-I45(i+3,j)) + 0.5*abs(I45(i,j-1)-I45(i+2,j-1)) + 0.5*abs(I45(i,j+1)-I45(i+2,j+1)) );
        H1=1/(1 + abs(I45(i,j+1)-I45(i,j+3)) + abs(I45(i,j+1)-I45(i,j-1)) + 0.5*abs(I45(i+1,j)-I45(i+1,j+2)) + 0.5*abs(I45(i-1,j)-I45(i-1,j+2)) );
        H2=1/(1 + abs(I45(i,j-1)-I45(i,j-3)) + abs(I45(i,j-1)-I45(i,j+1)) + 0.5*abs(I45(i-1,j)-I45(i-1,j-2)) + 0.5*abs(I45(i+1,j)-I45(i+1,j-2)) );
        I45(i,j)=( V1*I45(i-1,j)+V2*I45(i+1,j)+H1*I45(i,j+1)+H2*I45(i,j-1) )/( V1+V2+H1+H2 );
    end
end
for i=5:2:r-3
    for j=5:2:c-3
        V1=1/(1 + abs(I45(i-1,j)-I45(i-3,j)) + abs(I45(i-1,j)-I45(i+1,j)) + 0.5*abs(I45(i,j+1)-I45(i-2,j+1)) + 0.5*abs(I45(i,j-1)-I45(i-2,j-1)) );
        V2=1/(1 + abs(I45(i+1,j)-I45(i-1,j)) + abs(I45(i+1,j)-I45(i+3,j)) + 0.5*abs(I45(i,j-1)-I45(i+2,j-1)) + 0.5*abs(I45(i,j+1)-I45(i+2,j+1)) );
        H1=1/(1 + abs(I45(i,j+1)-I45(i,j+3)) + abs(I45(i,j+1)-I45(i,j-1)) + 0.5*abs(I45(i+1,j)-I45(i+1,j+2)) + 0.5*abs(I45(i-1,j)-I45(i-1,j+2)) );
        H2=1/(1 + abs(I45(i,j-1)-I45(i,j-3)) + abs(I45(i,j-1)-I45(i,j+1)) + 0.5*abs(I45(i-1,j)-I45(i-1,j-2)) + 0.5*abs(I45(i+1,j)-I45(i+1,j-2)) );
        I45(i,j)=( V1*I45(i-1,j)+V2*I45(i+1,j)+H1*I45(i,j+1)+H2*I45(i,j-1) )/( V1+V2+H1+H2 );
    end
end
% 135
for i=4:2:r-3
    for j=4:2:c-3
        V1=1/(1 + abs(I135(i-1,j)-I135(i-3,j)) + abs(I135(i-1,j)-I135(i+1,j)) + 0.5*abs(I135(i,j+1)-I135(i-2,j+1)) + 0.5*abs(I135(i,j-1)-I135(i-2,j-1)) );
        V2=1/(1 + abs(I135(i+1,j)-I135(i-1,j)) + abs(I135(i+1,j)-I135(i+3,j)) + 0.5*abs(I135(i,j-1)-I135(i+2,j-1)) + 0.5*abs(I135(i,j+1)-I135(i+2,j+1)) );
        H1=1/(1 + abs(I135(i,j+1)-I135(i,j+3)) + abs(I135(i,j+1)-I135(i,j-1)) + 0.5*abs(I135(i+1,j)-I135(i+1,j+2)) + 0.5*abs(I135(i-1,j)-I135(i-1,j+2)) );
        H2=1/(1 + abs(I135(i,j-1)-I135(i,j-3)) + abs(I135(i,j-1)-I135(i,j+1)) + 0.5*abs(I135(i-1,j)-I135(i-1,j-2)) + 0.5*abs(I135(i+1,j)-I135(i+1,j-2)) );
        I135(i,j)=( V1*I135(i-1,j)+V2*I135(i+1,j)+H1*I135(i,j+1)+H2*I135(i,j-1) )/( V1+V2+H1+H2 );
    end
end
for i=5:2:r-3
    for j=5:2:c-3
        V1=1/(1 + abs(I135(i-1,j)-I135(i-3,j)) + abs(I135(i-1,j)-I135(i+1,j)) + 0.5*abs(I135(i,j+1)-I135(i-2,j+1)) + 0.5*abs(I135(i,j-1)-I135(i-2,j-1)) );
        V2=1/(1 + abs(I135(i+1,j)-I135(i-1,j)) + abs(I135(i+1,j)-I135(i+3,j)) + 0.5*abs(I135(i,j-1)-I135(i+2,j-1)) + 0.5*abs(I135(i,j+1)-I135(i+2,j+1)) );
        H1=1/(1 + abs(I135(i,j+1)-I135(i,j+3)) + abs(I135(i,j+1)-I135(i,j-1)) + 0.5*abs(I135(i+1,j)-I135(i+1,j+2)) + 0.5*abs(I135(i-1,j)-I135(i-1,j+2)) );
        H2=1/(1 + abs(I135(i,j-1)-I135(i,j-3)) + abs(I135(i,j-1)-I135(i,j+1)) + 0.5*abs(I135(i-1,j)-I135(i-1,j-2)) + 0.5*abs(I135(i+1,j)-I135(i+1,j-2)) );
        I135(i,j)=( V1*I135(i-1,j)+V2*I135(i+1,j)+H1*I135(i,j+1)+H2*I135(i,j-1) )/( V1+V2+H1+H2 );
    end
end
% 0
for i=4:2:r-3
    for j=5:2:c-3
        V1=1/(1 + abs(I0(i-1,j)-I0(i-3,j)) + abs(I0(i-1,j)-I0(i+1,j)) + 0.5*abs(I0(i,j+1)-I0(i-2,j+1)) + 0.5*abs(I0(i,j-1)-I0(i-2,j-1)) );
        V2=1/(1 + abs(I0(i+1,j)-I0(i-1,j)) + abs(I0(i+1,j)-I0(i+3,j)) + 0.5*abs(I0(i,j-1)-I0(i+2,j-1)) + 0.5*abs(I0(i,j+1)-I0(i+2,j+1)) );
        H1=1/(1 + abs(I0(i,j+1)-I0(i,j+3)) + abs(I0(i,j+1)-I0(i,j-1)) + 0.5*abs(I0(i+1,j)-I0(i+1,j+2)) + 0.5*abs(I0(i-1,j)-I0(i-1,j+2)) );
        H2=1/(1 + abs(I0(i,j-1)-I0(i,j-3)) + abs(I0(i,j-1)-I0(i,j+1)) + 0.5*abs(I0(i-1,j)-I0(i-1,j-2)) + 0.5*abs(I0(i+1,j)-I0(i+1,j-2)) );
        I0(i,j)=( V1*I0(i-1,j)+V2*I0(i+1,j)+H1*I0(i,j+1)+H2*I0(i,j-1) )/( V1+V2+H1+H2 );
    end
end
for i=5:2:r-3
    for j=4:2:c-3
        V1=1/(1 + abs(I0(i-1,j)-I0(i-3,j)) + abs(I0(i-1,j)-I0(i+1,j)) + 0.5*abs(I0(i,j+1)-I0(i-2,j+1)) + 0.5*abs(I0(i,j-1)-I0(i-2,j-1)) );
        V2=1/(1 + abs(I0(i+1,j)-I0(i-1,j)) + abs(I0(i+1,j)-I0(i+3,j)) + 0.5*abs(I0(i,j-1)-I0(i+2,j-1)) + 0.5*abs(I0(i,j+1)-I0(i+2,j+1)) );
        H1=1/(1 + abs(I0(i,j+1)-I0(i,j+3)) + abs(I0(i,j+1)-I0(i,j-1)) + 0.5*abs(I0(i+1,j)-I0(i+1,j+2)) + 0.5*abs(I0(i-1,j)-I0(i-1,j+2)) );
        H2=1/(1 + abs(I0(i,j-1)-I0(i,j-3)) + abs(I0(i,j-1)-I0(i,j+1)) + 0.5*abs(I0(i-1,j)-I0(i-1,j-2)) + 0.5*abs(I0(i+1,j)-I0(i+1,j-2)) );
        I0(i,j)=( V1*I0(i-1,j)+V2*I0(i+1,j)+H1*I0(i,j+1)+H2*I0(i,j-1) )/( V1+V2+H1+H2 );
    end
end
%% final interpolated matrices
I0_d=I0(4:r-3,4:c-3);
I45_d=I45(4:r-3,4:c-3);
I90_d=I90(4:r-3,4:c-3);
I135_d=I135(4:r-3,4:c-3);

end