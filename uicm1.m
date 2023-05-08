im = imread('underwater_fish.JPG');
uicm_score = calculate_uicm(im);
disp(uicm_score);

function uicm_score = calculate_uicm(im)
% convert the input image to double precision
im = im2double(im);

% extract the color channels
R = im(:,:,1);
G = im(:,:,2);
B = im(:,:,3);

% calculate the Red-Green (RG) and Yellow-Blue (YB) color components
RG = R - G;
YB = (R + G) / 2 - B;

% sort the pixels in the RG component and discard the smallest and largest alpha percentiles
alpha = 0.05; % change this parameter to adjust the alpha percentiles
num_pixels = numel(RG);
sorted_RG = sort(RG(:));
num_discard = round(alpha * num_pixels);
RG_trimmed = sorted_RG(num_discard+1:end-num_discard);

% calculate the first-order statistic mean value for the RG component
mean_RG = mean(RG_trimmed(:));

% calculate the variance for the RG component
var_RG = var(RG_trimmed(:));

% calculate the UICM score
uicm_score = var_RG - abs(mean_RG);

end
