% my training code

% For each image, two figures are shown with the top being the original rgb
% image and the bottom being the binary labelled image. One object is shown
% each time, and user can give the true class label to each object. If the
% object is noise, input 0 and that object will be disregarded.

% Obtains n by d feature vector matrix for all n valid objects and d dimensions
% Obtains n by 1 true class vectors
% Builds a classification model 

% load('preprocessImages.mat');

Dim = 5;
maxclasses = 10;
N = 7;

%%extract feature vectors and classes from each bin_image
%alllabels = cell(7,1);
%allareas = cell(7,1);
index = 1;
figure,
for i = 1:N
    subplot(2,1,1);
    imshow(uint8(image_vec{i}));
    current_fg_bin = image_vec_fg_bin{i};
    [d,p,a,l] = extract_properties(current_fg_bin);
    for j = 1:d
        subplot(2,1,2);
        imshow(l==j);
        label = input('Insert class no.: ');
        %imagelabels(j) = label; 
        if (label > 0)
            vec(index,:) = p(j,:);
            trueclasses(index) = label;
            index = index + 1;
        end
    end
    %alllabels{i} = imagelabels;
    %allareas{i} = a;
end
close()

index = index - 1; % the total number of valid detected items

% build statistical model 
[Means,Invcors,Aprioris] = buildmodel(Dim,vec,index,maxclasses,trueclasses);

% % save all data into a .mat file
% modelfilename = 'mytrainingdata';
% eval(['save ',modelfilename,' Dim vec trueclasses maxclasses Means Invcors Aprioris'])

% save all data at this stage
save('mytrainingdata');