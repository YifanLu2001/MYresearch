% This function normalizes a 2D matrix I0 to a 0-1 2D matrix I.
%
function I=normalize2D(I0)

I0=double(I0);
MAX=max(max(I0));
MIN=min(min(I0));
delta=MAX-MIN;

[r,c]=size(I0);
I=zeros(r,c);
for i=1:r
    for j=1:c
     I(i,j)=((I0(i,j)-MIN)./delta);
    end
end

end