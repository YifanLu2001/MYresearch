%% process the image of the steel rod to get 2 parameters
%
% input: the edge image of the steel rod 'I2_edge';
%        the real width of the steel rod 'D' (mm);
% output:the number of pixels of the rod's width 'd';
%        the ratio of the real length over the number of pixels in an image 'ratio'
function [d,ratio]=contrast(I2_edge,D)
[r2,c2]=size(I2_edge);
A2=zeros(r2,1);
x=0;y=0;
for m=1:r2
   for n=1:c2
    if logical(I2_edge(m,n))
      x=n;
      break
    end
   end
   for q=1:c2
       if logical(I2_edge(m,c2+1-q))
           y=c2+1-q;
           break
       end
   end
   A2(m,1)=y-x;
end

%% get the two parameters
d=max(A2); 
ratio=D/d; 

end