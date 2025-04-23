% Ground truth data for coin counts
ground_truth = struct( ...
    'DSC1772', [1, 1, 1, 1, 1, 1], ...
    'DSC1773', [3, 1, 0, 1, 0, 0], ...
    'DSC1774', [1, 0, 0, 5, 1, 1], ...
    'DSC1775', [0, 0, 0, 3, 1, 3], ...
    'DSC1776', [0, 1, 0, 4, 1, 3], ...
    'DSC1777', [0, 3, 0, 1, 0, 2], ...
    'DSC1778', [0, 1, 0, 3, 0, 0], ...
    'DSC1779', [0, 0, 1, 4, 0, 3], ...
    'DSC1780', [0, 0, 0, 0, 1, 3], ...
    'DSC1781', [0, 0, 1, 4, 0, 0], ...
    'DSC1782', [0, 3, 1, 5, 0, 0], ...
    'DSC1783', [0, 3, 1, 1, 0, 0] ...
);

flat = imread('img/Flat/_DSC1767.JPG');
process_measurements('img/Measurements_/', ground_truth, flat)


%% Main Function to Process Measurements
function process_measurements(directory, ground_truth, flat)
    % Function to process images in the given directory, estimate the number
    % and type of coins on it and compare the results with ground truth
    % Inputs:
    % - directory: Path to the folder containing images to process
    % - ground_truth: Struct containing ground truth counts for each image
    % - flat: Flat field image for calibration

    img_files = dir(fullfile(directory, '*.jpg'));  % list all image files in directory
    accuracies = [];

    for i = 1:length(img_files)
        filePath = fullfile(directory, img_files(i).name);
        I = imread(filePath);

        detected_counts = estim_coins(I, 'bias', 'dark', flat);
        detected_counts = flip(detected_counts);

        % Extract the ground truth for the current image
        img_name = erase(img_files(i).name, {'.jpg', '.JPG'});
        img_name = strrep(img_name, '_', '');
        if isfield(ground_truth, img_name)
            true_counts = ground_truth.(img_name);
        else
            warning(['Ground truth for ', img_name, ' not found. Skipping comparison.']);
            continue;
        end

        % accuracy of predictions
        [accuracy, correct_preds, wrong_preds] = compute_accuracy(detected_counts, true_counts);
        accuracies(i) = accuracy;

        disp( ...
            [newline, newline, '-----------------------------------------', newline, ...
            'Results for ', img_files(i).name, ':'] ...
        );
        disp('Detected Counts:'); disp(detected_counts);
        disp('Ground Truth:');
        disp(array2table(true_counts, 'VariableNames', {'2e', '1e', '50c', '20c', '10c', '5c'}));
        fprintf('Correct Predictions: %d\n', correct_preds);
        fprintf('Wrong Predictions: %d\n', wrong_preds);
        fprintf('Accuracy for this image: %.2f%%\n', accuracy);
    end

    meanAccuracy = mean(accuracies);
    fprintf('%%\nMean accuracy across all images: %.2f%%\n', meanAccuracy);
end
