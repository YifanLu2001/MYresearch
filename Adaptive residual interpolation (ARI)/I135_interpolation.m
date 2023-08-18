function I135_d=I135_interpolation(G, mosaic, mask, h, v, eps)

% sparse Laplacian filter
F = [ 0, 0,-1, 0, 0;
      0, 0, 0, 0, 0;
     -1, 0, 4, 0,-1;
      0, 0, 0, 0, 0;
      0, 0,-1, 0, 0];
% sparse Laplacian map of B and G
lap_I135 = imfilter(mosaic(:,:,3), F, 'replicate'); 
lap_G = imfilter(G.*mask(:,:,3), F, 'replicate'); 

% tentative estimate generation
tentativeI135 = GF_MLRI(G, mosaic(:,:,3), mask(:,:,3), lap_G, lap_I135, mask(:,:,3), h, v, eps);
%tentativeI135 = clip(tentativeI135,0,255); 

% residual calculation
residualI135 = mask(:,:,3).*(mosaic(:,:,3)-tentativeI135); 

% bicubic interpolation
residualI135=bicubic(residualI135);

% add tentative estimate
I135_d= residualI135 + tentativeI135; 
%I135_d= clip(I135_d,0,255);


end