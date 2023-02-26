close all
clear all
clc

%% Load and display original image
RGB_img = imread('underwater_fish.JPG');
figure('Name','Original Image');
imshow(RGB_img);

%% CLAHE on LAB color space
% Convert to LAB color space
lab_img = rgb2lab(RGB_img);

% Apply CLAHE on L channel
lab_img(:,:,1) = adapthisteq(lab_img(:,:,1), 'NumTiles', [10 10], 'ClipLimit', 0.02);

% Convert back to RGB color space
RGB_img_clahe_lab = lab2rgb(lab_img);

% Display the result
figure('Name','CLAHE on LAB color space');
imshow(RGB_img_clahe_lab);
title('CLAHE on LAB color space');

%% CLAHE on HSV color space
% Convert to HSV color space
hsv_img = rgb2hsv(RGB_img);

% Apply CLAHE on V channel
hsv_img(:,:,3) = adapthisteq(hsv_img(:,:,3), 'NumTiles', [10 10], 'ClipLimit', 0.02);

% Convert back to RGB color space
RGB_img_clahe_hsv = hsv2rgb(hsv_img);

% Display the result
figure('Name','CLAHE on HSV color space');
imshow(RGB_img_clahe_hsv);
title('CLAHE on HSV color space');

%% CLAHE on RGB color space
% Apply CLAHE on each color channel
RGB_img_clahe_rgb = zeros(size(RGB_img));
for i = 1:3
    RGB_img_clahe_rgb(:,:,i) = adapthisteq(RGB_img(:,:,i), 'NumTiles', [10 10], 'ClipLimit', 0.02);
end

% Display the result
figure('Name','CLAHE on RGB color space');
imshow(uint8(RGB_img_clahe_rgb));
title('CLAHE on RGB color space');

%% Contrast gain comparison
% Calculate contrast gain for each CLAHE image
contrast_gain_lab = contrast_gain(RGB_img, RGB_img_clahe_lab);
contrast_gain_hsv = contrast_gain(RGB_img, RGB_img_clahe_hsv);
contrast_gain_rgb = contrast_gain(RGB_img, RGB_img_clahe_rgb);

% Display contrast gain results
figure('Name','Contrast Gain Comparison');
bar([contrast_gain_lab, contrast_gain_hsv, contrast_gain_rgb]);
title('Contrast Gain Comparison');
xticklabels({'LAB', 'HSV', 'RGB'});
ylabel('Contrast Gain');

function contrast_gain_val = contrast_gain(im, op)
% Calculates the contrast gain between the original image (im) and the
% processed image (op)

im = double(rgb2gray(im));
op = double(rgb2gray(op));

% Calculate RMS contrast for original image
rms_im = sqrt(mean(im(:).^2));

% Calculate RMS contrast for processed image
rms_op = sqrt(mean(op(:).^2));

% Calculate contrast gain
contrast_gain_val = 20*log10(rms_op/rms_im);

end
