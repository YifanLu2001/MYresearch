function I0_d=I0_interpolation(G, mosaic, mask, h, v, eps)

% sparse Laplacian filter
F = [ 0, 0,-1, 0, 0;
      0, 0, 0, 0, 0;
     -1, 0, 4, 0,-1;
      0, 0, 0, 0, 0;
      0, 0,-1, 0, 0];
% sparse Laplacian map of B and G
lap_I0 = imfilter(mosaic(:,:,4), F, 'replicate'); 
lap_G = imfilter(G.*mask(:,:,4), F, 'replicate'); 

% tentative estimate generation
tentativeI0 = GF_MLRI(G, mosaic(:,:,4), mask(:,:,4), lap_G, lap_I0, mask(:,:,4), h, v, eps);
%tentativeI0 = clip(tentativeI0,0,255); 

% residual calculation
residualI0 = mask(:,:,4).*(mosaic(:,:,4)-tentativeI0); 

% bicubic interpolation
residualI0=bicubic(residualI0);

% add tentative estimate
I0_d= residualI0 + tentativeI0; 
%I0_d= clip(I0_d,0,255);


end