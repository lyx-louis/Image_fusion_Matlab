clc;close all;clear;

addpath("../images")

%% ==== Begin ==== %%

target = rescale(double(imread("target.jpg")));
source  = rescale(double(imread("source.jpg")));



[h,w,c] = size(source);
[h2,w2,c2] = size(target);

if c~=c2
    if c==1
        source = cat(3,source,source,source);
    else
        target = cat(3,target,target,target);
    end
end

%{
	How to select the quadrangle:
		Start by the top-left-hand corner (or the point of the quadrangle
		you want to link the top-left-hand-corner of the image to)
		then, select all the other points counter-clockwise
%}

figure;imshow(target);
title("Source image 1. Please select the 4 angles of the image.");
[x,y]=ginput(4); % makes the user able to select the 4 points on the quadrangle

y2 = [1;1;h;h];
x2=[1;w;w;1];

source_quad  = [x2 y2];
target_quad  = [ x  y];

%% IMAGE RECONSTRUCTION
H = getHomography(target_quad,source_quad); % gets the homographic transformation's matrix
										  % to get from the quadrangle in src, to the one
										  % in target

imgedit = fusion(source,target,H);
% % imgedit = ycbcr2rgb(imgedit);
figure;imshow(imgedit);
title("Output image");