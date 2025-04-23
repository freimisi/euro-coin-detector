%% Process a Single Image

function cleaned_mask = process_image(I)
    % Function to process a single image and classify coins
    % Inputs:
    % - I: Input image
    % Outputs:
    % - cleaned_mask: Final cleaned mask
    % - coin_counts: Detected coin counts

    % Convert to gray-scale and HSV
    % gray_image = rgb2gray(I);
    hsv_image = rgb2hsv(I);

    S = hsv_image(:, :, 2);  % Extract saturation channel
    V = hsv_image(:, :, 3);  % Extract value channel

    % Normalize brightness in the Value channel
    V_eq = adapthisteq(V);                 % Adaptive histogram equalization for contrast enhancement
    hsv_mask = (S > 0.1) & (V_eq > 0.35);  % Adaptive thresholding in HSV

    % Edge detection on enhanced gray-scale
    gray_enhanced = adapthisteq(rgb2gray(I));
    edges = edge(gray_enhanced, 'Canny');

    % Combine HSV mask and edges
    combined_mask = hsv_mask & edges;

    % Morphological operations to clean the mask
    se = strel('disk', 8);
    cleaned_mask = imclose(combined_mask, se);     % Close small gaps
    cleaned_mask = imfill(cleaned_mask, 'holes');  % Fill holes
    cleaned_mask = bwareaopen(cleaned_mask, 500);  % Remove small objects

    % Label and analyze regions for circularity
    labeledImage = bwlabel(cleaned_mask);
    props = regionprops(labeledImage, 'Area', 'Perimeter', 'Eccentricity');

    % Initialize mask for coins
    coin_mask = false(size(cleaned_mask));

    % Filter regions based on circularity and eccentricity
    for k = 1:length(props)
        area = props(k).Area;
        perimeter = props(k).Perimeter;
        eccentricity = props(k).Eccentricity;

        % Calculate circularity
        circularity = 4 * pi * area / (perimeter^2);

        % Coins: High circularity and low eccentricity
        if circularity > 0.01 && eccentricity < 0.5
            coin_mask = coin_mask | (labeledImage == k);
        end
    end

    cleaned_mask = imfill(coin_mask, "holes");
end
