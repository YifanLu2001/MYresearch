%% get the edge of the droplet in scenario 4
% when the overall edge is not clear and it needs to be denoised

function [I1_edge]=ALL_3(I1)

%% get the binary image without black dots inside
I1=histeq(I1);
I1_gray=rgb2gray(I1);
t=graythresh(I1_gray);
I1_bw=im2bw(I1_gray,t);
I1_bw=imfill(I1_bw,'hole');

%% denoise the outside and get a clear edge 
[r1,c1]=size(I1_bw);
c1_middle=round(c1/2);
a=0;
for m=1:r1
    for n=c1_middle:c1
        if logical(I1_bw(m,n))==0
            a=n;
            break
        end
    end
    for n=a:c1
        I1_bw(m,n)=0;
    end
end
a=0;
for m=1:r1
    for n=c1_middle:-1:1
        if logical(I1_bw(m,n))==0
            a=n;
            break
        end
    end
    for n=a:-1:1
        I1_bw(m,n)=0;
    end
end

%% get a clear edge
I1_edge=edge(I1_bw,'canny');

end