function [Iout,Mout,Bout] = fusion3(I,M,B)
%FUSION3 takes an undefined amount of images, masks and bouding boxes and
%fuses them all together in a bigger image

%% ERROR CHECK

if ~iscell(I) || ~iscell(M) || ~iscell(B)
    error("ERROR, arguments have to be cell arrays");
end

[l,n] = size(B);
[Il,In] = size(I);
[Ml,Mn] = size(M);

if n~=In || n~=Mn || In~=Mn
    error("ERROR, arrays have to be the same size");
end

%% ================= FIRST STEP: GET FINAL IMAGE SIZE ================== %%

% determine the final image's bounding box

minY = Inf;
maxY = -Inf;
minX = Inf;
maxX = -Inf;

for loop=1:n
    Bloop = cell2mat(B(loop));
    minX = min(minX, Bloop(1,1));
    minY = min(minY, Bloop(1,2));
    maxX = max(maxX, Bloop(2,1));
    maxY = max(maxY, Bloop(2,2));
end

% transposition

offsetMat = [minX minY;minX minY];

fun = @(Bloop) Bloop-offsetMat;
Bout = cellfun(fun,B,'UniformOutput',false);

% Create empty image

height = ceil(maxY-minY);
length = ceil(maxX-minX);

Iout = zeros(height,length,3);
Mout = zeros(height,length);

%% ========================= DRAW IN THE IMAGE ========================= %%

for loop=1:n
    
    Img = cell2mat(I(loop));
    Bimg = cell2mat(Bout(loop));
    Mimg = cell2mat(M(loop));
    
    [h,w,c] = size(Img);
    
    offsetX = floor(Bimg(1,1));
    offsetY = floor(Bimg(1,2));
    
    Yaxis = (1:h) + offsetY;
    Xaxis = (1:w) + offsetX;
    
    Iout(Yaxis,Xaxis,:) = Iout(Yaxis,Xaxis,:)+ Img;
    Mout(Yaxis,Xaxis)   = Mout(Yaxis,Xaxis)  + Mimg;
    
end

%% ============================== CLEANUP ============================== %%

ind = find(Mout~=0);

for color=1:3
    tmp = Iout(:,:,color);
    tmp(ind) = tmp(ind)./Mout(ind);
    Iout(:,:,color) = tmp;
end

