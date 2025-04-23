function [accuracy, correct_preds, wrong_preds] = compute_accuracy(detected_counts, true_counts)
    % Function to compute the accuracy of coin count predictions
    % Inputs:
    % - detected_counts: Array of detected coin counts
    % - true_counts: Array of true coin counts
    % Outputs:
    % - accuracy: Percentage accuracy of the predictions
    % - correct_preds: Number of correct predictions
    % - wrong_preds: Number of wrong predictions

    % Compute correct and wrong predictions
    correct_preds = 0;
    total_coins = 0;
    for j = 1:length(detected_counts)
        % Check if the predicted count matches the true count for each coin type
        total_coins = total_coins + true_counts(j);
        if detected_counts(j) ~= 0
            if detected_counts(j) == true_counts(j)
                correct_preds = correct_preds + detected_counts(j);
            else

                if true_counts(j) > detected_counts(j)
                    correct_preds = correct_preds + detected_counts(j);

                else
                    correct_preds = correct_preds +  + detected_counts(j) -  abs(detected_counts(j) - true_counts(j));
                end
            end
        end
    end

    wrong_preds = total_coins - correct_preds;
    total_preds = correct_preds + wrong_preds;
    accuracy = (correct_preds / total_preds) * 100;
end
