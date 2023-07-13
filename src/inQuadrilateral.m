function out = inQuadrilateral(point,quad)
%INQUADRILATERAL uses a neat way to find if a point belongs to the
%quadrilateral found on stackoverflow to actually determine it without
%using Matlab's inPolygon function :P
%
%   INQUADRILATERAL(POINT,QUAD) uses the coordinates of the point to create
%   the triangles between the point and every point of the quadrilateral,
%   then process their areas, and the quadrilateral's area. If the sum of
%   the areas of the triangles is higher than the quadrilateral's area, the
%   point is outside.
%
%   POINT has to be a 1-by-2 vector, either row or column.
%
%   QUAD has to be a 4-by-2 vector.

%% FIRST, WE SPLIT THE QUADRILATERAL INTO TWO TRIANGLES TO PROCESS ITS AREA

Tri1 = [quad(1,:);quad(2,:);quad(4,:)];
Tri2 = [quad(2,:);quad(3,:);quad(4,:)];

%% THEN, WE CREATE THE TRIANGLES LINKED TO OUR POINT

Tri3 = [point;quad(1,:);quad(2,:)];
Tri4 = [point;quad(2,:);quad(3,:)];
Tri5 = [point;quad(3,:);quad(4,:)];
Tri6 = [point;quad(4,:);quad(1,:)];

%% BORING AREA COMPUTING

quadArea = sum([triangleArea(Tri1) triangleArea(Tri2)]);
ptArea = sum([triangleArea(Tri3) triangleArea(Tri4)...
                triangleArea(Tri5) triangleArea(Tri6)]);

thresh=.0001;
if abs(ptArea - quadArea)<thresh
    out = true(1);
else
    out = false(1);
end
end

