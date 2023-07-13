function area = triangleArea(triangle)
%TRIANGLEAREA computes the area of a triangle
%   
%   TRIANGLE has to be a 3-by-2 vector containing the coordinates of each
%   point of the triangle
%%
p1 = triangle(1,:);
p2 = triangle(2,:);
p3 = triangle(3,:);
%%
sideA = sqrt(  (p2(2)-p1(2))^2 + (p2(1)-p1(1))^2);
sideB = sqrt( ( p3(2)-p2(2))^2 + (p3(1)-p2(1))^2);
sideC = sqrt( ( p1(2)-p3(2))^2 + (p1(1)-p3(1))^2);

p = (sideA+sideB+sideC)/2;

area = sqrt ( p * (p-sideA) * (p-sideB) * (p-sideC) );
end

