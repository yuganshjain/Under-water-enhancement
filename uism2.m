% Read the underwater image
image = imread('1.jpg');

% Convert the image to double precision
image = im2double(image);

% Apply Sobel operator on each color component to generate edge maps
edgeR = edge(image(:,:,1), 'Sobel');
edgeG = edge(image(:,:,2), 'Sobel');
edgeB = edge(image(:,:,3), 'Sobel');

% Calculate grayscale edge maps by multiplying edge maps with original color components
grayEdgeR = edgeR .* image(:,:,1);
grayEdgeG = edgeG .* image(:,:,2);
grayEdgeB = edgeB .* image(:,:,3);

% Divide the image into m x n blocks
m = 8; % Number of rows in blocks
n = 8; % Number of columns in blocks
[rows, cols, ~] = size(image);
numBlocksRow = floor(rows / m);
numBlocksCol = floor(cols / n);

% Initialize UISM
UISM = 0;

% Weight coefficients for color channels
lambdaR = 0.299;
lambdaG = 0.587;
lambdaB = 0.114;

% Calculate UISM
for row = 1:numBlocksRow
    for col = 1:numBlocksCol
        % Get the block indices
        rowIndex = (row-1)*m + 1 : row*m;
        colIndex = (col-1)*n + 1 : col*n;
        
        % Calculate maximal and minimal pixel values in each block
        maxR = max(max(image(rowIndex, colIndex, 1)));
        minR = min(min(image(rowIndex, colIndex, 1)));
        
        maxG = max(max(image(rowIndex, colIndex, 2)));
        minG = min(min(image(rowIndex, colIndex, 2)));
        
        maxB = max(max(image(rowIndex, colIndex, 3)));
        minB = min(min(image(rowIndex, colIndex, 3)));
        
        % Add a small constant value to avoid division by zero
        epsilon = 1e-10;
        minR = minR + epsilon;
        minG = minG + epsilon;
        minB = minB + epsilon;
        
        % Calculate EME for each color channel
        EME_R = log(maxR / minR);
        EME_G = log(maxG / minG);
        EME_B = log(maxB / minB);
        
        % Calculate UISM for each color channel
        UISM = UISM + lambdaR * EME_R + lambdaG * EME_G + lambdaB * EME_B;
    end
end

% Normalize UISM by the number of blocks
totalBlocks = numBlocksRow * numBlocksCol;
UISM = UISM / (2 * totalBlocks);

% Display UISM
disp(['UISM Score: ' num2str(UISM)]);
