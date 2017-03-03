function [ image_rgb_norm ] = normIm( r,g,b, show )
%Returns the normalised RGB image
%   r = red channel; g = green channel; b = blue channel
%   if show = 0, do not display figure

    image_rgb_norm = cat(3,r,g,b);
    if ~(show==0)
        figure()
        imshow(uint8(255*image_rgb_norm))
    end
end

