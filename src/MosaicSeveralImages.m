function [Img,Mask,Borne] = MosaicSeveralImages(varargin)
%[Img,Mask,Borne] = MosaiquePlusieursImages(varargin)
% this function is used to combine several images at the same time,
% attetion all the input images should have 4 commun points for images
% in sequence

Img = cell2mat(varargin(1)); % image output

H = zeros(3,3,nargin-1); % homography matrixes

H = zeros(3,3,nargin-1);

I_fusion3 = cell(1,nargin);
M_fusion3 = cell(1,nargin);
B_fusion3 = cell(1,nargin);
%% calculer matrice homography entre chaque img
%ex: H12. H23,H34
for i = 1 : nargin-1
    %{
    De la façon dont la boucle est codée :
        - A chaque tour de boucle, on calcule H_{i,i+1}
        - On stocke l'homographie obtenue dans le tableau H
        - Les homographies vont "en avant"
    %}
    img_pre = cell2mat(varargin(i));
    img_suv = cell2mat(varargin(i+1));
    figure,imshow(img_pre);
    title("Source image. Please select the 4 angles of the image.");
    [x1,y1]=ginput(4);
    
    figure,imshow(img_suv);
    title("Destination image. Please select the 4 angles of the image.");
    [x2,y2]=ginput(4);
    tac2_quad  = [x2 y2];
    tac1_quad  = [ x1  y1];
    H(:,:,i) = getHomography(tac1_quad,tac2_quad);
    
    
end
%% connect to 1st img

Hn1 = zeros(3,3,nargin-1); % matrices d'homographie "en arrière"
Hn1(:,:,1) = inv(H(:,:,1)); % H21
for i = 2:nargin-1
    Hn1(:,:,i) = Hn1(:,:,1);
    for j = 2:i
        Hn1(:,:,i) = Hn1(:,:,i)*inv(H(:,:,j)); % voir formule sur rapport
    end
end
%% combiner chaque img


% [Io,Mo,Bo] = generateTriplet(cell2mat(varargin(1)));  % I1
[I,M,B] = generateTriplet(cell2mat(varargin(1)));
I_fusion3(1) = {I};
M_fusion3(1) = {M};
B_fusion3(1) = {B};


for i = 2:nargin
    
    % triplet pour la i-eme image
    [Io,Mo,Bo] = generateTriplet(cell2mat(varargin(i)));
    
    % transformation du triplet dans l'espace de l'image 1
    [I2,M2,B2] = Transform_triplet(Io,Mo,Bo,Hn1(:,:,i-1));
    
    %
    
    I_fusion3(i) = {I2};
    M_fusion3(i) = {M2};
    B_fusion3(i) = {B2};
    %    clc; close all;
%     
%     [I3,M3,B3] = fusion3(I,M,B,I2,M2,B2);
%     figure,imshow(I3);
%     data{i-1} = I3; % un cell pour sauvgarder des imgs
%     %figure;imshow(rescale(M3));
end
%% fusion_multi
%% mettre tous les I1n , dans un seul img

[Img,Mask,Borne] = fusion3(I_fusion3,M_fusion3,B_fusion3);

end

