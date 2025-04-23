function coins = estim_coins(measurement, bias, dark, flat)
    % Function to estimate the number and type of coins in an image
    %
    % Inputs:
    % - measurement: Input image of coins
    % - bias: Average ias image (UNUSED)
    % - dark: Average dark image (UNUSED)
    % - flat: Average flat field image
    %
    % Output:
    % - coins: Estimated number and type of coins in the image
    %
    % Example: [1, 1, 1, 1, 1, 1]
    % 1 coin of each type (5c, 10c, 20c, 50c, 1 Euro, 2 Euro)
    %
    % Usage:
    % [coins] = estim_coins(measurement, 'bias', 'dark', flat);

    cleaned_mask = process_image(measurement);  % get image mask, showing the coins only
    pixel_to_mm = calibrate_pixel_to_mm(flat, 12.5);
    props_coin = regionprops(bwlabel(cleaned_mask), 'EquivDiameter');

    % Classify coins based on region properties
    coin_counts = classify_coins(props_coin, pixel_to_mm);

    coins = coin_counts;
    coins = flip(coins);
end
