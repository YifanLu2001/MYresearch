%% get the left & right edges of the steel rod automatically

function [I2_edge]=auto(I2)
t2=graythresh(I2);
I2_bw=im2bw(I2,t2);
I2_edge=edge(I2_bw, 'canny');
figure;
imshow(I2_edge);
title('the edge of the steel rod');
end