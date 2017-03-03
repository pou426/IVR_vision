function [ image_bg ] = extract_bg( image_vec, show )
%Returns a background image from a list of images
% image_vec is a cell containing all images
% if show = 1, display background image

% get the number of images
len = length(image_vec);

% creates 3 arrays to store r/g/b values for all images
vec_r = cell(1,len);
vec_g = cell(1,len);
vec_b = cell(1,len);

for i = 1:len
    [vec_r{i},vec_g{i},vec_b{i}] = extract_rgb(image_vec{i});
end

% obtain the size for each colour channels
[row,col] = size(vec_r{1});

result_r = vec_r{1};
result_g = vec_g{1};
result_b = vec_b{1};

% do median filtering to obtain the value for each colour channel
% on each pixel
for x = 1:row
    for y = 1:col
        R = zeros(1,len); 
        G = zeros(1,len); 
        B = zeros(1,len);
        for i = 1:len
            R(i) = vec_r{i}(x,y);
            G(i) = vec_g{i}(x,y);
            B(i) = vec_b{i}(x,y);
        end
        med_r = median(R);
        med_g = median(G);
        med_b = median(B);
        
        result_r(x,y) = med_r;
        result_g(x,y) = med_g;
        result_b(x,y) = med_b;
    end
end

% combines the 3 colour channels together
image_bg = cat(3, result_r, result_g, result_b);

% display image
if ~(show == 0)
    figure,
    imshow(uint8(255*image_bg));
    title('background image')
end

end


