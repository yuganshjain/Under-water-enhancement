% Read the underwater image
image = imread('1.jpg');

% Convert the image to double precision
image = im2double(image);

% Extract the color channels (R, G, B)
R = image(:,:,1);
G = image(:,:,2);
B = image(:,:,3);

% Calculate the RG and YB color components
RG = R - G;
YB = (R + G) / 2 - B;

% Flatten the color components into a 1D array
RG = RG(:);
YB = YB(:);

% Calculate the mean and variance of the color components
meanRG = mean(RG);
varRG = var(RG);
meanYB = mean(YB);
varYB = var(YB);

% Calculate the UICM score
UICM = -0.0268 * sqrt(meanRG^2 + meanYB^2) + 0.1586 * sqrt(varRG^2 + varYB^2);


% Display the UICM results
disp(['UICM - RG Mean: ' num2str(meanRG)]);
disp(['UICM - RG Variance: ' num2str(varRG)]);
disp(['UICM - YB Mean: ' num2str(meanYB)]);
disp(['UICM - YB Variance: ' num2str(varYB)]);
disp(['UICM : ' num2str(UICM)]);
