clear;clc;close all;
addpath("../images")
%%
tac1 = imreadDouble("cahier1.jpg");
tac2 = imreadDouble("cahier2.jpg");
tac1 = tac1(1:10:end,1:10:end,:);
tac2 = tac2(1:10:end,1:10:end,:);
% figure,imagesc(tac1);
% title("Source image 1. Please select the 4 angles of the image.");
% [x1,y1]=ginput(4);
[h,w,c] = size(tac1);
[h2,w2,c2] = size(tac2);

hmax = max(h2,h);
wmax = max(w2,w);
imgOut = zeros(hmax,wmax,c);

% figure,imagesc(tac2);
% title("Source image 1. Please select the 4 angles of the image.");
% [x2,y2]=ginput(4);
%figure,imagesc(tac3);

% 
% tac2_quad  = [x2 y2];
% tac1_quad  = [ x1  y1];


tac2_quad = [60 84;
             232 70;
             237 209;
             53 213];
         
tac1_quad = [113 81;
             296 73;
             311 211;
             119 230];
%% Calculer H
[I,M,B] = generateTriplet(tac1);
H12 = getHomography(tac1_quad,tac2_quad);
[I2,M2,B2] = Transform_triplet(I,M,B,H12);
figure,
imagesc(I2);
%%
clc; close all;
[I,M,B] = generateTriplet(tac2);
[I3,M3,B3] = fusion3(I,M,B,I2,M2,B2);
figure;imshow(I3);
figure;imshow(rescale(M3));

% for y=1:h
%     for x=1:w
%         M_orig = [x;y];
%         M_fin = transform(M_orig,H); % M_orig * H = M_src;
%         y_fin = M_fin(1)/M_fin(3);
%         x_fin = M_fin(2)/M_fin(3);
%         x_fin=floor(x_fin);
%         y_fin=floor(y_fin);
%         imgOut(y_fin,x_fin,:) = tac1(y,x,:);
%     end
% end
