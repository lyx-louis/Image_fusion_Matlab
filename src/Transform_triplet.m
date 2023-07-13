function [I2,M2,B2] = Transform_triplet(I,M,B,H12)
%TRANSFORM_TRIPLET 此处显示有关此函数的摘要
%   此处显示详细说明
[h,w,c] = size(I);
% 4 points de englo boite
B_left_top = B(1,:);
B_right_bot = B(2,:);
B_left_bot = [B(1,1) B(2,2)];
B_right_top = [B(2,1) B(1,2)];
% transformation des points
B_lt = transform(B_left_top',H12);
B_rb = transform(B_right_bot',H12);
B_lb = transform(B_left_bot',H12);
B_rt = transform(B_right_top',H12);
% coordonnees en x
xvect = zeros(1,4);
xvect(1) = B_lt(1)/B_lt(3);
xvect(2) = B_rb(1)/B_rb(3);
xvect(3) = B_lb(1)/B_lb(3);
xvect(4) = B_rt(1)/B_rt(3);
% determination min/max de x
xmin=min(xvect);
xmax = max(xvect);

% coordonnees y
yvect = zeros(1,4);
yvect(1) = B_lt(2)/B_lt(3);
yvect(2) = B_rb(2)/B_rb(3);
yvect(3) = B_lb(2)/B_lb(3);
yvect(4) = B_rt(2)/B_rt(3);
% ymin/ymax
ymin = min(yvect);
ymax = max(yvect);
% creation d'englo boite
B2 = [xmin ymin;xmax ymax];

H21 = inv(H12);
% en masque

length = ceil(B2(2,1)-B2(1,1));
width = ceil(B2(2,2)-B2(1,2));
I2 = zeros(width,length,c);
M2 = zeros(width,length,1);

offsetX = floor(B2(1,1));
offsetY = floor(B2(1,2));

[xmax,ymax,c] = size(I2); % 女

%imgOut=zeros(h,w,c);
%masque = zeros(h,w,1);
% figure; Im=imshow(imgOut);
for y=floor(B2(1,2)):floor(B2(2,2)) % 对楼所有的像素
    for x=floor(B2(1,1)):floor(B2(2,1))
        M_orig = [x;y]; % pixel de l'image target 
        M_fin = transform(M_orig,H21); % M_orig * H = M_src; % 进行转变
        y_fin = M_fin(1)/M_fin(3);
        x_fin = M_fin(2)/M_fin(3);
        if x_fin > 1 && x_fin < h && y_fin > 1 && y_fin < w % 如果转换出来的点在女图中
            
            x_fin=floor(x_fin);
            y_fin=floor(y_fin);
            
%             disp([y-offsetY,x_fin]);
            if (y-offsetY==0)
                disp("toto");
            end
            I2(y-offsetY,x-offsetX,:) = I(x_fin,y_fin,:); % 切换成女图
            M2(y-offsetY,x-offsetX) = 1;
            
        end
        
    end
end



end

