% Define the homomorphic filter function
function high_pass = homomorphic_filter(input_image)
% Set filter parameters
cutoff_freq = 10;
sigma = 10;

% Convert the input image to logarithmic scale
log_image = log(1 + input_image);

% Perform Fourier transform
ft_image = fft2(log_image);

% Define filter function
[x, y] = meshgrid(1:size(input_image, 2), 1:size(input_image, 1));
center_x = floor(size(x, 2) / 2) + 1;
center_y = floor(size(y, 1) / 2) + 1;
dist_matrix = sqrt((x - center_x) .^ 2 + (y - center_y) .^ 2);
filter = 1 - exp(-(dist_matrix .^ 2) / (2 * sigma ^ 2));
filter(dist_matrix <= cutoff_freq) = 1;

% Apply filter to Fourier image
filtered_image = ft_image .* filter;

% Perform inverse Fourier transform
high_pass = real(ifft2(filtered_image));
end
