clear;
clc
close all;

addpath("../images")

tac1 = imreadDouble("table1.jpg");
tac2 = imreadDouble("table2.jpg");
tac3 = imreadDouble("table3.jpg");
% [I3,M3,B3] = Mosaic(tac1,tac2);
% [I4,M4,B4] = Mosaic(tac3,I3);
%  tac1 = tac1(1:10:end,1:10:end,:);
%  tac3 = tac3(1:10:end,1:10:end,:);
%  tac2 = tac2(1:10:end,1:10:end,:);

[I,M,B] = MosaicSeveralImages(tac1,tac2,tac3);

% images output
figure;
subplot(121);
imshow(I);
title("Output image");
subplot(122);
imshow(rescale(M));
title("Mask associated with the output image");
