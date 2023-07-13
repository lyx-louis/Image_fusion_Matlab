function [I,M,B] = generateTriplet(img)
%GENERATETRIPLET generates the bit mask and the bounding box of a given
%image

[h,w,c] = size(img);

I=img;
B=[1 1;w h];
M=ones(h,w);



end

