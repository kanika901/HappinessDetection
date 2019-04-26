# Happiness Detection

This MATLAB program takes inauguration images as input (each image has multiple
 faces, hereon referred to as 'zone') and finds the happiness level for different zones.
 
### Input: Inauguration photo segmented into multiple photos.
### Output: Happiness level for different zones (happiness score <=100). 

### Algorithm: 
1. Provide the input image which contains multiple faces (Example: dataset2/Hottest.png)
2. The script -> happiness_detection.m, detects faces with Viola-Jones algorithm.
3. It displays the face in a rectangle over the images and saves each face in the input image as a separate image in a separate directory. 
4. It displays the mouth in a rectangle over the images and saves each mouth in the face image as a separate image in the zones/hottest_zone/mouths directory.
5. It finds the mouth corners using Harris-Stephens algorithm.
6. It computes the farthest corners out of the 10 strongest corners detected.
7. If the distance between the farthest corners is more than the threshold distance (Set to 5 for this dataset), then the face is considered 'happy'.
Please note this threshold may vary for a different dataset.
8. Counts (1) the number of happy faces and (2) total faces in an image and gives the happiness level as the ratio of the two multiplied with a factor of 100.

## Disclaimer: 
1. Better corners can be detected using unwanted filters and improving mouth detection. Due to limited time, this was not explored in detail.    
2. There is no political view or aspect in this project. It was a fun project; this work does not reflect any personal or political view.


 
 Please do not use the project or redistribute the code without permission from the author (Kanika Sood). Email at kanika901@gmail.com for questions.
 
 Date: February 10, 2017
 
 Email: kanika901@gmail.com

