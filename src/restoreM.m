clc;close all;clear;

addpath("../images")

%% ==== Begin ==== %%

HEIGHT=1000;
WIDTH=1000;
% target = rescale(double(imread("target.jpg")));
source  = rescale(double(imread("perspective_1.jpg")));
source2 = rescale(double(imread("perspective_2.jpg")));


target = zeros(HEIGHT,WIDTH);

[h,w,c] = size(source);
[h2,w2,c2] = size(target);
% target = zeros(h,w,c);


if c~=c2
    if c==1
        source = cat(3,source,source,source);
    else
        target = cat(3,target,target,target);
    end
end

% randx = randi([1,w],1,4);
% randy = randi([1,h],1,4);
% 
% target(randx(1),randy(1),:)=1;
% target(randx(2),randy(2),:)=1;
% target(randx(3),randy(3),:)=1;
% target(randx(4),randy(4),:)=1;

% imD = detector(target);
% imD=rescale(imD);
% 
% source = rgb2ycbcr(source);
% target = rgb2ycbcr(target);
%{
	How to select the quadrangle:
		Start by the top-left-hand corner (or the point of the quadrangle
		you want to link the top-left-hand-corner of the image to)
		then, select all the other points counter-clockwise
%}
% threshold=.95;
% [x,y,v] = find(imD(:,:,1) > threshold);
% [y x] = reorder(x,y);
figure;imshow(source);
title("Source image 1. Please select the 4 angles of the image.");
[x,y]=ginput(4); % makes the user able to select the 4 points on the quadrangle

figure;imshow(source2);
title("Source image 2. Please select the 4 angles of the image.");
[x2,y2]=ginput(4); % makes the user able to select the 4 points on the quadrangle
% 

% fprintf("Selected: (%d,%d)\n(%d,%d)\n(%d,%d)\n(%d,%d)\n",x(1),y(1),x(2),y(2),x(3),y(3),x(4),y(4));

x3 = [1;1;HEIGHT;HEIGHT];
y3=[1;WIDTH;WIDTH;1];
% x3 = [1;1;h2;h2];
% y3=[1;w2;w2;1];

source_quad1 = [ x  y];
source_quad2 = [x2 y2];
out_quad     = [x3 y3];
% source_quad1  =[
% 
%   110.6845   44.6996;...
%   735.8128   49.1970;...
%   719.3226  551.3984;...
%   107.6863  665.3307
%   ];
% 
% out_quad =[
% 
%    94.0000  144.0000;...
%     405.0000  289.0000;...
%   174.0000  356.0000;...
%  
%   19.0000  277.0000...
%    ];

% source_quad1 = floor(source_quad1);
% out_quad = floor(out_quad);
%% IMAGE RECONSTRUCTION
H1 = getHomography(out_quad,source_quad1); % gets the homographic transformation's matrix
										  % to get from the quadrangle in src, to the one
										  % in target
H2 = getHomography(out_quad,source_quad2); 

imgedit = restore(target,source,H1,source2,H2,source_quad1,source_quad2);
% % imgedit = ycbcr2rgb(imgedit);
figure;imshow(imgedit);
title("Output image");