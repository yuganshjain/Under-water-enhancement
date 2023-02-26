close all
clear all
clc
RGB_img = imread('underwater_fish.JPG');
hsv_img=rgb2hsv(RGB_img);
L = hsv_img; 

% Perform CLAHE
L(:,:,3) = adapthisteq(L(:,:,3),'NumTiles', [10 10],'ClipLimit',0.05);
% Convert back to RGB_img color space
RGB_img1=hsv2rgb(L);
% Display the results
figure, imshow(RGB_img); 
figure, imshow(RGB_img1),title('HSV clahe');
oldresults(RGB_img,RGB_img1);
%contrast gain

im = double(rgb2gray(RGB_img));
op = double(rgb2gray(RGB_img1));
[M, N] = size(im);


% RGB_img
RGB_img1(:,:,1) = adapthisteq(RGB_img(:,:,1),'NumTiles', [10 10],'ClipLimit',0.01);
RGB_img1(:,:,2) = adapthisteq(RGB_img(:,:,2),'NumTiles', [10 10],'ClipLimit',0.01);
RGB_img1(:,:,3) = adapthisteq(RGB_img(:,:,3),'NumTiles', [10 10],'ClipLimit',0.01);
figure, imshow(uint8(RGB_img1)),title('RGB_img clahe');

oldresults(RGB_img,(RGB_img1));
