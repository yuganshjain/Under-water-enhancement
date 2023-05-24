% Read the underwater image
image = imread('wav.jpg');

% Convert the image to double precision
image = im2double(image);

% Calculate the RG and YB color components
RG = image(:,:,1) - image(:,:,2);
YB = (image(:,:,1) + image(:,:,2)) / 2 - image(:,:,3);

% Flatten the color components into a 1D array
RG = RG(:);
YB = YB(:);

% Sort the color component values
sortedRG = sort(RG);
sortedYB = sort(YB);

% Define the trimming percentage
alphaL = 0.05; % Trimming percentage for lower values
alphaR = 0.05; % Trimming percentage for higher values

% Calculate the number of values to be trimmed
N = numel(RG);
TL = floor(alphaL * N);
TR = floor(alphaR * N);

% Trim the color component values
trimmedRG = sortedRG(TL+1 : end-TR);
trimmedYB = sortedYB(TL+1 : end-TR);

% Calculate the mean and variance of the trimmed color components
meanRG = mean(trimmedRG);
varRG = var(trimmedRG);
meanYB = mean(trimmedYB);
varYB = var(trimmedYB);
% Calculate the UICM score
UICM = -0.0268 * sqrt(meanRG^2) + sqrt(meanYB^2) + 0.1586 * sqrt(varRG^2) + sqrt(varYB^2);

% Display the UICM results
disp(['UICM - RG Mean: ' num2str(meanRG)]);
disp(['UICM - RG Variance: ' num2str(varRG)]);
disp(['UICM - YB Mean: ' num2str(meanYB)]);
disp(['UICM - YB Variance: ' num2str(varYB)]);
disp(['UICM : ' num2str(UICM)]);
