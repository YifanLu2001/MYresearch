****************This is a 10-step instruction to run the GUI and get the surface tension coefficient.
****************The paper is attached. You can also find it at http://dxwl.bnu.edu.cn/CN/10.16854/j.cnki.1000-0712.220196

    1. Run the 'surfaceGUI.m' with MATLAB.

    2. Click the button "IMPORT" and choose an image from one of the 4 folders.

    3. Import the 4 constants on the right side. 
            You can skip some of those cause we set default values for each of them:
            air density: 1.205
            water density: 1000
            g: 9.80665
            steel rod's diameter: 6.04

    4. 'choose a scenario' popupmenu: Choose the scenario corresponding to the folder name of the imported image.
        'choose a way for the rod's detection' popupmenu: Choose the way you want to detect the steel rod's edges. If the edges are clear, then 'auto' is OK. If they're not, it is recommended to use 'manually'.

    5. Click the button 'CALCULATE'.

    6. Crop out the droplet section. Make sure the complete droplet is in the center of the cropping box. Do not crop out too much background (to reduce noise).
        Double click the cropped part to finish the cropping. 

    7. Crop out the steel rod section. You can crop out some background.
        Double click the cropped part to finish the cropping. 

    * The cropped parts will be shown in the windows 'droplet' and 'steel rod' respectively.

    8.  Interact with the 'droplet' image (ONLY IF YOU CHOOSE 'SCENARIO 3' IN THE POPUPMENU): Choose a fuzzy point on the inner part aligned closely to the edge of the droplet with the popped up crosshair cursor.

    9.  Interact with the 'steel rod' image (ONLY IF YOU CHOOSE 'MANUALLY' IN THE POPUPMENU): Select a point on the left and right edges respectively. This is used when the 2 sides of the rod is too hard for MATLAB to detect, so the 2 points chosen from the user are set to be the position of 2 sides.

    * The binary edge of the droplet will be shown in the 'droplet' window.
    * The binary edge of the steel rod (only if you use 'auto') will be shown in the 'droplet' window.
    * The value of the 'surface tension coefficient' will be shown in the box.

    10. Check out if the edge of the droplet is clear without backgound noises outside of it. 
          If not, or the program goes wrong for the bad cropping, restart the whole GUI. Make some adjustment and crop the images again until you get the clear edges in the end.
          Because the final result will only be credible when the edges are clear. (precisely detected)
          It's recommended to check out the cropped images in the paper for reference.
 



  
