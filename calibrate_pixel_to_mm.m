%% Geometric Calibration

function pixel_to_mm = calibrate_pixel_to_mm(image, square_size_mm)
    % Function to compute pixel-to-millimeter calibration factor using a checkerboard pattern
    % Inputs:
    % - image: loaded image of the checkerboard
    % - square_size_mm: Size of one square on the checkerboard (in mm)
    % Output:
    % - pixel_to_mm: Conversion factor (pixels per mm)

    [img_points, ~] = detectCheckerboardPoints(image);

    if isempty(img_points)
        error('No checkerboard detected in the image.');
    end

    % Calculate distances between adjacent corners in pixels
    dx = diff(img_points(:, 1));       % Horizontal distances
    dy = diff(img_points(:, 2));       % Vertical distances
    pixel_dist = sqrt(dx.^2 + dy.^2);  % Euclidean distances

    pixel_dist_mode = mode(pixel_dist);              % get most occurring pixel distance between adjacent squares
    pixel_to_mm = square_size_mm / pixel_dist_mode;  % calculate the pixel-to-millimeter conversion factor
end
