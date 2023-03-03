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

%% Apply color correction using gray world assumption
% Calculate average R, G, B values
R = RGB_img_clahe(:,:,1);
G = RGB_img_clahe(:,:,2);
B = RGB_img_clahe(:,:,3);
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

%% Apply Retinex image enhancement technique
sigma = 20;
G = fspecial('gaussian', 3*sigma, sigma);
R = imfilter(RGB_img_corrected(:,:,1), G, 'same', 'replicate');
G = imfilter(RGB_img_corrected(:,:,2), G, 'same', 'replicate');
B = imfilter(RGB_img_corrected(:,:,3), G, 'same', 'replicate');
RGB_img_retinex = RGB_img_corrected ./ cat(3, R, G, B);

%% Apply wavelet decomposition and fusion
[cA,cH,cV,cD] = dwt2(RGB_img_retinex(:,:,1),'haar');
[cA2,cH2,cV2,cD2] = dwt2(RGB_img_retinex(:,:,2),'haar');
[cA3,cH3,cV3,cD3] = dwt2(RGB_img_retinex(:,:,3),'haar');
fusedA = (cA+cA2+cA3)/3;
fusedH = (cH+cH2+cH3)/3;
fusedV = (cV+cV2+cV3)/3;
fusedD = (cD+cD2+cD3)/3;
RGB_img_wavelet = idwt2(fusedA,fusedH,fusedV,fusedD,'haar',[size(RGB_img,1),size(RGB_img,2)]);

%% Display results
figure, imshow(RGB_img);
title('Original image');

figure, imshow(RGB_img_clahe);
title('CLAHE enhanced image');

figure, imshow(RGB_img_corrected);
title('Color corrected image');

figure, imshow(RGB_img_retinex);
title('Retinex enhanced image');

figure, imshow(RGB_img_wavelet);
title('Retinex and Wavelet fused image');

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
