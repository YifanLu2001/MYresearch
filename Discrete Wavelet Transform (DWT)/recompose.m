function I_d=recompose(DS90,DS45,DS135,DS0,r,c)
I_d=zeros(r,c);
% 90
for i=1:2:r
    for j=1:2:c
        a=(i+1)/2;
        b=(j+1)/2;
        I_d(i,j)=DS90(a,b);
    end
end

% 45
for i=1:2:r
    for j=2:2:c
        a=(i+1)/2;
        b=j/2;
        I_d(i,j)=DS45(a,b);
    end
end

% 135
for i=2:2:r
    for j=1:2:c
        a=i/2;
        b=(j+1)/2;
        I_d(i,j)=DS135(a,b);
    end
end

% 0
for i=2:2:r
    for j=2:2:c
        a=i/2;
        b=j/2;
        I_d(i,j)=DS0(a,b);
    end
end

end