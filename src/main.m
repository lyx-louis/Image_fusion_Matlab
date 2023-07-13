clear;clc;close all;

addpath("../images");
addpath("../src");

%% ========================= IMAGES SELECTION ========================== %%

img1 = imreadDouble("img1.jpg");
img2 = imreadDouble("img2.jpg");
[I1,M1,B1] = generateTriplet(img1);
[I2,M2,B2] = generateTriplet(img2);

% figure; imshow(img1); title("Please select 4 points.");
% [y x] = ginput(4);
% 
% imshow(img2); title("Please select 4 points again.");
% [y2 x2] = ginput(4);
% 
% close all;
% 
% target_quad = [y  x];
% source_quad = [y2 x2];
% H = getHomography(target_quad, source_quad);
