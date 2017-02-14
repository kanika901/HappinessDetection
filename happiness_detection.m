% This program takes inauguration images as input (each image has multiple
% faces, will refer to it as a zone) and finds the happiness level in all
% zones.
%Input: Inauguration photo segmented into multiple photos
%Output: Give happiness level for each zone and pop image with the most
%happiness
% Author: Kanika Sood
% Date: February 10, 2017

images = ('/Users/kanikas/Documents/MyProjects/HappinessDetection/images');
zones=containers.Map;
imageList = dir(images);
numImages = length(imageList);
image1 = '/Users/kanikas/Documents/MyProjects/HappinessDetection/images/Lastzone.png';
getImage(images, '/Users/kanikas/Documents/MyProjects/HappinessDetection/images/Lastzone.png', numImages, imageList);
detectFaces(image1);


function trainImages = getImage(images, image1, numImages, imageList)
imageLocation = strcat(images, '/');
for i = 3:numImages
    trainImages{i-2,1} = strcat(imageLocation, imageList(i).name);
end
end

function detectFaces(image1)
faceDetector = vision.CascadeObjectDetector; %detects faces with Viola-Jones algorithm
image = imread(image1);
bboxes = step(faceDetector, image);

[noOfFaces, y] = size(bboxes);
countFacesPerZone(noOfFaces);
faces = insertObjectAnnotation(image, 'rectangle', bboxes, 'Face');
figure, imshow(faces), title('Detected faces')
formSubImages(bboxes, image1, noOfFaces);
end

function numberOfFaces =countFacesPerZone(noOfFaces)
numberOfFaces = noOfFaces;
fprintf('Number of faces in the images are: %i', numberOfFaces);
%disp(numberOfFaces);
end

function formSubImages(bboxes, image1, noOfFaces)
img = imread(image1);
bbox = bbox2points(bboxes);
for i = 1:length(bboxes)
    subImage = imcrop(img, bboxes(i,:));
    face = insertObjectAnnotation(subImage, 'rectangle', bboxes(i,:), 'Face');% imcrop();
    figure, imshow(face), title('Detected faces');
    imshow(subImage);
    subImageName = strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/zone2/Zone2_', num2str(i),'.png');
    imwrite(subImage,subImageName);
end
end

function detectHappyFace()

end

function happiness = computeHappinessFactor(happyFaces, totalFaces)
happiness = happyFaces/totalFaces;
end

function maintainZones(zoneName, happinessFactor)
zones(zoneName) = happinessFactor; % dictionary for zone name and its happiness factor 
end

function compareHappinessFactor(zones)
%loop over all zones and find the largest value for the key-value pair.
end

function getHappiestZone()

end

function showHappiestZone()

end

function generateHeatMap()

end

function showHeatMap()

end
