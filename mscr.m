% Define the MSRCR function
function output = msrcr(input_image, alpha, beta, gamma)
% Set filter parameters
eps = 1e-3;

% Convert the input image to logarithmic scale
log_image = log(1 + input_image);

% Calculate the mean luminance and chromaticity
mean_luminance = exp(mean(mean(log_image)));
chromaticity = log_image - log(mean_luminance);

% Perform multi-scale decomposition
luminance_pyramid = generate_pyramid(mean_luminance, alpha, gamma);
chromaticity_pyramid = generate_pyramid(chromaticity, beta, gamma);

% Apply retinex algorithm to each level of the pyramid
retinex_pyramid = cell(size(luminance_pyramid));
for level = 1:length(luminance_pyramid)
    luminance_level = luminance_pyramid{level};
    chromaticity_level = chromaticity_pyramid{level};
    mu = mean2(luminance_level);
    sigma = std2(luminance_level);
    sigma = max(sigma, eps);
    chromaticity_level = chromaticity_level * (mu / sigma);
    retinex_pyramid{level} = chromaticity_level;
end

% Combine the retinex outputs to form the final output
retinex_output = retinex_pyramid{end};
for level = length(retinex_pyramid)-1:-1:1
    retinex_output = imresize(retinex_output, size(retinex_pyramid{level}), 'bilinear');
    retinex_output = retinex_output + retinex_pyramid{level};
end
output = exp(retinex_output) - 1;
end

% Define the function to generate the Gaussian pyramid
function pyramid = generate_pyramid(image, beta, gamma)
pyramid = {};
while min(size(image)) >= 16
    pyramid{end+1} = image;
    image = imresize(image, gamma, 'bilinear');
    image = conv2(image, fspecial('Gaussian', [1, max(3, floor(beta * size(image, 2)))], beta), 'same');
    image = conv2(image, fspecial('Gaussian', [max(3, floor(beta * size(image, 1))), 1], beta), 'same');
end
end
