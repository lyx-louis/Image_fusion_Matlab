function imgOut = restore(imgOut, img1, H1, img2, H2, quad1, quad2)
%RESTORE makes an attempt at restoring the original image with two points
%of view, and their homographic matrix
%   RESTORE(IMGOUT, IMG1, H1, IMG2, H2) tries to find a place in IMGOUT for
%   each pixel of both IMG1 and IMG2, and makes a mean of their R,G,B
%   values for each pixel.
%

[h,w,c] = size(imgOut);

[ymax,xmax,c] = size(img1);
[ymax2, xmax2, c] = size(img2);
imgOut=zeros(h,w,c);

for y=1:h
    for x=1:w
        M_orig = [x;y];
        M_fin = transform(M_orig,H1);
        y_fin = M_fin(1)/M_fin(3);
        x_fin = M_fin(2)/M_fin(3);
        
        M_orig2 = [x;y];
        M_fin2 = transform(M_orig2, H2);
        y_fin2 = M_fin2(1)/M_fin2(3);
        x_fin2 = M_fin2(2)/M_fin2(3);
        pt = [floor(y_fin) floor(x_fin)];
        pt2 = [floor(y_fin2) floor(x_fin2)];
        if inQuadrilateral(pt,quad1)
            %fprintf("In img: (%d,%d)\n",x_fin, y_fin);

            x_fin=floor(x_fin);
            y_fin=floor(y_fin);
            
            imgOut(x,y,:) = imgOut(x,y,:)+img1(x_fin,y_fin,:)/2;
        
            
        end
        
        if inQuadrilateral(pt2,quad2)
            %fprintf("In img: (%d,%d)\n",x_fin, y_fin);

            x_fin2=floor(x_fin2);
            y_fin2=floor(y_fin2);
            
            imgOut(x,y,:) = imgOut(x,y,:)+img2(x_fin2,y_fin2,:)/2;
        end
        %Im.CData = imgOut;
        %drawnow limitrate;
    end
end
end

