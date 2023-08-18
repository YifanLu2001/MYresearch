% This function calculate the psnr between images X and Y (X or Y is not
% AOLP).
%
% Output parameters:
%  psnr: psnr between images X and Y
%
% Input parameters:
%  X: image whose dimensions should be same to that of Y
%  Y: image whose dimensions should be same to that of X
%  peak (optional): peak value (default: 255)
%  b (optional): border size to be neglected for evaluation
%
function psnr = Impsnr(X, Y, peak, b)

% decide the parameters 
if( nargin < 3 ) % nargin is the number of input parameters
 peak = 255;
end

if( nargin < 4 )
 b = 0;
end

if( b > 0 )
 X = X(b:size(X,1)-b, b:size(X,2)-b,:); 
 Y = Y(b:size(Y,1)-b, b:size(Y,2)-b,:);
end

% calculate psnr between X and Y
dif = (X - Y);
dif = dif .* dif;
for i=1:size(dif, 3)
 d = dif(:,:,i);
 mse = sum( d(:) ) / numel(d)+1e-32;
 psnr(i) = 10 * log10( peak * peak / mse );
end

end