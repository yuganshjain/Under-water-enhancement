% Read the underwater image
image = imread('colorcorrected.jpg');

% Convert the image to grayscale
gray_image = rgb2gray(image);

% Calculate the gradient magnitude using the Sobel operator
gradient_magnitude = sqrt(double(edge(gray_image, 'sobel')).^2);

% Calculate the local contrast measure using the Laplacian operator
laplacian_response = abs(double(edge(gray_image, 'log')));

% Compute the UISM score
uisms = gradient_magnitude .* laplacian_response;

% Calculate the average UISM score
average_uism = mean(uisms(:));

% Display the UISM score
disp(['UISM Score: ', num2str(average_uism)]);
