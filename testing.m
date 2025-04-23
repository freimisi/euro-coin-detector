%% testing

measurement = imread('img/Measurements/_DSC1776.JPG');
flat = imread('img/Flat/_DSC1767.JPG');
I = measurement;

ground_truth = [0 1 0 4 1 3];  % €2 to 5c
[coins] = estim_coins(measurement, 'bias', 'dark', flat);
disp('Estimated Coins:');
disp(flip(coins));  % €2 to 5c
disp('Ground Truth:');
disp(ground_truth);

[accuracy, correct_preds, wrong_preds] = compute_accuracy(flip(coins), ground_truth);
disp(['Accuracy: ', num2str(accuracy), '%']);
