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
image1 = '/Users/kanikas/Documents/MyProjects/HappinessDetection/images/LastZone.png';
getImage(images, '/Users/kanikas/Documents/MyProjects/HappinessDetection/images/LastZone.png', numImages, imageList);
detectFaces(image1)
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
end

function numberOfFaces =countFacesPerZone(noOfFaces)
numberOfFaces = noOfFaces;
disp(numberOfFaces);
end

function detectHappyFace(image1)

end

function[happiness] = computeHappinessFactor(happyFaces, totalFaces)
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
