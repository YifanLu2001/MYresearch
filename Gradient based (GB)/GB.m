%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'gradient based' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = GB(mosaic)
% 90 45
% 135 0
thr=0.6;
[r,c,h]=size(mosaic);
r=r+6;
c=c+6;
I90=mosaic(:,:,1);
I45=mosaic(:,:,2);
I135=mosaic(:,:,3);
I0=mosaic(:,:,4);
I90=padarray(I90, [3 3]);
I45=padarray(I45, [3 3]);
I135=padarray(I135, [3 3]);
I0=padarray(I0, [3 3]);
%% interpolate the diagonal pixels
%% 90
% get D45135
D45=zeros(r,c);
D135=zeros(r,c);
D45135=zeros(r,c);
for i=5:2:r-3
    for j=5:2:c-3
        D45(i,j)=abs(I90(i-3,j-1)-I90(i-1,j-3)) + abs(I90(i-3,j+1)-I90(i-1,j-1)) + abs(I90(i-3,j+3)-I90(i-1,j+1))+...
                 abs(I90(i-1,j-1)-I90(i+1,j-3)) + abs(I90(i-1,j+1)-I90(i+1,j-1)) + abs(I90(i-1,j+3)-I90(i+1,j+1))+...
                 abs(I90(i+1,j-1)-I90(i+3,j-3)) + abs(I90(i+1,j+1)-I90(i+3,j-1)) + abs(I90(i+1,j+3)-I90(i+3,j+1));
        D135(i,j)=abs(I90(i-3,j-3)-I90(i-1,j-1)) + abs(I90(i-3,j-1)-I90(i-1,j+1)) + abs(I90(i-3,j+1)-I90(i-1,j+3))+...
                  abs(I90(i-1,j-3)-I90(i+1,j-1)) + abs(I90(i-1,j-1)-I90(i+1,j+1)) + abs(I90(i-1,j+1)-I90(i+1,j+3))+...
                  abs(I90(i+1,j-3)-I90(i+3,j-1)) + abs(I90(i+1,j-1)-I90(i+3,j+1)) + abs(I90(i+1,j+1)-I90(i+3,j+3)); 
        D45135(i,j)=D45(i,j)/D135(i,j);
    end
end

% decide how to interpolate by D45135
for i=5:2:r-3
    for j=5:2:c-3
        if D45135(i,j)>thr
            % 135° edge
            I90(i,j)=dia(I90(i-3,j-3),I90(i-1,j-1),I90(i+1,j+1),I90(i+3,j+3));
        elseif D45135(i,j)<thr
            % 45° edge
            I90(i,j)=dia(I90(i+3,j+3),I90(i+1,j+1),I90(i-1,j-1),I90(i-3,j-3));
        else
            % smooth
            I90(i,j)=(I90(i-1,j-1)+I90(i-1,j+1)+I90(i+1,j-1)+I90(i+1,j+1))/4;
        end
    end
end
%% 45
% get D45135
D45=zeros(r,c);
D135=zeros(r,c);
D45135=zeros(r,c);
for i=5:2:r-3
    for j=5:2:c-3
        D45(i,j)=abs(I45(i-3,j-1)-I45(i-1,j-3)) + abs(I45(i-3,j+1)-I45(i-1,j-1)) + abs(I45(i-3,j+3)-I45(i-1,j+1))+...
                 abs(I45(i-1,j-1)-I45(i+1,j-3)) + abs(I45(i-1,j+1)-I45(i+1,j-1)) + abs(I45(i-1,j+3)-I45(i+1,j+1))+...
                 abs(I45(i+1,j-1)-I45(i+3,j-3)) + abs(I45(i+1,j+1)-I45(i+3,j-1)) + abs(I45(i+1,j+3)-I45(i+3,j+1));
        D135(i,j)=abs(I45(i-3,j-3)-I45(i-1,j-1)) + abs(I45(i-3,j-1)-I45(i-1,j+1)) + abs(I45(i-3,j+1)-I45(i-1,j+3))+...
                  abs(I45(i-1,j-3)-I45(i+1,j-1)) + abs(I45(i-1,j-1)-I45(i+1,j+1)) + abs(I45(i-1,j+1)-I45(i+1,j+3))+...
                  abs(I45(i+1,j-3)-I45(i+3,j-1)) + abs(I45(i+1,j-1)-I45(i+3,j+1)) + abs(I45(i+1,j+1)-I45(i+3,j+3));
        D45135(i,j)=D45(i,j)/D135(i,j);
    end
end
% decide how to interpolate by D45135
for i=5:2:r-3
    for j=4:2:c-3
        if D45135(i,j)>thr
            % 135° edge
            I45(i,j)=dia(I45(i-3,j-3),I45(i-1,j-1),I45(i+1,j+1),I45(i+3,j+3));
        elseif D45135(i,j)<thr
            % 45° edge
            I45(i,j)=dia(I45(i+3,j+3),I45(i+1,j+1),I45(i-1,j-1),I45(i-3,j-3));
        else
            % smooth
            I45(i,j)=(I45(i-1,j-1)+I45(i-1,j+1)+I45(i+1,j-1)+I45(i+1,j+1))/4;
        end
    end
end
%% 135
% get D45135
D45=zeros(r,c);
D135=zeros(r,c);
D45135=zeros(r,c);
for i=4:2:r-3
    for j=5:2:c-3
        D45(i,j)=abs(I135(i-3,j-1)-I135(i-1,j-3)) + abs(I135(i-3,j+1)-I135(i-1,j-1)) + abs(I135(i-3,j+3)-I135(i-1,j+1))+...
                 abs(I135(i-1,j-1)-I135(i+1,j-3)) + abs(I135(i-1,j+1)-I135(i+1,j-1)) + abs(I135(i-1,j+3)-I135(i+1,j+1))+...
                 abs(I135(i+1,j-1)-I135(i+3,j-3)) + abs(I135(i+1,j+1)-I135(i+3,j-1)) + abs(I135(i+1,j+3)-I135(i+3,j+1));
        D135(i,j)=abs(I135(i-3,j-3)-I135(i-1,j-1)) + abs(I135(i-3,j-1)-I135(i-1,j+1)) + abs(I135(i-3,j+1)-I135(i-1,j+3))+...
                  abs(I135(i-1,j-3)-I135(i+1,j-1)) + abs(I135(i-1,j-1)-I135(i+1,j+1)) + abs(I135(i-1,j+1)-I135(i+1,j+3))+...
                  abs(I135(i+1,j-3)-I135(i+3,j-1)) + abs(I135(i+1,j-1)-I135(i+3,j+1)) + abs(I135(i+1,j+1)-I135(i+3,j+3));
        D45135(i,j)=D45(i,j)/D135(i,j);
    end
end
% decide how to interpolate by D45135
for i=4:2:r-3
    for j=5:2:c-3
        if D45135(i,j)>thr
            % 135° edge
            I135(i,j)=dia(I135(i-3,j-3),I135(i-1,j-1),I135(i+1,j+1),I135(i+3,j+3));
        elseif D45135(i,j)<thr
            % 45° edge
            I135(i,j)=dia(I135(i+3,j+3),I135(i+1,j+1),I135(i-1,j-1),I135(i-3,j-3));
        else
            % smooth
            I135(i,j)=(I135(i-1,j-1)+I135(i-1,j+1)+I135(i+1,j-1)+I135(i+1,j+1))/4;
        end
    end
end
%% 0
% get D45135
D45=zeros(r,c);
D135=zeros(r,c);
D45135=zeros(r,c);
for i=4:2:r-3
    for j=4:2:c-3
        D45(i,j)=abs(I0(i-3,j-1)-I0(i-1,j-3)) + abs(I0(i-3,j+1)-I0(i-1,j-1)) + abs(I0(i-3,j+3)-I0(i-1,j+1))+...
                 abs(I0(i-1,j-1)-I0(i+1,j-3)) + abs(I0(i-1,j+1)-I0(i+1,j-1)) + abs(I0(i-1,j+3)-I0(i+1,j+1))+...
                 abs(I0(i+1,j-1)-I0(i+3,j-3)) + abs(I0(i+1,j+1)-I0(i+3,j-1)) + abs(I0(i+1,j+3)-I0(i+3,j+1));
        D135(i,j)=abs(I0(i-3,j-3)-I0(i-1,j-1)) + abs(I0(i-3,j-1)-I0(i-1,j+1)) + abs(I0(i-3,j+1)-I0(i-1,j+3))+...
                  abs(I0(i-1,j-3)-I0(i+1,j-1)) + abs(I0(i-1,j-1)-I0(i+1,j+1)) + abs(I0(i-1,j+1)-I0(i+1,j+3))+...
                  abs(I0(i+1,j-3)-I0(i+3,j-1)) + abs(I0(i+1,j-1)-I0(i+3,j+1)) + abs(I0(i+1,j+1)-I0(i+3,j+3));
        D45135(i,j)=D45(i,j)/D135(i,j);
    end
end
% decide how to interpolate by D45135
for i=4:2:r-3
    for j=4:2:c-3
        if D45135(i,j)>thr
            % 135° edge
            I0(i,j)=dia(I0(i-3,j-3),I0(i-1,j-1),I0(i+1,j+1),I0(i+3,j+3));
        elseif D45135(i,j)<thr
            % 45° edge
            I0(i,j)=dia(I0(i+3,j+3),I0(i+1,j+1),I0(i-1,j-1),I0(i-3,j-3));
        else
            % smooth
            I0(i,j)=(I0(i-1,j-1)+I0(i-1,j+1)+I0(i+1,j-1)+I0(i+1,j+1))/4;
        end
    end
end

%% interpolate the horizontal and vertical pixels
%% 90
% get D090
D0=zeros(r,c);
D90=zeros(r,c);
D090=zeros(r,c);
for i=4:2:r-3
    for j=5:2:c-3
D0(i,j)= abs(I90(i-2,j-1)-I90(i-2,j-3)) + abs(I90(i-2,j+1)-I90(i-2,j-1)) + abs(I90(i-2,j+3)-I90(i-2,j+1))+...
         abs(I90(i,j-1)-I90(i,j-3))     + abs(I90(i,j+1)-I90(i,j-1))     + abs(I90(i,j+3)-I90(i,j+1))+...
         abs(I90(i+2,j-1)-I90(i+2,j-3)) + abs(I90(i+2,j+1)-I90(i+2,j-1)) + abs(I90(i+2,j+3)-I90(i+2,j+1));
D90(i,j)=abs(I90(i-1,j-2)-I90(i-3,j-2)) + abs(I90(i-1,j)-I90(i-3,j)) + abs(I90(i-1,j+2)-I90(i-3,j+2))+...
         abs(I90(i+1,j-2)-I90(i-1,j-2)) + abs(I90(i+1,j)-I90(i-1,j)) + abs(I90(i+1,j+2)-I90(i-1,j+2))+...
         abs(I90(i+3,j-2)-I90(i+1,j-2)) + abs(I90(i+3,j)-I90(i+1,j)) + abs(I90(i+3,j+2)-I90(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
for i=5:2:r-3
    for j=4:2:c-3
D0(i,j)= abs(I90(i-2,j-1)-I90(i-2,j-3)) + abs(I90(i-2,j+1)-I90(i-2,j-1)) + abs(I90(i-2,j+3)-I90(i-2,j+1))+...
         abs(I90(i,j-1)-I90(i,j-3))     + abs(I90(i,j+1)-I90(i,j-1))     + abs(I90(i,j+3)-I90(i,j+1))+...
         abs(I90(i+2,j-1)-I90(i+2,j-3)) + abs(I90(i+2,j+1)-I90(i+2,j-1)) + abs(I90(i+2,j+3)-I90(i+2,j+1));
D90(i,j)=abs(I90(i-1,j-2)-I90(i-3,j-2)) + abs(I90(i-1,j)-I90(i-3,j)) + abs(I90(i-1,j+2)-I90(i-3,j+2))+...
         abs(I90(i+1,j-2)-I90(i-1,j-2)) + abs(I90(i+1,j)-I90(i-1,j)) + abs(I90(i+1,j+2)-I90(i-1,j+2))+...
         abs(I90(i+3,j-2)-I90(i+1,j-2)) + abs(I90(i+3,j)-I90(i+1,j)) + abs(I90(i+3,j+2)-I90(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
% interpolate
for i=4:2:r-3
    for j=5:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I90(i,j)=dia(I90(i+3,j),I90(i+1,j),I90(i-1,j),I90(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I90(i,j)=dia(I90(i,j+3),I90(i,j+1),I90(i,j-1),I90(i,j-3));
        else
            % smooth
            I90(i,j)=(I90(i,j+1)+I90(i,j-1)+I90(i+1,j)+I90(i-1,j))/4;
        end
    end
end
for i=5:2:r-3
    for j=4:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I90(i,j)=dia(I90(i+3,j),I90(i+1,j),I90(i-1,j),I90(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I90(i,j)=dia(I90(i,j+3),I90(i,j+1),I90(i,j-1),I90(i,j-3));
        else
            % smooth
            I90(i,j)=(I90(i,j+1)+I90(i,j-1)+I90(i+1,j)+I90(i-1,j))/4;
        end
    end
end
%% 45
% get D090
D0=zeros(r,c);
D90=zeros(r,c);
D090=zeros(r,c);
for i=4:2:r-3
    for j=4:2:c-3
D0(i,j)= abs(I45(i-2,j-1)-I45(i-2,j-3)) + abs(I45(i-2,j+1)-I45(i-2,j-1)) + abs(I45(i-2,j+3)-I45(i-2,j+1))+...
         abs(I45(i,j-1)-I45(i,j-3))     + abs(I45(i,j+1)-I45(i,j-1))     + abs(I45(i,j+3)-I45(i,j+1))+...
         abs(I45(i+2,j-1)-I45(i+2,j-3)) + abs(I45(i+2,j+1)-I45(i+2,j-1)) + abs(I45(i+2,j+3)-I45(i+2,j+1));
D90(i,j)=abs(I45(i-1,j-2)-I45(i-3,j-2)) + abs(I45(i-1,j)-I45(i-3,j)) + abs(I45(i-1,j+2)-I45(i-3,j+2))+...
         abs(I45(i+1,j-2)-I45(i-1,j-2)) + abs(I45(i+1,j)-I45(i-1,j)) + abs(I45(i+1,j+2)-I45(i-1,j+2))+...
         abs(I45(i+3,j-2)-I45(i+1,j-2)) + abs(I45(i+3,j)-I45(i+1,j)) + abs(I45(i+3,j+2)-I45(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
for i=5:2:r-3
    for j=5:2:c-3
D0(i,j)= abs(I45(i-2,j-1)-I45(i-2,j-3)) + abs(I45(i-2,j+1)-I45(i-2,j-1)) + abs(I45(i-2,j+3)-I45(i-2,j+1))+...
         abs(I45(i,j-1)-I45(i,j-3))     + abs(I45(i,j+1)-I45(i,j-1))     + abs(I45(i,j+3)-I45(i,j+1))+...
         abs(I45(i+2,j-1)-I45(i+2,j-3)) + abs(I45(i+2,j+1)-I45(i+2,j-1)) + abs(I45(i+2,j+3)-I45(i+2,j+1));
D90(i,j)=abs(I45(i-1,j-2)-I45(i-3,j-2)) + abs(I45(i-1,j)-I45(i-3,j)) + abs(I45(i-1,j+2)-I45(i-3,j+2))+...
         abs(I45(i+1,j-2)-I45(i-1,j-2)) + abs(I45(i+1,j)-I45(i-1,j)) + abs(I45(i+1,j+2)-I45(i-1,j+2))+...
         abs(I45(i+3,j-2)-I45(i+1,j-2)) + abs(I45(i+3,j)-I45(i+1,j)) + abs(I45(i+3,j+2)-I45(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
% interpolate
for i=4:2:r-3
    for j=4:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I45(i,j)=dia(I45(i+3,j),I45(i+1,j),I45(i-1,j),I45(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I45(i,j)=dia(I45(i,j+3),I45(i,j+1),I45(i,j-1),I45(i,j-3));
        else
            % smooth
            I45(i,j)=(I45(i,j+1)+I45(i,j-1)+I45(i+1,j)+I45(i-1,j))/4;
        end
    end
end
for i=5:2:r-3
    for j=5:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I45(i,j)=dia(I45(i+3,j),I45(i+1,j),I45(i-1,j),I45(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I45(i,j)=dia(I45(i,j+3),I45(i,j+1),I45(i,j-1),I45(i,j-3));
        else
            % smooth
            I45(i,j)=(I45(i,j+1)+I45(i,j-1)+I45(i+1,j)+I45(i-1,j))/4;
        end
    end
end
%% 135
% get D090
D0=zeros(r,c);
D90=zeros(r,c);
D090=zeros(r,c);
for i=4:2:r-3
    for j=4:2:c-3
D0(i,j)= abs(I135(i-2,j-1)-I135(i-2,j-3)) + abs(I135(i-2,j+1)-I135(i-2,j-1)) + abs(I135(i-2,j+3)-I135(i-2,j+1))+...
         abs(I135(i,j-1)-I135(i,j-3))     + abs(I135(i,j+1)-I135(i,j-1))     + abs(I135(i,j+3)-I135(i,j+1))+...
         abs(I135(i+2,j-1)-I135(i+2,j-3)) + abs(I135(i+2,j+1)-I135(i+2,j-1)) + abs(I135(i+2,j+3)-I135(i+2,j+1));
D90(i,j)=abs(I135(i-1,j-2)-I135(i-3,j-2)) + abs(I135(i-1,j)-I135(i-3,j)) + abs(I135(i-1,j+2)-I135(i-3,j+2))+...
         abs(I135(i+1,j-2)-I135(i-1,j-2)) + abs(I135(i+1,j)-I135(i-1,j)) + abs(I135(i+1,j+2)-I135(i-1,j+2))+...
         abs(I135(i+3,j-2)-I135(i+1,j-2)) + abs(I135(i+3,j)-I135(i+1,j)) + abs(I135(i+3,j+2)-I135(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
for i=5:2:r-3
    for j=5:2:c-3
D0(i,j)= abs(I135(i-2,j-1)-I135(i-2,j-3)) + abs(I135(i-2,j+1)-I135(i-2,j-1)) + abs(I135(i-2,j+3)-I135(i-2,j+1))+...
         abs(I135(i,j-1)-I135(i,j-3))     + abs(I135(i,j+1)-I135(i,j-1))     + abs(I135(i,j+3)-I135(i,j+1))+...
         abs(I135(i+2,j-1)-I135(i+2,j-3)) + abs(I135(i+2,j+1)-I135(i+2,j-1)) + abs(I135(i+2,j+3)-I135(i+2,j+1));
D90(i,j)=abs(I135(i-1,j-2)-I135(i-3,j-2)) + abs(I135(i-1,j)-I135(i-3,j)) + abs(I135(i-1,j+2)-I135(i-3,j+2))+...
         abs(I135(i+1,j-2)-I135(i-1,j-2)) + abs(I135(i+1,j)-I135(i-1,j)) + abs(I135(i+1,j+2)-I135(i-1,j+2))+...
         abs(I135(i+3,j-2)-I135(i+1,j-2)) + abs(I135(i+3,j)-I135(i+1,j)) + abs(I135(i+3,j+2)-I135(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
% interpolate
for i=4:2:r-3
    for j=4:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I135(i,j)=dia(I135(i+3,j),I135(i+1,j),I135(i-1,j),I135(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I135(i,j)=dia(I135(i,j+3),I135(i,j+1),I135(i,j-1),I135(i,j-3));
        else
            % smooth
            I135(i,j)=(I135(i,j+1)+I135(i,j-1)+I135(i+1,j)+I135(i-1,j))/4;
        end
    end
end
for i=5:2:r-3
    for j=5:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I135(i,j)=dia(I135(i+3,j),I135(i+1,j),I135(i-1,j),I135(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I135(i,j)=dia(I135(i,j+3),I135(i,j+1),I135(i,j-1),I135(i,j-3));
        else
            % smooth
            I135(i,j)=(I135(i,j+1)+I135(i,j-1)+I135(i+1,j)+I135(i-1,j))/4;
        end
    end
end
%% 0
% get D090
D0=zeros(r,c);
D90=zeros(r,c);
D090=zeros(r,c);
for i=4:2:r-3
    for j=5:2:c-3
D0(i,j)= abs(I0(i-2,j-1)-I0(i-2,j-3)) + abs(I0(i-2,j+1)-I0(i-2,j-1)) + abs(I0(i-2,j+3)-I0(i-2,j+1))+...
         abs(I0(i,j-1)-I0(i,j-3))     + abs(I0(i,j+1)-I0(i,j-1))     + abs(I0(i,j+3)-I0(i,j+1))+...
         abs(I0(i+2,j-1)-I0(i+2,j-3)) + abs(I0(i+2,j+1)-I0(i+2,j-1)) + abs(I0(i+2,j+3)-I0(i+2,j+1));
D90(i,j)=abs(I0(i-1,j-2)-I0(i-3,j-2)) + abs(I0(i-1,j)-I0(i-3,j)) + abs(I0(i-1,j+2)-I0(i-3,j+2))+...
         abs(I0(i+1,j-2)-I0(i-1,j-2)) + abs(I0(i+1,j)-I0(i-1,j)) + abs(I0(i+1,j+2)-I0(i-1,j+2))+...
         abs(I0(i+3,j-2)-I0(i+1,j-2)) + abs(I0(i+3,j)-I0(i+1,j)) + abs(I0(i+3,j+2)-I0(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
for i=5:2:r-3
    for j=4:2:c-3
D0(i,j)= abs(I0(i-2,j-1)-I0(i-2,j-3)) + abs(I0(i-2,j+1)-I0(i-2,j-1)) + abs(I0(i-2,j+3)-I0(i-2,j+1))+...
         abs(I0(i,j-1)-I0(i,j-3))     + abs(I0(i,j+1)-I0(i,j-1))     + abs(I0(i,j+3)-I0(i,j+1))+...
         abs(I0(i+2,j-1)-I0(i+2,j-3)) + abs(I0(i+2,j+1)-I0(i+2,j-1)) + abs(I0(i+2,j+3)-I0(i+2,j+1));
D90(i,j)=abs(I0(i-1,j-2)-I0(i-3,j-2)) + abs(I0(i-1,j)-I0(i-3,j)) + abs(I0(i-1,j+2)-I0(i-3,j+2))+...
         abs(I0(i+1,j-2)-I0(i-1,j-2)) + abs(I0(i+1,j)-I0(i-1,j)) + abs(I0(i+1,j+2)-I0(i-1,j+2))+...
         abs(I0(i+3,j-2)-I0(i+1,j-2)) + abs(I0(i+3,j)-I0(i+1,j)) + abs(I0(i+3,j+2)-I0(i+1,j+2));
D090(i,j)=D0(i,j)/D90(i,j);
    end
end
% interpolate
for i=4:2:r-3
    for j=5:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I0(i,j)=dia(I0(i+3,j),I0(i+1,j),I0(i-1,j),I0(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I0(i,j)=dia(I0(i,j+3),I0(i,j+1),I0(i,j-1),I0(i,j-3));
        else
            % smooth
            I0(i,j)=(I0(i,j+1)+I0(i,j-1)+I0(i+1,j)+I0(i-1,j))/4;
        end
    end
end
for i=5:2:r-3
    for j=4:2:c-3
        if D090(i,j)>thr
            % 90° edge
            I0(i,j)=dia(I0(i+3,j),I0(i+1,j),I0(i-1,j),I0(i-3,j));
        elseif D45135(i,j)<thr
            % 0° edge
            I0(i,j)=dia(I0(i,j+3),I0(i,j+1),I0(i,j-1),I0(i,j-3));
        else
            % smooth
            I0(i,j)=(I0(i,j+1)+I0(i,j-1)+I0(i+1,j)+I0(i-1,j))/4;
        end
    end
end
%% final interpolated matrices
I0_d=I0(4:r-3,4:c-3);
I45_d=I45(4:r-3,4:c-3);
I90_d=I90(4:r-3,4:c-3);
I135_d=I135(4:r-3,4:c-3);
end