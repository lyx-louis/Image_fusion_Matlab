function offset = generateOffsets(B)
%GENERATEOFFSETS Summary of this function goes here
%   Detailed explanation goes here

offX = 0;
offY = 0;

if B(1,1) < 1
    offX = abs(B(1,1));
end

if B(1,1) > 1
    offX = -abs(B(1,1));
end

if B(1,2) > 1
    offY = -abs(B(1,2));
end
if B(1,2) < 1
    offY = abs(B(1,2));
end

offset = [offX;offY];

end

