function I90_d=I90_interpolation(G, mosaic, mask, h, v, eps)

% sparse Laplacian filter
F = [ 0, 0,-1, 0, 0;
      0, 0, 0, 0, 0;
     -1, 0, 4, 0,-1;
      0, 0, 0, 0, 0;
      0, 0,-1, 0, 0];
% sparse Laplacian map of B and G
lap_I90 = imfilter(mosaic(:,:,1), F, 'replicate'); 
lap_G = imfilter(G.*mask(:,:,1), F, 'replicate'); 

% tentative estimate generation
tentativeI90 = GF_MLRI(G, mosaic(:,:,1), mask(:,:,1), lap_G, lap_I90, mask(:,:,1), h, v, eps);
%tentativeI90 = clip(tentativeI90,0,255); 

% residual calculation
residualI90 = mask(:,:,1).*(mosaic(:,:,1)-tentativeI90);

% bicubic interpolation
residualI90=bicubic(residualI90);

% add tentative estimate
I90_d= residualI90 + tentativeI90;
%I90_d= clip(I90_d,0,255);

end