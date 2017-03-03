% my testing code

% Extracts n x 5 feature property matrix for n test images 
% Extracts properties for every detected object in each image
% Uses the filled area of an object to determine whether it is a valid
% object or invalid object (such as noise)
% Classifies each valid detection with classify method (from university)
% class_vec stores all classification output
% test_true_classes stores all user labelled true classes

%load('mytrainingdata.mat')

%to put in true classes for testing images
M =2; % ALTER HERE - no. of test image 

%test_true_classes is the correct class we manually put in. 
%class_vec is the classes our classifer come up with 
test_true_classes = cell(M,1); 
class_vec = cell(M,1);
%for labelling output with class number: 
labelled = cell(1,M); %new
binary_image = cell(1,M); %new 

startIdx = 8;
finIdx = 9;

% give true class labels 
index =1;
figure,
for i = startIdx:finIdx
    subplot(2,1,1);
    imshow(uint8(image_vec{i}));
    current_test_fg_bin = image_vec_fg_bin{i};
    [d,p,a,l] = extract_properties(current_test_fg_bin);
    curr_test_classes = zeros(1,d);

    for j = 1:d
        subplot(2,1,2);
        imshow(l==j)
        curr_test_classes(1,j) = input('Insert (actual) class no.: ');
    end
    test_true_classes{index} = curr_test_classes;
    labelled{index} = l;
    binary_image{index} = image_vec_fg_bin{i};
    index = index+1;
end
close()

% Now run classification

index = 1;
% extract property vectors and classes from each bin_image
for i = startIdx:finIdx
    current_test_fg_bin = image_vec_fg_bin{i};
    [d,p,a,l] = extract_properties(current_test_fg_bin);
    
    curr_class_vec = zeros(1,d);
    for j = 1:d
        if(a(j) >= 200) % add maximum!!!
            class = classify(p(j,:),maxclasses,Means,Invcors,Dim,Aprioris)
            curr_class_vec(1,j) = class;
        else
            curr_class_vec(1,j) = 0;
        end
    end
    class_vec{index} = curr_class_vec;
    index = index + 1;
end

%for labelling different classes. 
for x = 1:M
   l = labelled{x}; %containing labelled images
   curr = class_vec{x}; %current class vec
   s = regionprops(l, 'Centroid'); %get the centroid out
   h = figure();
   ishold
   hold on;
   imshow(binary_image{x}); 
   t = strcat('image ',num2str(x));
   title(t);

   for k = 1:numel(s) %number of detected objects
        a = curr(1,k); %select each class in the class vector
        c = s(k).Centroid; %select centroid
        text(c(1), c(2), sprintf('%d', a), ...
            'HorizontalAlignment', 'center', ...
            'VerticalAlignment', 'middle','Color','red','FontWeight','bold');
    end
    hold off;
    filename = strcat('results',num2str(x),'.jpg');
    saveas(h,filename)
end

%to store values
calculated_value = cell(1,M);
actual_value = cell(1,M); 

%calculating the value: 
 for i = 1:M 
    actual = test_true_classes{i};
    curr = class_vec{i};

    v1 = length(find(curr==1)); 
    v2 = length(find(curr==2))*2;
    v3 = length(find(curr==3))*0.5;
    v4 = length(find(curr==4))*0.2;
    v5 = length(find(curr==5))*0.05;
    v6 = length(find(curr==6))*0.75;
    v7 = length(find(curr==7))*0.25;
    v8 = length(find(curr==8))*0.02;

    vv1 = length(find(actual==1)); 
    vv2 = length(find(actual==2))*2;
    vv3 = length(find(actual==3))*0.5;
    vv4 = length(find(actual==4))*0.2;
    vv5 = length(find(actual==5))*0.05;
    vv6 = length(find(actual==6))*0.75;
    vv7 = length(find(actual==7))*0.25;
    vv8 = length(find(actual==8))*0.02;

    calculated_value{i} = v1+v2+v3+v4+v5+v6+v7+v8; 
    actual_value{i} = vv1+vv2+vv3+vv4+vv5+vv6+vv7+vv8; 
end
 calculated_value
 actual_value
  

% to display confusion matrix
for a = 1:M 
    [confusion_mat,order] = confusionmat(test_true_classes{a},class_vec{a}) 
    [row,column] = size(confusion_mat); % in case the size changes BUT row and column should match anyway.
    valid = confusion_mat; 
    invalid = valid(:,1); 
    valid(:,1)=0; 
    valid_detection = sum(sum(valid)) 
    valid_true = sum(sum(diag(valid))) 
    valid_false = valid_detection-valid_true
    invalid_detection = sum(invalid) 
    invalid_true = invalid(1,1)
    invalid_false = invalid_detection-invalid_true
end

save('mytestingdata');