function [R,G,B] = extract_rgb( Image_rgb )
% Extract the normalised R, G and B channels for a given image file
    
    Image_red = Image_rgb(:,:,1);
    Image_green = Image_rgb(:,:,2);
    Image_blue = Image_rgb(:,:,3);
    
    [row,col] = size(Image_red);
    
    for x = 1:row
        for y = 1:col
            Red = Image_red(x,y);
            Green = Image_green(x,y);
            Blue = Image_blue(x,y);
            
            if (Red == 0 && Green == 0 && Blue == 0)
                Red = 1;
                Green = 1;
                Blue = 1;
            end
            
            rgb_sum = Red + Green + Blue;
    
            NormalisedRed = Red/rgb_sum;
            NormalisedGreen = Green/rgb_sum;
            NormalisedBlue = Blue/rgb_sum;
            
            Image_red(x,y) = NormalisedRed;
            Image_green(x,y) = NormalisedGreen;
            Image_blue(x,y) = NormalisedBlue;
        end
    end
    
    R = Image_red;
    G = Image_green;
    B = Image_blue;
    
end

