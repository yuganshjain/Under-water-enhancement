% Read the underwater image
image = imread('wav1.jpg');

% Convert the image to grayscale if needed
if size(image, 3) > 1
    image = rgb2gray(image);
end

% Calculate the histogram of the image
histogram = imhist(image);

% Normalize the histogram
normalizedHistogram = histogram / sum(histogram);

% Calculate the entropy
entropyValue = -sum(normalizedHistogram .* log2(normalizedHistogram + eps));

% Display the result
fprintf('Entropy: %.4f\n', entropyValue);
