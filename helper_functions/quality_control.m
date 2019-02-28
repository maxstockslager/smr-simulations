function [results_filt, accepted_peak_numbers, qc_settings] = quality_control(results, qc_settings)

qc_settings.vert_optim_score_threshold = mean(results.vert_optim_score) + ...
            qc_settings.vert_optim_score_reject_sd * ...
            sd_trimmed(results.vert_optim_score, qc_settings.sd_outlier_percent);
qc_settings.horiz_optim_score_threshold = mean(results.horiz_optim_score) + ...
            qc_settings.horiz_optim_score_reject_sd * ...
            sd_trimmed(results.horiz_optim_score, qc_settings.sd_outlier_percent);

approved_mask = (results.vert_optim_score < qc_settings.vert_optim_score_threshold) & ...
                              (results.horiz_optim_score < qc_settings.horiz_optim_score_threshold);
results_filt = struct(); % initialize
names = fieldnames(results);
for field_number = 1 : numel(names)
    field_name = names{field_number};
    field_vector = results.(field_name);
    results_filt.(field_name) = field_vector(approved_mask);
end
accepted_peak_numbers = find(approved_mask);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function sd_trimmed = sd_trimmed(x, percent)
% calculates standard deviation of x, excluding the top and bottom (percent) values
pointsToRemove = round(numel(x) * percent/100);
x = sort(x);
x(1:pointsToRemove) = [];
x( (end-pointsToRemove+1) : end) = []; 
sd_trimmed = std(x);
end
