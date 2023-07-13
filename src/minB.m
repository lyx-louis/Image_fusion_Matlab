function B3 = minB(B1,B2)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

B1TL = [B1(1,1) B1(1,2)];
B2TL = [B2(1,1) B2(1,2)];

B1BR = [B1(2,1) B1(2,2)];
B2BR = [B2(2,1) B2(2,2)];

minX = min(B1TL(1),B2TL(1));
minY = min(B1TL(2),B2TL(2));
maxX = max(B1BR(1),B2BR(1));
maxY = max(B1BR(2),B2BR(2));

B3 = [minX minY;maxX maxY];
end

