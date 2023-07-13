 function imgOut = fusion(imgSrc,imgDst,H)
%FUSION Uses the homographic matrix H given as argument to redraw the
%imgSrc in the quadrangle of imgDst designed by quad

[h,w,c] = size(imgDst);

[xmax,ymax,c] = size(imgSrc);
imgOut=zeros(h,w,c);
% figure; Im=imshow(imgOut);
for y=1:h
    for x=1:w
        M_orig = [x;y];
        M_fin = transform(M_orig,H);
        y_fin = M_fin(1)/M_fin(3);
        x_fin = M_fin(2)/M_fin(3);
        if x_fin > 1 && x_fin < xmax && y_fin > 1 && y_fin < ymax

            x_fin=floor(x_fin);
            y_fin=floor(y_fin);
            
            imgOut(y,x,:) = imgSrc(x_fin,y_fin,:);

        else
            imgOut(y,x,:) = imgDst(y,x,:);

        end
        
    end
end

end

