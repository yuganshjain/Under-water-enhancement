% Read the hazy image and restored image
hazy_image = imread('1.jpg');
restored_image = imread('m3.jpg');

% Convert the images to grayscale
gray_hazy = rgb2gray(hazy_image);
gray_restored = rgb2gray(restored_image);

% Calculate the standard deviation of the grayscale images
std_hazy = std(double(gray_hazy(:)));
std_restored = std(double(gray_restored(:)));

% Calculate the Contrast Gain
CG = std_restored / std_hazy;

% Display the Contrast Gain
fprintf('Contrast Gain: %.4f\n', CG);
