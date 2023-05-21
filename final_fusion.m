% Read in the input image
input_image = imread('1.jpg');

% Step 1: Homomorphic filtering and MSRCR
% Convert the image to double precision and normalize to [0, 1]
input_image = im2double(input_image);
input_image = (input_image - min(input_image(:))) / (max(input_image(:)) - min(input_image(:)));

% Apply homomorphic filtering
high_pass = homomorphic_filter(input_image);

% Perform multi-scale retinex with color restoration (MSRCR)
if any(size(high_pass) < 64)
    retinex_output = high_pass;
else
    retinex_pyramid = msrcr(high_pass, 3, 3, 3);
    retinex_output = cat(3, retinex_pyramid{:});
end

% Fuse MSRCR output with original RGB channel
fused_image = zeros(size(input_image));
for channel = 1:3
    fused_image(:, :, channel) = imfuse(input_image(:, :, channel), retinex_output(:, :, channel), 'blend', 'Scaling', 'joint');
end

% Step 2: Calculate the weight coefficients
% Calculate the dark channel prior of the fused image
dark_channel = get_dark_channel(fused_image, 31);
wDCP = exp(-(dark_channel .^ 2));

% Calculate the weight coefficients for the second fusion step
wDCP_other = exp(-(get_dark_channel(input_image, 31) .^ 2));
wDCP_another = exp(-(get_dark_channel(retinex_output, 31) .^ 2));
Wi = 1 - (wDCP .* wDCP_other) ./ (wDCP .^ 2 + wDCP_other .^ 2 - wDCP .* wDCP_other) + (wDCP .* wDCP_another) ./ (wDCP .^ 2 + wDCP_another .^ 2 - wDCP .* wDCP_another);

% Step 3: Perform the second fusion step
% Apply contrast limited adaptive histogram equalization (CLAHE) to the input image
input_clahe = zeros(size(input_image));
for channel = 1:3
    input_clahe(:, :, channel) = adapthisteq(input_image(:, :, channel), 'NumTiles', [16, 16], 'ClipLimit', 0.02);
end

% Perform the second fusion step
fused_output = zeros(size(input_image));
for channel = 1:3
    fused_output(:, :, channel) = (wDCP .* input_clahe(:, :, channel)) + (Wi .* retinex_output(:, :, channel));
end

% Normalize the output image to [0, 1] and convert to uint8
fused_output = (fused_output - min(fused_output(:))) / (max(fused_output(:)) - min(fused_output(:)));
fused_output = im2uint8(fused_output);

% Display the input and fused images side by side
figure;
subplot(1, 2, 1);
imshow(input_image);
title('Input Image');
subplot(1, 2, 2);
imshow(fused_output);
title('Fused Image');
