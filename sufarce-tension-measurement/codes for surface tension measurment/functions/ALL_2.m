%% get the edge of the droplet in scenario 3
% when the edge contains some blurry segments needed to be emphasized 
% by darkening/brightening their inner and outer neighborhoods

function [I1_edge]=ALL_2(I1,I)

%% choose the blurry point needed to be strengthened
I1_gray=rgb2gray(I1);
figure;
imshow(I1_gray);
title('please choose a blurry inner neighborhood point£º');
[x,y]=ginput(1);
gray=I1_gray(round(y),round(x));
[r1,c1]=size(I1_gray);
I_gray=rgb2gray(I);
[r,c]=size(I_gray);

%% darken/brighten their neighborhoods depending on if it's a bright/dark background
if I_gray(round(r/2),round(c/2))<100
    max=300;
else
    max=0;
end
for m=1:r1
    for n=1:c1
        if abs(I1_gray(m,n)-gray)<0.001
            I1_gray(m,n)=max;
        end
    end
end

%% get the edge
I1_edge=edge(I1_gray,'sobel');
figure;
imshow(I1_edge);
title('the edge of the droplet');

end