This macro is for the quick assembly of and XYZ image from ThorImageLS. The images consist of a bunch of TIFFs in a folder.

<img width="450" height="406" alt="image" src="https://github.com/user-attachments/assets/c956b21e-55a9-4e72-bbb1-968c3e787fea" />

Drag the parent folder which contains all these images onto ImageJ to open them

Some basic assumptions about this is that you image has 2 channels and no time points. The smoothing/filtering is specific to the gcamp/nuc-mcherry expression and assumes images are ~1µm/pixel resolution.

Once you file is open in ImageJ, it is a stack of images rather than a hyperstack. Run this macro and it will create a raw and a smoothed version which is used as a structural reference image for the functional gcamp imaging.

The image processing just consists of a 3d gaussian blur. The red is a bit more since the structures are bigger. Then followed by a tophat filter. Each channel gets a slightly different filter to enhance the relevant structures.

Most of these variables can be left alone assuming you're at the expected resolution and SNR.

//Smoothing variables
//Most of variables are only relevant to images in the ~1um/pixel range
//i.e. if you do a 512x256 image at ~1.6x zoom with the 16x. e.g. the 15pixels should be ~15 microns
GaussianXY=1; //anywhere from 0.5 to 1 is okish depending on SNR
GaussianZ=2; //1 to 2 is fine. Maybe try 1 to 1.5 if SNR is high.
Tophatred=7.5; //the nuclei are smaller, so a smaller tophat is required, 7.5 to 10ish. Much below 5 starts to affect signal
GaussianGreenXY=0.5; //you want less smoothing on the green channel generaly because you have finer structures
GaussianGreenZ=0.5; //you want less smoothing on the green channel generaly because you have finer structures
TophatGreen=15;//15-20 seem sfine for most 512x256 resolution images. Aim for 1.5-2x the size of a cell body
Tophat=1;//If you don't want to do a tophat, put this to 0. This basically just normalizes background brightness
