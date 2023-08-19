%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'intensity correlation among polarization channels' algorithm
%
%% Input:
% The mosaic matrix
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [I0_d,I45_d,I90_d,I135_d] = IC(mosaic)
%% D45 D135
I=sum(mosaic,3);
[r,c]=size(I);
a=[-1 0 0 0 0;
    0 0 0 0 0;
    0 0 2 0 0;
    0 0 0 0 0;
    0 0 0 0 -1];
b=[ 0 0 0 0 -1;
    0 0 0 0 0;
    0 0 2 0 0;
    0 0 0 0 0;
    -1 0 0 0 0];
A=conv2(I,a,"same");
B=conv2(I,b,"same");

I1=padarray(I, [3 3]);
IA=zeros(r,c);
for i=4:(r+3)
    for j=4:(c+3)
IA(i-3,j-3)=abs(I1(i+3,j-3)-I1(i+1,j-1)) + abs(I1(i+1,j-1)-I1(i-1,j+1)) +abs(I1(i-1,j+1)-I1(i-3,j+1));
    end
end
D45=IA+A;

IB=zeros(r,c);
for i=4:(r+3)
    for j=4:(c+3)
IA(i-3,j-3)=abs(I1(i+3,j+3)-I1(i+1,j+1)) + abs(I1(i+1,j+1)-I1(i-1,j-1)) +abs(I1(i-1,j-1)-I1(i-3,j-3));
    end
end
D135=IB+B;

D=D45-D135;
%% interpolate the diagonal pixels
% 90
I90=mosaic(:,:,1);
I90=padarray(I90, [4 4]);
for i=6:2:r+4
  for  j=6:2:c+4
      if D(i-4,j-4)>0
          % 135° edge
      I90(i,j)=dia(I90(i+3,j+3),I90(i+1,j+1),I90(i-1,j-1),I90(i-3,j-3));
      elseif D(i-4,j-4)<0
          % 45° edge
          I90(i,j)=dia(I90(i-3,j+3),I90(i-1,j+1),I90(i+1,j-1),I90(i+3,j-3));
      else
          % smooth
          I90(i,j)=(I90(i-1,j-1)+I90(i-1,j+1)+I90(i+1,j-1)+I90(i+1,j+1))/4;
      end
  end
end
% 45
I45=mosaic(:,:,2);
I45=padarray(I45, [4 4]);
for i=6:2:r+4
  for  j=5:2:c+4
      if D(i-4,j-4)>0
          % 135° edge
      I45(i,j)=dia(I45(i+3,j+3),I45(i+1,j+1),I45(i-1,j-1),I45(i-3,j-3));
      elseif D(i-4,j-4)<0
          % 45° edge
          I45(i,j)=dia(I45(i-3,j+3),I45(i-1,j+1),I45(i+1,j-1),I45(i+3,j-3));
      else
          % smooth
          I45(i,j)=(I45(i-1,j-1)+I45(i-1,j+1)+I45(i+1,j-1)+I45(i+1,j+1))/4;
      end
  end
end
% 135
I135=mosaic(:,:,3);
I135=padarray(I135, [4 4]);
for i=5:2:r+4
  for  j=6:2:c+4
      if D(i-4,j-4)>0
          % 135° edge
      I135(i,j)=dia(I135(i+3,j+3),I135(i+1,j+1),I135(i-1,j-1),I135(i-3,j-3));
      elseif D(i-4,j-4)<0
          % 45° edge
          I135(i,j)=dia(I135(i-3,j+3),I135(i-1,j+1),I135(i+1,j-1),I135(i+3,j-3));
      else
          % smooth
          I135(i,j)=(I135(i-1,j-1)+I135(i-1,j+1)+I135(i+1,j-1)+I135(i+1,j+1))/4;
      end
  end
end
% 0
I0=mosaic(:,:,4);
I0=padarray(I0, [4 4]);
for i=5:2:r+4
  for  j=5:2:c+4
      if D(i-4,j-4)>0
          % 135° edge
      I0(i,j)=dia(I0(i+3,j+3),I0(i+1,j+1),I0(i-1,j-1),I0(i-3,j-3));
      elseif D(i-4,j-4)<0
          % 45° edge
          I0(i,j)=dia(I0(i-3,j+3),I0(i-1,j+1),I0(i+1,j-1),I0(i+3,j-3));
      else
          % smooth
          I0(i,j)=(I0(i-1,j-1)+I0(i-1,j+1)+I0(i+1,j-1)+I0(i+1,j+1))/4;
      end
  end
end

%% interpolate the horizontal pixels
h1=[-0.5 0.5 -0.5;
      0.5 -1  0.5;
      0   0.5  0];
h2=[ 0   0.5     0;
      0.5  -1    0.5;
     -0.5  0.5  -0.5];
v1=h1';
v2=h2';

X=conv2(I,h1,"same");
Y=conv2(I,h2,"same");
Z=conv2(I,v1,"same");
Q=conv2(I,v2,"same");
Ih=abs(X-Y);
Iv=abs(Z-Q);
k=[ 1 1 1;
    1 1 1;
    1 1 1];
H=conv2(Ih,k,"same");
V=conv2(Iv,k,"same");

%% 90
for i=5:2:r+4
  for  j=6:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I90(i,j)=dia(I90(i,j+3),I90(i,j+1),I90(i,j-1),I90(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I90(i,j)=dia(I90(i+3,j),I90(i+1,j),I90(i-1,j),I90(i-3,j));
      else
          % smooth
          I90(i,j)=(I90(i,j-1)+I90(i,j+1)+I90(i-1,j)+I90(i+1,j))/4;
      end   
  end
end
for i=6:2:r+4
  for  j=5:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I90(i,j)=dia(I90(i,j+3),I90(i,j+1),I90(i,j-1),I90(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I90(i,j)=dia(I90(i+3,j),I90(i+1,j),I90(i-1,j),I90(i-3,j));
      else
          % smooth
          I90(i,j)=(I90(i,j-1)+I90(i,j+1)+I90(i-1,j)+I90(i+1,j))/4;
      end
  end
end
%% 45
for i=5:2:r+4
  for  j=5:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I45(i,j)=dia(I45(i,j+3),I45(i,j+1),I45(i,j-1),I45(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I45(i,j)=dia(I45(i+3,j),I45(i+1,j),I45(i-1,j),I45(i-3,j));
      else
          % smooth
          I45(i,j)=(I45(i,j-1)+I45(i,j+1)+I45(i-1,j)+I45(i+1,j))/4;
      end
  end
end
for i=6:2:r+4
  for  j=6:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I45(i,j)=dia(I45(i,j+3),I45(i,j+1),I45(i,j-1),I45(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I45(i,j)=dia(I45(i+3,j),I45(i+1,j),I45(i-1,j),I45(i-3,j));
      else
          % smooth
          I45(i,j)=(I45(i,j-1)+I45(i,j+1)+I45(i-1,j)+I45(i+1,j))/4;
      end
  end
end
%% 135
for i=5:2:r+4
  for  j=5:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I135(i,j)=dia(I135(i,j+3),I135(i,j+1),I135(i,j-1),I135(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I135(i,j)=dia(I135(i+3,j),I135(i+1,j),I135(i-1,j),I135(i-3,j));
      else
          % smooth
          I135(i,j)=(I135(i,j-1)+I135(i,j+1)+I135(i-1,j)+I135(i+1,j))/4;
      end
  end
end
for i=6:2:r+4
  for  j=6:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I135(i,j)=dia(I135(i,j+3),I135(i,j+1),I135(i,j-1),I135(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I135(i,j)=dia(I135(i+3,j),I135(i+1,j),I135(i-1,j),I135(i-3,j));
      else
          % smooth
          I135(i,j)=(I135(i,j-1)+I135(i,j+1)+I135(i-1,j)+I135(i+1,j))/4;
      end
  end
end
%% 0
for i=5:2:r+4
  for  j=6:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I0(i,j)=dia(I0(i,j+3),I0(i,j+1),I0(i,j-1),I0(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I0(i,j)=dia(I0(i+3,j),I0(i+1,j),I0(i-1,j),I0(i-3,j));
      else
          % smooth
          I0(i,j)=(I0(i,j-1)+I0(i,j+1)+I0(i-1,j)+I0(i+1,j))/4;
      end
  end
end
for i=6:2:r+4
  for  j=5:2:c+4
      if H(i-4,j-4)>V(i-4,j-4)
          % 0° edge
      I0(i,j)=dia(I0(i,j+3),I0(i,j+1),I0(i,j-1),I0(i,j-3));
      elseif H(i-4,j-4)<V(i-4,j-4)
          % 90° edge
          I0(i,j)=dia(I0(i+3,j),I0(i+1,j),I0(i-1,j),I0(i-3,j));
      else
          % smooth
          I0(i,j)=(I0(i,j-1)+I0(i,j+1)+I0(i-1,j)+I0(i+1,j))/4;
      end
  end
end
I0_d=I0(5:r+4,5:c+4);
I45_d=I45(5:r+4,5:c+4);
I90_d=I90(5:r+4,5:c+4);
I135_d=I135(5:r+4,5:c+4);

end