% bilinear interpolation
function [I0_d,I45_d,I90_d,I135_d] = Bilinear(mosaic)

compact = cat(3,mosaic(1:2:end,1:2:end,1),mosaic(1:2:end,2:2:end,2),mosaic(2:2:end,1:2:end,3),mosaic(2:2:end,2:2:end,4));

fourD_image=imresize(compact,2,"bilinear");
I90_d=fourD_image(:,:,1);
I45_d=fourD_image(:,:,2);
I135_d=fourD_image(:,:,3);
I0_d=fourD_image(:,:,4);

end