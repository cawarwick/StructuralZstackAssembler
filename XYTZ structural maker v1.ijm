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

OriginalFileName=getInfo("window.title");
print(OriginalFileName);
run("Stack Splitter", "number=2");  //For ThorImage, first half is Gcamp, second half is red channel
close(OriginalFileName);
runMacro("Garbage");
B="stk_0001_"+OriginalFileName;
C="stk_0002_"+OriginalFileName;
selectWindow(B);
run("Green");
selectWindow(C);
run("Red");
MergeChannels="c1=[" + B + "] c2=[" + C + "] create";
print(MergeChannels);
run("Merge Channels...", MergeChannels);
Stack.getDimensions(Wd,Ht,Ch,Sl,F);
setSlice((Sl));
run("Enhance Contrast...", "saturated=0.35");
setSlice((Sl+1));
run("Enhance Contrast...", "saturated=0.35");
renameraw=OriginalFileName+"_Raw";
rename(renameraw);
//make a copy of the raw and perform additional image processing
run("Duplicate...", "title=Smoothed duplicate");
run("Split Channels");
R="C2-Smoothed";
G="C1-Smoothed";
selectWindow(R);
GausBlurRed="x=" + GaussianXY +" y=" +GaussianXY+ " z="+ GaussianZ;
print(GausBlurRed);
run("Gaussian Blur 3D...", GausBlurRed);
//run top hat if enabled
if (Tophat==1) {
	TophatInput="radius=" + Tophatred +" stack";
	run("Top Hat...", TophatInput);
}
selectWindow(G);
GausBlurGreen="x=" + GaussianGreenXY +" y=" +GaussianGreenXY+ " z="+ GaussianGreenZ;
run("Gaussian Blur 3D...", GausBlurGreen);
if (Tophat==1) {
	TophatInput="radius=" + TophatGreen +" stack";
	run("Top Hat...", TophatInput);
}
MergeChannels="c1=[" + G + "] c2=[" + R + "] create";
run("Merge Channels...", MergeChannels);
renamesmoothed=OriginalFileName + "_Smoothed";
Stack.getDimensions(Wd,Ht,Ch,Sl,F);
setSlice((Sl));
run("Enhance Contrast...", "saturated=0.35");
setSlice((Sl+1));
run("Enhance Contrast...", "saturated=0.35");
rename(renamesmoothed);
