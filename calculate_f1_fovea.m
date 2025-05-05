threshold = 100;

predicted = readtable('fovea_coordinates.csv', 'ReadVariableNames', true, 'VariableNamingRule', 'preserve');
predicted = predicted(:, 1:3);  
predicted.Properties.VariableNames = {'Image', 'X_pred', 'Y_pred'};

gt = readtable('IDRiD_Fovea_Center_Testing Set_Markups.csv', 'ReadVariableNames', true, 'VariableNamingRule', 'preserve');
gt.Properties.VariableNames = {'Image', 'X_gt', 'Y_gt'};

[common_names, idx_pred, idx_gt] = intersect(predicted.Image, gt.Image);

TP = 0; FP = 0; FN = 0;

for i = 1:length(common_names)
    x1 = predicted.X_pred(idx_pred(i));
    y1 = predicted.Y_pred(idx_pred(i));
    x2 = gt.X_gt(idx_gt(i));
    y2 = gt.Y_gt(idx_gt(i));

    if isnan(x1) || isnan(y1)
        FN = FN + 1;
        continue;
    end

    dist = sqrt((x1 - x2)^2 + (y1 - y2)^2);
    if dist <= threshold
        TP = TP + 1;
    else
        FP = FP + 1;
    end
end

total_gt = size(gt, 1);  
FN = FN + (total_gt - length(idx_gt));

precision = TP / (TP + FP);
recall = TP / (TP + FN);
F1 = 2 * (precision * recall) / (precision + recall);

fprintf('Fovea Localization Metrics (Threshold: %d pixels)\n', threshold);
fprintf('True Positives: %d\nFalse Positives: %d\nFalse Negatives: %d\n', TP, FP, FN);
fprintf('Precision: %.2f\nRecall: %.2f\nF1-Score: %.2f\n', precision, recall, F1);
