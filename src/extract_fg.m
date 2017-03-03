function [ image_fg, image_fg_bin ] = extract_fg( image_rgb_norm, image_bg, show )
% extract foreground from an image
% image_rgb_norm: normalised rgb image
% image_bg: background image
% returns the rgb foreground image and binarised foreground image
%   show = 1 to display image
    
    % r,g,b channels for normalised rgb image
    im_r = image_rgb_norm(:,:,1); 
    im_g = image_rgb_norm(:,:,2); 
    im_b = image_rgb_norm(:,:,3);

    % r,g,b channels for background image
    bg_r = image_bg(:,:,1); 
    bg_g = image_bg(:,:,2); 
    bg_b = image_bg(:,:,3);
    
    % absolute differences between colour channels
    diff_r = abs(im_r-bg_r);
    diff_g = abs(im_g-bg_g);
    diff_b = abs(im_b-bg_b);

%     % shows 3 histograms for each channel to determine threshold
%     figure
%     subplot(3,1,1)
%     histogram(diff_r)
%     title('histogram for channel R')
% 
%     subplot(3,1,2)
%     histogram(diff_g)
%     title('histogram for channel G')
%     
%     subplot(3,1,3)
%     histogram(diff_b)
%     title('histogram for channel B')

    % using mean
    thresh_r = 0.0087;
    thresh_g = 0.0086;
    thresh_b = 0.0199;
        
%     % using mode
%     thresh_r = 0.001;
%     thresh_g = 0.009;
%     thresh_b = 0.01;

    % using median

    
    % initialises rgb foreground image and binary foreground image
    [row,col,d] = size(image_rgb_norm);
    image_fg = image_rgb_norm;
    image_fg_bin = image_rgb_norm(:,:,1);
    
    for x = 1:row
        for y = 1:col
            if (diff_r(x,y) >= thresh_r || diff_g(x,y) >= thresh_g || diff_b(x,y) >= thresh_b)
                image_fg(x,y,1) = image_rgb_norm(x,y,1);
                image_fg(x,y,2) = image_rgb_norm(x,y,2);
                image_fg(x,y,3) = image_rgb_norm(x,y,3);
                image_fg_bin(x,y) = 255;
            else
                image_fg(x,y,:) = 0;
                image_fg_bin(x,y) = 0;
            end
        end
    end

    if ~(show == 0)
        figure
        imshow(uint8(255*image_fg));
        title('rgb foreground image')
        figure
        imshow(uint8(255*image_fg_bin));
        title('binary foreground image')
    end
end

