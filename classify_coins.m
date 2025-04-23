%% classifying coins

function coin_counts = classify_coins(regionprops, pixel_to_mm)
    % Function to classify coins based on region properties and pixel-to-mm conversion
    % Inputs:
    % - regionprops: Region properties of detected coins
    % - pixel_to_mm: Pixel-to-mm conversion factor
    % Outputs:
    % - coin_counts: Counts of each coin type

    % diameters (mm)  2e,    1e,    50c,   20c,   10c,   5c
    coin_diameters = [25.75, 23.25, 24.25, 22.25, 19.75, 21.25];
    coin_counts = zeros(1, length(coin_diameters));

    for k = 1:length(regionprops)
        measured_diameters_mm = regionprops(k).EquivDiameter * pixel_to_mm;  % Measure diameter in mm
        [~, idx] = min(abs(coin_diameters - measured_diameters_mm));         % Find closest match in known diameters
        coin_counts(idx) = coin_counts(idx) + 1;                             % Increment count
    end
end
