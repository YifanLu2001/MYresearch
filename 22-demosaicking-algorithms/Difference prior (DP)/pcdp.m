%% Demosaic a matrix, and get 4 full-resolution intensity matrices with
% 'difference prior' algorithm
%
%% Input:
% The mosaic matrix and mask
%
%% Output:
% 4 demosaiced matrices (4 intensity matrices) 
function [i0, i45, i90, i135] = pcdp(mosaic, mask)

%mask_90 = mask(:,:,1);
%mask_45 = mask(:,:,2);
%mask_135 = mask(:,:,3);
%mask_0 = mask(:,:,4);
%% eq(8)
weight_orth = 1/(1+2*sqrt(2));
weight_no_orth = sqrt(2)/(1+2*sqrt(2));

%% The convolution kernel for bilinear interpolation in eq(13)
conv_kernel = [1, 2, 1;
               2, 4, 2;
               1, 2, 1]/4;
%% eq(12)          
i0 = conv2(mosaic(:,:,4), conv_kernel, "same");
i45 = conv2(mosaic(:,:,2), conv_kernel, "same");
i90 = conv2(mosaic(:,:,1), conv_kernel, "same");
i135 = conv2(mosaic(:,:,3), conv_kernel, "same");

bi = cat(3,i90,i45,i135,i0);
array = [4,1,2,3,4,1,2];
demosaic = zeros(size(mosaic,1), size(mosaic,2),4);

for k = 1:4
    
    %% eq(14)
    i_diff_1 = mosaic(:,:,array(k+1)) - bi(:,:,array(k)).*mask(:,:,array(k+1));    
    i_diff_2 = mosaic(:,:,array(k+1)) - bi(:,:,array(k+2)).*mask(:,:,array(k+1));
    i_diff_3 = mosaic(:,:,array(k+1)) - bi(:,:,array(k+3)).*mask(:,:,array(k+1));

    i_1 = conv2(i_diff_1, conv_kernel, "same");
    i_2 = conv2(i_diff_2, conv_kernel, "same");
    i_3 = conv2(i_diff_3, conv_kernel, "same");
    
    %% eq(15)
    i_1 = bi(:,:,array(k)) + i_1;
    i_2 = bi(:,:,array(k+2)) + i_2;
    i_3 = bi(:,:,array(k+3)) + i_3;

    demosaic(:,:,array(k+1)) = weight_no_orth*(i_1 + i_2) + weight_orth*i_3;

end

i90 = demosaic(:,:,1);
i45 = demosaic(:,:,2);
i135 = demosaic(:,:,3);
i0 = demosaic(:,:,4);

end