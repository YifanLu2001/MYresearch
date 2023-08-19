%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'inter channel correlation' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = InterChannel(mosaic)
% 90 45
% 135 0
I=sum(mosaic,3);
I=padarray(I,[2 2]);
[r,c]=size(I);

I0_d=zeros(r,c);
I45_d=zeros(r,c);
I90_d=zeros(r,c);
I135_d=zeros(r,c);

%% get the full-resolution 0° channel
%0
for i=4:2:r-2
    for j=4:2:c-2
        I0_d(i,j)=I(i,j);
    end
end        
%90
for i=3:2:r-2
    for j=3:2:c-2
       I0_d(i,j)=1/8* (6*I(i,j) + 2*(I(i-1,j-1)+I(i-1,j+1)+I(i+1,j-1)+I(i+1,j+1)) + (-1.5)*(I(i-2,j)+I(i+2,j)+I(i,j-2)+I(i,j+2)));
    end
end
%135
for i=4:2:r-2
    for j=3:2:c-2
        I0_d(i,j)=1/8* (5*I(i,j) + 4*(I(i,j-1)+I(i,j+1)) + (-0.5)*(I(i-2,j)+I(i+2,j)) + (-2)*(I(i,j-2)+I(i,j+2)));
    end
end
%45
for i=3:2:r-2
    for j=4:2:c-2
        I0_d(i,j)=1/8* (5*I(i,j) + 4*(I(i-1,j)+I(i+1,j)) + (-0.5)*(I(i,j-2)+I(i,j+2)) + (-2)*(I(i-2,j)+I(i+2,j)));
    end
end
%% get the full-resolution 45° channel
%45
for i=3:2:r-2
    for j=4:2:c-2
        I45_d(i,j)=I(i,j);
    end
end 
%135
for i=4:2:r-2
    for j=3:2:c-2
       I45_d(i,j)=1/8* (6*I(i,j) + 2*(I(i-1,j-1)+I(i-1,j+1)+I(i+1,j-1)+I(i+1,j+1)) + (-1.5)*(I(i-2,j)+I(i+2,j)+I(i,j-2)+I(i,j+2)));
    end
end
%90
for i=3:2:r-2
    for j=3:2:c-2
        I45_d(i,j)=1/8* (5*I(i,j) + 4*(I(i,j-1)+I(i,j+1)) + (-0.5)*(I(i-2,j)+I(i+2,j)) + (-2)*(I(i,j-2)+I(i,j+2)));
    end
end
%0
for i=4:2:r-2
    for j=4:2:c-2
        I45_d(i,j)=1/8* (5*I(i,j) + 4*(I(i-1,j)+I(i+1,j)) + (-0.5)*(I(i,j-2)+I(i,j+2)) + (-2)*(I(i-2,j)+I(i+2,j)));
    end
end
%% get the full-resolution 90° channel
%90
for i=3:2:r-2
    for j=3:2:c-2
        I90_d(i,j)=I(i,j);
    end
end 
%0
for i=4:2:r-2
    for j=4:2:c-2
       I90_d(i,j)=1/8* (6*I(i,j) + 2*(I(i-1,j-1)+I(i-1,j+1)+I(i+1,j-1)+I(i+1,j+1)) + (-1.5)*(I(i-2,j)+I(i+2,j)+I(i,j-2)+I(i,j+2)));
    end
end
%45
for i=3:2:r-2
    for j=4:2:c-2
        I90_d(i,j)=1/8* (5*I(i,j) + 4*(I(i,j-1)+I(i,j+1)) + (-0.5)*(I(i-2,j)+I(i+2,j)) + (-2)*(I(i,j-2)+I(i,j+2)));
    end
end
%135
for i=4:2:r-2
    for j=3:2:c-2
        I90_d(i,j)=1/8* (5*I(i,j) + 4*(I(i-1,j)+I(i+1,j)) + (-0.5)*(I(i,j-2)+I(i,j+2)) + (-2)*(I(i-2,j)+I(i+2,j)));
    end
end
%% get the full-resolution 135° channel
%135
for i=4:2:r-2
    for j=3:2:c-2
        I135_d(i,j)=I(i,j);
    end
end 
%45
for i=3:2:r-2
    for j=4:2:c-2
       I135_d(i,j)=1/8* (6*I(i,j) + 2*(I(i-1,j-1)+I(i-1,j+1)+I(i+1,j-1)+I(i+1,j+1)) + (-1.5)*(I(i-2,j)+I(i+2,j)+I(i,j-2)+I(i,j+2)));
    end
end
%0
for i=4:2:r-2
    for j=4:2:c-2
        I135_d(i,j)=1/8* (5*I(i,j) + 4*(I(i,j-1)+I(i,j+1)) + (-0.5)*(I(i-2,j)+I(i+2,j)) + (-2)*(I(i,j-2)+I(i,j+2)));
    end
end
%90
for i=3:2:r-2
    for j=3:2:c-2
        I135_d(i,j)=1/8* (5*I(i,j) + 4*(I(i-1,j)+I(i+1,j)) + (-0.5)*(I(i,j-2)+I(i,j+2)) + (-2)*(I(i-2,j)+I(i+2,j)));
    end
end

%% final interpolated matrices
I0_d=I0_d(3:r-2,3:c-2);
I90_d=I90_d(3:r-2,3:c-2);
I45_d=I45_d(3:r-2,3:c-2);
I135_d=I135_d(3:r-2,3:c-2);
end