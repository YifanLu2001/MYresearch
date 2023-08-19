
******************These are the MATLAB codes of 22 classic demosaicing algorithms discussed in my survey:
******************'Research on DoFP Demosaicking Algorithms', which is attached.       



(1) How to run the algorithms? If you want to:

           1. View the demosaicked images of one algorithm:
            Download the algorithm's folder and the 'general_functions' folder. PUT THE LATTER INTO THE FORMER.
            Run code 'Run_XXX.m' with MATLAB. Demosaicked images will pop up and also be stored in the newly-created folder 'Results'.                   

           2. Get a PSNR Excel by 30 scenarios of one algorithm:
            Download the algorithm's folder, the 'general_functions' folder and the 'RGB_images' folder. PUT THE LAST 2 INTO THE FIRST FOLDER.
            Run code 'GET_EXCEL.m' with MATLAB. The PSNR Excel 'results' will be stored in the current folder.                                          
            Excel: Each row represents a scenario. Each column represents a polarization parameter in sequence: I0, I45, I90, I135, S0, S1, S2, DOLP, AOLP and t.



(2) Then each folder (one algorithm) will consist of  5 parts:

            1. Run_XXX.m
            *This code shows the algorithm's demosaicing images of a polarized scenario.
            Input:   I0, I45, I90, I135 (4 RGB ground-truth images of the 'woodwall' scenario)
            Output:  10 pairs of images. Each pair consists of a polarization parameter's original image and the demosaiced one.
            An Excel, recording those 10 pairs of images' PSNRs.

            2. GET_EXCEL.m & run_database.m
            *GET_EXCEL.m: This code can output the PSNRs of more than one scenario's polarization parameters at one time. It uses the function 'run_database.m' in 
                         the process.
            Input:   120 RGB images (30 scenarios' I0, I45, I90 and I135 ground-truth images, named in a specific order. )      
            Output:  An Excel, recording those 30 scenarios' PSNRs, each scenario contains 10 pairs of polarization parameters.

            3. 'RGB_images' folder
            *The 120 RGB images mentioned above. Don't change their names!

            4. The 'general_functions' folder
            *Functions and images that will be used in every algorithm.
            The 'woodwall' scenario's 4 RGB images mentioned above used in every 'Run_XXX.m' function.
            normalize2D.m:      normalize a 2D matrix.
            calculateStokes.m:  get 5 polarization parameters (S0, S1, S2, AOLP, DOLP) from the scenario's I0, I45, I90 and I135.
            Impsnr.m:           get the PSNR of an image pair (except for AOLP images)
            Impsnr_AOLP.m:      get the PSNR of an AOLP image pair
            DrawPairs.m:        show 10 polarization parameters' image pairs in 5 figures, each pair includes the original image and the demosaiced one.

            5. Others
            *The demosaicing functions.
            It will be explained in the 'readme.txt' if the codes are modified from other provided codes.



(3) NOTE:  
 
            The code 'Run_XXX.m' and the codes in 'general_functions' are modified from the downloaded codes: 
                        http://www.ok.sc.e.titech.ac.jp/res/PolarDem/index.html
                        by M. Morimatsu, Y. Monno, M. Tanaka and M. Okutomi in 2020.

            The download website of the 4 'woodwall' images:
                        https://repository.kaust.edu.sa/handle/10754/631914
                        by S. Qiu, Q. Fu, C. Wang, W. Heidrich in 2019.

            The download website of all the 'RGB_images': 
                        http://www.ok.sc.e.titech.ac.jp/res/PolarDem/index.html 
                        by M. Morimatsu, Y. Monno, M. Tanaka and M. Okutomi in 2020.



