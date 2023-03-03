close all
clear all
clc

%% Load image
RGB_img = imread('underwater_fish.JPG');

%% Apply CLAHE to enhance contrast
hsv_img = rgb2hsv(RGB_img);
L = hsv_img; 
L(:,:,3) = adapthisteq(L(:,:,3),'NumTiles', [10 10],'ClipLimit',0.05);
RGB_img_clahe = hsv2rgb(L);

%% Apply unsharp masking (USM)
h = fspecial('unsharp');
RGB_img_usm = imfilter(RGB_img_clahe, h);

%% Apply joint CLAHE to further enhance contrast
YCBCR_img = rgb2ycbcr(RGB_img_usm);
YCBCR_img(:,:,1) = adapthisteq(YCBCR_img(:,:,1),'NumTiles', [8 8],'ClipLimit',0.01);
RGB_img_joint_clahe = ycbcr2rgb(YCBCR_img);

%% Apply color correction using gray world assumption
% Calculate average R, G, B values
R = RGB_img_joint_clahe(:,:,1);
G = RGB_img_joint_clahe(:,:,2);
B = RGB_img_joint_clahe(:,:,3);
avgR = mean2(R);
avgG = mean2(G);
avgB = mean2(B);

% Find scaling factors
kR = avgG / avgR;
kB = avgG / avgB;

% Apply scaling factors to R and B channels
R_corrected = R * kR;
B_corrected = B * kB;

% Recombine channels
RGB_img_corrected = cat(3, R_corrected, G, B_corrected);

%% Display results
figure, imshow(RGB_img);
title('Original image');

figure, imshow(RGB_img_clahe);
title('CLAHE enhanced image');

figure, imshow(RGB_img_usm);
title('USM enhanced image');

figure, imshow(RGB_img_joint_clahe);
title('Joint CLAHE enhanced image');

figure, imshow(RGB_img_corrected);
title('Color corrected image');

%% Function to compare results with original image
function oldresults(original, new)
    figure;
    subplot(1,2,1);
    imshow(original);
    title('Original image');
    subplot(1,2,2);
    imshow(new);
    title('Enhanced image');
end