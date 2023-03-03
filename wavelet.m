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

%% Apply wavelet fusion technique to enhance details
wv = 'db2';
[LL1, HL1, LH1, HH1] = dwt2(RGB_img_corrected(:,:,1), wv);
[LL2, HL2, LH2, HH2] = dwt2(RGB_img_corrected(:,:,2), wv);
[LL3, HL3, LH3, HH3] = dwt2(RGB_img_corrected(:,:,3), wv);
LL = (LL1 + LL2 + LL3) / 3;
HL = max(abs(HL1), max(abs(HL2), abs(HL3))) .* sign(HL1 + HL2 + HL3);
LH = max(abs(LH1), max(abs(LH2), abs(LH3))) .* sign(LH1 + LH2 + LH3);
HH = max(abs(HH1), max(abs(HH2), abs(HH3))) .* sign(HH1 + HH2 + HH3);
RGB_img_wavelet = idwt2(LL, HL, LH, HH, wv);

%% Display results
figure, imshow(RGB_img);
title('Original image');

figure, imshow(RGB_img_clahe);
title('CLAHE enhanced image');

figure, imshow(RGB_img_corrected);
title('Color corrected image');

figure, imshow(RGB_img_wavelet);
title('Wavelet fused image');

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
