close all
clear all
clc

%% Load image
RGB_img = imread('underwater_fish.JPG');

%% Method 1: Apply CLAHE to enhance contrast in HSV color space
hsv_img = rgb2hsv(RGB_img);
L = hsv_img; 
L(:,:,3) = adapthisteq(L(:,:,3),'NumTiles', [10 10],'ClipLimit',0.05);
RGB_img_hsv_clahe = hsv2rgb(L);

%% Method 2: Apply adaptive gamma correction in LAB color space
lab_img = rgb2lab(RGB_img);
L = lab_img(:,:,1)/100;
L_mean = mean2(L);
gamma = log10(0.5)/log10(L_mean);
L_corr = L.^gamma;
lab_img(:,:,1) = L_corr*100;
RGB_img_lab_corr = lab2rgb(lab_img);

%% Method 3: Apply color correction using gray world assumption
% Calculate average R, G, B values
R = RGB_img_hsv_clahe(:,:,1);
G = RGB_img_hsv_clahe(:,:,2);
B = RGB_img_hsv_clahe(:,:,3);
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

%% Method 4: Apply histogram equalization to each RGB channel
R_eq = histeq(RGB_img(:,:,1));
G_eq = histeq(RGB_img(:,:,2));
B_eq = histeq(RGB_img(:,:,3));
RGB_img_hist_eq = cat(3, R_eq, G_eq, B_eq);

%% Display results
figure, imshow(RGB_img);
title('Original image');

figure, imshow(RGB_img_hsv_clahe);
title('Method 1: CLAHE in HSV color space');

figure, imshow(RGB_img_lab_corr);
title('Method 2: Adaptive gamma correction in LAB color space');

figure, imshow(RGB_img_corrected);
title('Method 3: Color correction using gray world assumption');

figure, imshow(RGB_img_hist_eq);
title('Method 4: Histogram equalization in RGB color space');

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
