function img = imreadDouble(imgName)
%IMREADDOUBLE reads an image, converts it as double and immediatly rescales
%it

img = rescale(double(imread(imgName)));
end

