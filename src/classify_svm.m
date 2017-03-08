
label=('/Users/kanikas/Documents/MyProjects/HappinessDetection/labels/labels.txt');
testDataset = ('/Users/kanikas/Documents/MyProjects/HappinessDetection/testing');
trainDataset = ('/Users/kanikas/Documents/MyProjects/HappinessDetection/training');
% labels for the training data: happy:1, nonhappy:2
file=fopen(label);
imageLabel=textscan(file,'%s %s','whitespace',',');
fclose(file);
svmClassifier(trainDataset,imageLabel,testDataset);

function svmClassifier(data,imageLabel, testDataset)
    %SVMModel = fitcsvm(X,Y,'KernelFunction','rbf','Standardize',true,'ClassNames',{'negClass','posClass'});
    imageList = dir(data);
    numberOfImages = length(imageList);
    for i = 4: numberOfImages
        currentfilename = imageList(i).name;
        currentimage = imread(strcat(data,'/',currentfilename));
        images{i-3} = currentimage;
        images{i-3} = im2double(images{i-3});
        images{i-3} = rgb2gray(images{i-3});
        imshow(images{i-3});
        allLabels{i-3} = imageLabel{1,2}{i-3,1};
        trainingFeatures(i-3, :) = extractHOGFeatures(currentimage);
        [x,y] = size(images);
    end
    
    trainingLabels = allLabels;
    classifier = fitcecoc(trainingFeatures, trainingLabels);
    testImageList = dir(testDataset);
    numberOfTestImages = length(testImageList);
    for i = 1:numberOfTestImages-2
        currentFilename = testImageList(i+2).name;
        currentImage = imread(strcat(testDataset,'/',currentFilename));
        testingFeatures(i, :) = extractHOGFeatures(currentImage);
    end

    testLabels=char({'1';'1';'1';'2';'2';'1';'1';'1';'1';'1';'2';'2';'1';'1';'1';'2';'1';'2';'2';'2'});
    predictedLabels = predict(classifier, testingFeatures);
    [confMat, order] = confusionmat(cellstr(testLabels), cellstr(predictedLabels));
    helperDisplayConfusionMatrix(confMat);
end


