function I45_d=I45_interpolation(G, mosaic, mask, h, v, eps)

% sparse Laplacian filter
F = [ 0, 0,-1, 0, 0;
      0, 0, 0, 0, 0;
     -1, 0, 4, 0,-1;
      0, 0, 0, 0, 0;
      0, 0,-1, 0, 0];
% sparse Laplacian map of B and G
lap_I45 = imfilter(mosaic(:,:,2), F, 'replicate'); 
lap_G = imfilter(G.*mask(:,:,2), F, 'replicate'); 

% tentative estimate generation
tentativeI45 = GF_MLRI(G, mosaic(:,:,2), mask(:,:,2), lap_G, lap_I45, mask(:,:,2), h, v, eps);
%tentativeI45 = clip(tentativeI45,0,255); 

% residual calculation
residualI45 = mask(:,:,2).*(mosaic(:,:,2)-tentativeI45);

% bicubic interpolation
residualI45=bicubic(residualI45);

% add tentative estimate
I45_d= residualI45 + tentativeI45; 
%I45_d= clip(I45_d,0,255);

end