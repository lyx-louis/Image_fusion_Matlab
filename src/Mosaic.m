function [I3,M3,B3] = Mosaic(img1,img2)
%[I3,M3,B3] = Mosaique(img1,img2)
%   this function is used to combine 2 images, These two images need to
%   contain 4 common points, user need to select it, and function will 
%   base on the point selected to calcul the homography matrice, combine 2
%   images with help of homography matrice and return the resulat of
%   combined image, mask, and borne

figure,imshow(img1);
title("Source image 1. Please select the 4 angles of the image.");
[x1,y1]=ginput(4);
[h,w,c] = size(img1);
[h2,w2,c2] = size(img2);

hmax = max(h2,h);
wmax = max(w2,w);
% imgOut = zeros(hmax,wmax,c);

figure,imshow(img2);
title("Source image 1. Please select the 4 angles of the image.");
[x2,y2]=ginput(4);
% figure,imagesc(tac3);


tac2_quad  = [x2 y2];
tac1_quad  = [ x1  y1];
%% tester partie
% tac2_quad = [60 84;
%              232 70;
%              237 209;
%              53 213];
%          
% tac1_quad = [113 81;
%              296 73;
%              311 211;
%              119 230];
%% Calculer H
tic;
[I,M,B] = generateTriplet(img1);
H12 = getHomography(tac1_quad,tac2_quad); % matrice de tac1 -> tac2
[I2,M2,B2] = Transform_triplet(I,M,B,H12);
% figure,
% imagesc(I2);

close all;
[I,M,B] = generateTriplet(img2);
[I3,M3,B3] = fusion3(I,M,B,I2,M2,B2);
% figure;imshow(I3);
% figure;imshow(rescale(M3));

t = toc;
fprintf("Fusion took %d seconds\n",t);
end

