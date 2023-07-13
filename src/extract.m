clc;close all;clear;

addpath("../images")

%% ==== Begin ==== %%

HEIGHT=1000;
WIDTH=1000;
% target = rescale(double(imread("target.jpg")));
source  = imreadDouble("montagne.jpg");
%source2 = rescale(double(imread("perspective_2.jpg")));


target = zeros(HEIGHT,WIDTH);

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
figure;imshow(source);
title("Source image 1. Please select the 4 angles of the image.");
[x,y]=ginput(4); % makes the user able to select the 4 points on the quadrangle


y3 = [1;1;HEIGHT;HEIGHT];
x3 =[1;WIDTH;WIDTH;1];

source_quad1 = [ x  y];
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

imgedit = fusion(source,target,H1);

figure;imshow(imgedit);
title("Output image");