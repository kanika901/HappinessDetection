% This program takes inauguration images as input (each image has multiple
% faces, will refer to it as a zone) and finds the happiness level in a
% zones.
% Input: Inauguration photo segmented into multiple photos
% Output: Give happiness level for a zone gives the happiness score (<=100)
% happiness
% Date: February 10, 2017

w = warning ('off','all');
images = ('/Users/kanikas/Documents/MyProjects/HappinessDetection/images');
zones=containers.Map;
imageList = dir(images);
numImages = length(imageList);
global happy_faces
happy_faces=0;
global total_faces_in_image
% image1 ='/Users/kanikas/Documents/MyProjects/HappinessDetection/dataset2/31.png';
% getImage(images,'/Users/kanikas/Documents/MyProjects/HappinessDetection/dataset2/31.png',numImages, imageList); 
image1 ='/Users/kanikas/Documents/MyProjects/HappinessDetection/dataset2/Hottest.png';
getImage(images,'/Users/kanikas/Documents/MyProjects/HappinessDetection/dataset2/Hottest.png',numImages, imageList); 
%image1 = '/Users/kanikas/Documents/MyProjects/HappinessDetection/dataset2/2.png';
%getImage(images, '/Users/kanikas/Documents/MyProjects/HappinessDetection/dataset2/2.png', numImages, imageList);
detectFaces(image1);

function zoneImages = getImage(images, image1, numImages, imageList)
imageLocation = strcat(images, '/');
for i = 3:numImages
    zoneImages{i-2,1} = strcat(imageLocation, imageList(i).name);
end
end

%detect faces in the zone image.
function detectFaces(image1)
faceDetector = vision.CascadeObjectDetector; %detects faces with Viola-Jones algorithm
image = imread(image1);
bboxes = step(faceDetector, image);
[noOfFaces, y] = size(bboxes);
countFacesPerZone(noOfFaces);
%draw rectangle on image to show faces
faces = insertObjectAnnotation(image, 'rectangle', bboxes, 'Face');
figure, imshow(faces), title('Detected faces')
%save the face images as separate images
formSubImages(bboxes, image1, noOfFaces);
end

function numberOfFaces =countFacesPerZone(noOfFaces)
numberOfFaces = noOfFaces;
global total_faces_in_image
total_faces_in_image = noOfFaces;
fprintf('Number of faces in the images are: %i \n', numberOfFaces);
end

%capture the face from the image and make it a subimage
function formSubImages(bboxes, image1, noOfFaces)
img = imread(image1); %full zone image
bbox = bbox2points(bboxes);
x=size(bboxes);
rows=x(1);
if rows > 0
    for i = 1:rows
        subImage = imcrop(img, bboxes(i,:));
        face = insertObjectAnnotation(subImage, 'rectangle', bboxes(i,:), 'Face');% imcrop();
        %subImageName =strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/zone4/Zone4_', num2str(i),'.png');
        mkdir /Users/kanikas/Documents/MyProjects/HappinessDetection/zones/hottest_zone mouths
        subImageName =strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/hottest_zone/hottest_', num2str(i),'.png');
        %subImageName = strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/test/test_', num2str(i),'.png');
        imwrite(subImage,subImageName);
        fprintf('Image name: %s \n' , subImageName)
        detectMouth(subImage, noOfFaces);
        %detectHappyFace(subImage);
    end
end
global happy_faces
global total_faces_in_image
fprintf('Total happy faces found: %i \n', happy_faces)
fprintf('Total faces in image: %i \n', total_faces_in_image)
happiness_score = (happy_faces/ total_faces_in_image) * 100;
fprintf('Happiness score of this zone is %i (out of 100 [Higher score means more happiness] ) \n', happiness_score)
end

%capture the mouth from the face and make it a subsubimage
function formSubSubImages(bboxes, image1, noOfFaces)
img = image1;
bbox = bbox2points(bboxes);
for i = 1:length(bboxes)
    subSubImage = imcrop(img, bboxes(i,:));
    %mouth = insertObjectAnnotation(subSubImage, 'rectangle', bboxes(i,:), 'Mouth');% imcrop();
    mkdir /Users/kanikas/Documents/MyProjects/HappinessDetection/zones/hottest_zone mouths
    subSubImageName =strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/hottest_zone/mouths/mouths_',num2str(i),'.png');
    %subSubImageName =strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/zone4/mouths/mouths_',num2str(i),'.png');
    %subSubImageName = strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/test/mouths/mouths_', num2str(i),'.png');
    imwrite(subSubImage,subSubImageName);
end
end

function detectMouth(image, noOfMouths)
mouthDetector = vision.CascadeObjectDetector('Mouth','MergeThreshold',120); %detects 12 out of 14 mouths
image = imresize(image, 4);
bbox=step(mouthDetector,image);
%figure,imshow(image); 
[noOfMouths, y] = size(bbox);

%draw rectangle on image to show mouths
mouths = insertObjectAnnotation(image, 'rectangle', bbox, 'Mouth');
figure, imshow(mouths), title('Detected mouths')
global happy_faces
if all(length(bbox) > 0)
    for i = 1:size(bbox,1)
        rectangle('Position',bbox(i,:),'LineWidth',2,'LineStyle','-','EdgeColor','b');
        subSubImage = imcrop(image, bbox(i,:));
        %mouth = insertObjectAnnotation(subSubImage, 'rectangle', bboxes(i,:), 'Mouth');% imcrop();
        mkdir /Users/kanikas/Documents/MyProjects/HappinessDetection/zones hottest_zone
        subSubImageName =strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/hottest_zone/mouths/mouths_',randi([1,100]), num2str(i),'.png');
        %subSubImageName =strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/zone4/mouths/mouths_',randi([1,100]), num2str(i),'.png');
        %subSubImageName = strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/test/mouths/mouths_', randi([1,100]), num2str(i),'.png');
        imwrite(subSubImage,subSubImageName);
        %formSubSubImages(bbox, image, noOfMouths);
        %detectHappyFace(image, bbox);
    end
    detectMouthCorners(subSubImage);
    
else
    disp('No bbox');
    happy_faces=happy_faces-1; 
end

end

%Todo: Better corners can be computed. 
function farthestCorners = computeFarthestCorners(corners)
disp('Corners....')
disp(corners)
[x,y] = size(corners);
maxDistance = 0;
p1 = 0; p2 = 0;
for i = 1: x
      for j = i+1: x-1
          distance = corners(i).Location - corners(j).Location;
          if maxDistance < sqrt(distance(1)^2 + distance(2)^2 )
              maxDistance = distance;
          end
      end
end
for i = 1: x
      for j = i+1: x -1
          distance = corners(i).Location - corners(j).Location;
          if maxDistance == distance
              p1 = corners(i).Location; 
              p2 = corners(j).Location;
          end
      end
end
farthestCorners = maxDistance;
disp(maxDistance)
dispFarthestPoints(p1,p2);
farthestCornerDistance = abs(abs(farthestCorners(1))- abs(farthestCorners(2)));
fprintf('Farthest corners distance: %i \n',farthestCornerDistance);
global happy_faces
if abs(farthestCornerDistance) > 5
    fprintf('Smile detected \n')
    happy_faces = happy_faces + 1;
end

end

function dispFarthestPoints(p1,p2)
    plot(p1,p2);
end

function detectMouthCorners(image)
    Irgb2gray=rgb2gray(image);
    % Detect mouth corners using Harris-Stephens algorithm 
    corners = detectHarrisFeatures(Irgb2gray); 
    imshow(image); hold on;
    plot(corners.selectStrongest(10));
    corners=corners.selectStrongest(10);
    computeFarthestCorners(corners);
    disp('Detected mouth corners successfully.....')
end

function detectHappyFace(image, bbox) %image is the lips cropped from the face
disp(image)
disp('bbox:::')
disp(bbox)
%cornerDetector = vision.CornerDetector('Method', 'Minimum eigenvalue (Shi & Tomasi)');
x=size(bbox);
rows=x(1);
if rows > 0
    for i = 1:rows
        subsubImage = imcrop(image, bbox(i,:));
        subsubImageName = strcat('/Users/kanikas/Documents/MyProjects/HappinessDetection/zones/hottest_zone/mouths/mouths_', num2str(i),'.png');
        imwrite(subsubImage,subsubImageName);
        imshow(subsubImage);
        
    end
    detectMouthCorners(subsubImage);
else
    disp('Skip');
end
end

