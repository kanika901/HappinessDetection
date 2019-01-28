This MATLAB program takes inauguration images as input (each image has multiple
 faces, will refer to it as a zone) and finds the happiness level for different zones.
 
Input: Inauguration photo segmented into multiple photos
Output: Give happiness level for different zones (happiness score <=100) 
Algorithm: 
1. Provide input image which contains multiple faces (Example: dataset2/Hottest.png)
2. This program detects faces with Viola-Jones algorithm.
3. It displays the face in a rectangle over the images and saves each face in the input image as a separate image in the 
4. It displays the mouth in a rectangle over the images and saves each mouth in the face image as a separate image in the zones/hottest_zone/mouths dire
    ctory
5. It finds the mouth corners using Harris-Stephens algorithm.
6. It computes the farthest corners out of the 10 strongest corners detected.
7. If the distance between the farthest corners is more than the threshold distance (Set to 5 for this dataset), then the face is considered 'happy'.
Please note this threshold may vary for a different dataset.
8. Counts the number of happy faces and total faces in an image and gives the happiness level as the ratio of the two multiplied with a factor of 100.

Disclaimer: Better corners can be detected using unwanted filters and improving mouth detection. Due to limited time, these was not explored in details.    
 
 Date: February 10, 2017

