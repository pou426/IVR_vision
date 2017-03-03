% script #1
% This script preprocesses all images provided for thevision assignment.

% read all images (simple + hard)
i2 = double(imread('02.jpg')); % simple
i3 = double(imread('03.jpg'));
i4 = double(imread('04.jpg'));
i5 = double(imread('05.jpg'));
i6 = double(imread('06.jpg'));
i7 = double(imread('07.jpg'));
i8 = double(imread('08.jpg'));
i9 = double(imread('09.jpg'));
i10 = double(imread('10.jpg'));
i17 = double(imread('17.jpg')); % hard
i18 = double(imread('18.jpg')); 
i19 = double(imread('19.jpg'));
i20 = double(imread('20.jpg'));
i21 = double(imread('21.jpg'));

% store all images in a cell called image_vec
% the first 7 elements are training images
% the 8th to 9th elements are testing images
% the rest are the hard images, stored here for extracting a background
image_vec = {i2, i3, i4, i7, i8, i9, i10, i5, i6, i17, i18, i19, i20, i21};
len = length(image_vec);


% normalise all images and store them in a cell called image_vec_norm
image_vec_norm = cell(1, len);
for i = 1:len
    [r, g, b] = extract_rgb(image_vec{i});
    image_vec_norm{i} = normIm(r,g,b,0);
end

% creates a background image called image_bg
image_bg = extract_bg(image_vec_norm,1);
title('background image');

% store all foreground images in a cell called image_vec_fg
image_vec_fg = cell(1,len);
% store all binary foreground images in a cell called image_vec_fg_bin
image_vec_fg_bin = cell(1,len);

for i = 1:len
    [image_vec_fg{i}, image_vec_fg_bin{i}] = extract_fg(image_vec_norm{i}, image_bg, 0);
    % save binary foreground images into jpeg files
    filename = strcat('bin_fg',num2str(i),'.jpg');
    imwrite(uint8(255*image_vec_fg_bin{i}),filename);
end

% save all variables into a .mat file
save('data');

