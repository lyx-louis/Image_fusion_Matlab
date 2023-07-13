clear;clc;close all;

addpath("../images");

%% ======= BEGIN ======= %%

img1 = imreadDouble("keernsHead.jpg");
img2 = imreadDouble("montagneExt.jpg");

[I1,M1,B1] = generateTriplet(img1);
[I2,M2,B2] = generateTriplet(img2);

offsets = [702 32];
B2 = B2 + [offsets;offsets];

[I3,M3,B3] = fusion3(I1,M1,B1,I2,M2,B2);