% This function shows 10 pairs of polarization-parameter images.
% Each pair contains an origin image and a demosaicked image.
%
% Output parameters:
%  10 pairs of images in 5 figures
%
% Input parameters:
%  all polarization-parameter matrixes (both origin and demisaicked ones)
%
function DrawPairs(I0,I45,I90,I135,S0,S1,S2,DOLP,AOLP,I0_d,I45_d,I90_d,I135_d,S0_d,S1_d,S2_d,DOLP_d,AOLP_d)

%% prepare for origin
 z = ones(size(AOLP));
 hsv = cat(3,AOLP,DOLP,z);
 rgb = hsv2rgb(hsv);

 z = ones(size(AOLP_d));
 hsv_d = cat(3,AOLP_d,DOLP_d,z);
 rgb_d = hsv2rgb(hsv_d);
 
 %% draw pairs : 5 seperate images
     % intensity images
     figure('units','normalized','outerposition',[0 0 1 1]);set(gcf,'Color',[1,1,1]);
     subplot(2,4,1);imshow(I0(:,:));title(['I0 ']); subplot(2,4,2);imshow(I0_d(:,:));title(['I0-d ']);
     subplot(2,4,3);imshow(I45(:,:));title(['I45 ']); subplot(2,4,4);imshow(I45_d(:,:));title(['I45-d ']); 
     subplot(2,4,5);imshow(I90(:,:));title(['I90 ']); subplot(2,4,6);imshow(I90_d(:,:));title(['I90-d ']);
     subplot(2,4,7);imshow(I135(:,:));title(['I135 ']); subplot(2,4,8);imshow(I135_d(:,:));title(['I135-d ']);
     saveas(gcf, 'Results/intensity.png');

     % Stokes images
     figure('units','normalized','outerposition',[0 0 1 1]);set(gcf,'Color',[1,1,1]);
     subplot(1,6,1);imshow(im2double(S0(:,:)));title('S0'); subplot(1,6,2);imshow(im2double(S0_d(:,:)));title('S0-d');
     subplot(1,6,3);imshow(im2double(S1(:,:)));title('S1'); subplot(1,6,4);imshow(im2double(S1_d(:,:)));title('S1-d');
     subplot(1,6,5);imshow(im2double(S2(:,:)));title('S2'); subplot(1,6,6);imshow(im2double(S2_d(:,:)));title('S2-d');
     saveas(gcf, 'Results/stokes.png');
     
     % DOLP images
     figure(3);
     subplot(1,2,1);imshow((DOLP(:,:)),[0 1 ]);title('DOLP');colorbar('Ticks',[0,0.25,0.50,0.75,1],'TickLabels',{'0%','25%','50%','75%','100%'});
     subplot(1,2,2);imshow((DOLP_d(:,:)),[0 1 ]);title('DOLP-d');colorbar('Ticks',[0,0.25,0.50,0.75,1],'TickLabels',{'0%','25%','50%','75%','100%'});
     saveas(gcf, 'Results/DOLP.png');
    
     % AOLP images
     figure(4);
     ax2 = subplot(1,2,1);imshow(im2double(AOLP(:,:)));colormap(ax2,'jet');colorbar('Ticks',[0,0.25,0.50,0.75,1],'TickLabels',{'0°','45°','90°','135°','180°'});title('AOLP');
     ax2_d = subplot(1,2,2);imshow(im2double(AOLP_d(:,:)));colormap(ax2_d,'jet');colorbar('Ticks',[0,0.25,0.50,0.75,1],'TickLabels',{'0°','45°','90°','135°','180°'});title('AOLP-d');
     saveas(gcf, 'Results/AOLP.png');
      
     % AOLP DOLP HSV image
     figure(5);
     subplot(1,2,1);imshow(rgb);title(['AOP-DOP']);
     subplot(1,2,2);imshow(rgb_d);title(['AOP-DOP-d']);
     saveas(gcf, 'Results/AOLP-DOLP.png');

end