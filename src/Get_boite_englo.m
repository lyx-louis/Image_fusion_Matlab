function [B2] = Get_boite_englo(I,B,H)
%TRANSFORM_MOSAIQUE 
%   I-> matrice de image
%   M-> matrice de masque
%   B-> 2 points de cote
%   H -> matrice homography
[h,w,z] = size(I);
B_left_top = B(1,:);
B_right_bot = B(2,:);
B_left_bot = [B(1,1) B(2,2)];
B_right_top = [B(2,1) B(1,2)];

B_lt = transform(B_left_top',H);
B_rb = transform(B_right_bot',H);
B_lb = transform(B_left_bot',H);
B_rt = transform(B_right_top',H);

xvect = zeros(1,4);
xvect(1) = B_lt(2)/B_lt(3);
xvect(2) = B_rb(2)/B_rb(3);
xvect(3) = B_lb(2)/B_lb(3);
xvect(4) = B_rt(2)/B_rt(3);

xmin=min(xvect);
xmax = max(xvect);


yvect = zeros(1,4);
yvect(1) = B_lt(1)/B_lt(3);
yvect(2) = B_rb(1)/B_rb(3);
yvect(3) = B_lb(1)/B_lb(3);
yvect(4) = B_rt(1)/B_rt(3);

ymin = min(yvect);
ymax = max(yvect);

B2 = [xmin ymin;xmax ymax];
% for x = 1:h
%     for y = 1:w
%         
%     end
% end

end

