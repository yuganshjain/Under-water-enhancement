% Load the original and enhanced underwater images
original_image = imread('original_image.jpg');
enhanced_image = imread('enhanced_image.jpg');

% Convert images to LAB color space
original_image_lab = rgb2lab(original_image);
enhanced_image_lab = rgb2lab(enhanced_image);

% Calculate mean and standard deviation of the a and b channels for both images
original_mean = mean2(original_image_lab(:,:,2:3));
original_std = std2(original_image_lab(:,:,2:3));
enhanced_mean = mean2(enhanced_image_lab(:,:,2:3));
enhanced_std = std2(enhanced_image_lab(:,:,2:3));

% Calculate the UICM score
uicm = sqrt((original_std^2 + enhanced_std^2 + (original_mean - enhanced_mean)^2) / (original_std^2 + enhanced_std^2));

% Display the UICM score
fprintf('UICM score: %f\n', uicm);
