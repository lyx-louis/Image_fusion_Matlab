function H = getHomography(quad1, quad2)
%getHomography computes the homographic matrix to get from quad1 to quad2
% in this version of the code, quad1 will be a full image, and quad2 any
% quadrangle (therefore, quad1 is src, and quad2 is dst). Or, in the
% transformation, (x2,y2) is the point in quad2 whereas (x1,y1) is the
% point in quad1, meaning H will be applied to src to get dest.
% Therefore, in the form M2 = H*M1, M1 contains points from src, and M2
% from dst. I think this comment is long enough now...

x1 = quad1(1,1);
x2 = quad1(2,1);
x3 = quad1(3,1);
x4 = quad1(4,1);

y1 = quad1(1,2);
y2 = quad1(2,2);
y3 = quad1(3,2);
y4 = quad1(4,2);

u1 = quad2(1,1);
u2 = quad2(2,1);
u3 = quad2(3,1);
u4 = quad2(4,1);

v1 = quad2(1,2);
v2 = quad2(2,2);
v3 = quad2(3,2);
v4 = quad2(4,2);

A = [ x1 y1  1  0  0  0 -x1*u1 -y1*u1 ; ...  %u1
       0  0  0 x1 y1  1 -x1*v1 -y1*v1 ; ...  %v1
      x2 y2  1  0  0  0 -x2*u2 -y2*u2 ; ...  %u2
       0  0  0 x2 y2  1 -x2*v2 -y2*v2 ; ...  %v2
      x3 y3  1  0  0  0 -x3*u3 -y3*u3 ; ...  %u3
       0  0  0 x3 y3  1 -x3*v3 -y3*v3 ; ...  %v3
      x4 y4  1  0  0  0 -x4*u4 -y4*u4; ...   %u4
       0  0  0 x4 y4  1 -x4*v4 -y4*v4];      %v4

B = [u1;v1;u2;v2;u3;v3;u4;v4];


X = A\B;

H = [ X(1) X(2) X(3);...
      X(4) X(5) X(6);...
      X(7) X(8)   1 ];
end

