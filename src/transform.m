function M = transform(M,H)
%TRANSFORM applies the transformation described by H to x and y, the coords
%given in the matrix M.

[x,y]=size(M);
if x~=2 || y~=1
    error("Dimensions de la matrice M non respectées");
end

M = [M;1];

M = H*M;

end

