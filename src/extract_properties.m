function [detected, properties, filledAreas, labelled] = extract_properties(image_binary) 
% Extract the properties as a 5-dimensional feature vector for each detected object
% Input is a binary image 
% Output "detected" is the total number of detected objects (valid or
% invalid) in the image. Output "properties" is a d x 5 matrix for d 
% detected objects in the image. Output filledAreas is a d x 1 vector for
% the filled area of each detected object. Output labelled is the binary
% image which has been labelled all detections.

    % enhance the image
    %se = strel('disk',3,8);
    %refined = imopen(image_binary,se); 
    refined = bwmorph(image_binary,'erode',1);
    
    BW = image_binary;
    CC=bwconncomp(BW,8);
    L=labelmatrix(CC);

    props=regionprops(CC,'area');
    idx=([props.Area]>15);
    BW2 = ismember(L,find(idx));
    CC2 = bwconncomp(BW2,8);
    labelled = labelmatrix(CC2);
    props = regionprops(labelled,'FilledArea');
    filledAreas = [props.FilledArea];
    
    detected = length(unique(labelled))-1;
    for j = 1:detected
        properties(j,:) = mygetproperties(labelled==j);
    end
end
