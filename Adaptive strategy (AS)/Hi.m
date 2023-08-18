function Hi=Hi(raw_image,i,j)

sigma=0.5;

Hi=zeros(3);
for a=1:3
    for b=1:3
        x=logical(i+a-2);
        y=logical(j+b-2);
        delta=raw_image(x,y)-raw_image(i,j);
        Hi(a,b)=1/(sqrt(2*pi)*sigma)*exp(-delta^2/(2*sigma^2));  
    end
end


end