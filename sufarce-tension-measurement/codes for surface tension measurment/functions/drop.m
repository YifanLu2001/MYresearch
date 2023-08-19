%% get de & ds from the clear edge of a droplet

function [de,ds]=drop(I1_edge)
[r1,c1]=size(I1_edge);
A1=zeros(r1,1);
x=0;y=0;
for m=1:r1
   for n=1:c1
    if logical(I1_edge(m,n))
      x=n;
      break
    end
    x=0;
   end
   for q=1:c1
       if logical(I1_edge(m,c1+1-q))
           y=c1+1-q;
           break
       end
       y=0;
   end
   A1(m,1)=y-x;
end
for p=1:r1   
    if logical(A1(r1-p+1,1))
        z=r1-p+1;
        break
    end
end
de=max(A1); 
ds=A1(z-de+1,1); 
end