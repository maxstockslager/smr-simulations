function peak_fit = run_optimization(current_peak, optim_params, library, transit_time_digits)

[peak_fit.transit_time, peak_fit.delay, ...
    peak_fit.horiz_optim_score] = optimize_horizontal_fit(current_peak.signal_norm, ...
        current_peak.time_vector_from_zero, library, transit_time_digits, optim_params);

[peak_fit.amplitude, peak_fit.vert_optim_score] = ...
        optimize_vertical_fit(current_peak.signal, ...
        current_peak.time_vector_from_zero, library, ...
        peak_fit.transit_time, peak_fit.delay, ...
        optim_params);      

[~, best_peak_fit_idx] = min(abs(library.transit_times - peak_fit.transit_time));
best_peak_attenuation = library.attenuation(best_peak_fit_idx);
peak_fit.height= peak_fit.amplitude / best_peak_attenuation; 
peak_fit.attenuation = best_peak_attenuation; 


end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function objective_function = calc_objective_function(measured_peak, measured_times, library, ...
    eval_transit_time, eval_amplitude, eval_delay, generate_plots)
    % evaluates the objective function for this cell at the specified
    % transit time and peak amplitude

[~, library_peak_index] = min(abs(library.transit_times - eval_transit_time));
library_peak_shape_normalized = library.peak_shapes(:, library_peak_index); % closest match  
library_time_per_sample = library.time_per_sample(library_peak_index);
library_time_vector = (0:(length(library_peak_shape_normalized)-1)) * library_time_per_sample;


% shift and rescale according to the optimization parameters
library_peak_shape_scaled = library_peak_shape_normalized * eval_amplitude;
measured_peak_time_vector_shifted = transpose(measured_times) - eval_delay; % eval_delay is in time units 
library_peak_shape_evaluated = interp1(library_time_vector, ...
    library_peak_shape_scaled, measured_peak_time_vector_shifted);
library_peak_shape_evaluated(isnan(library_peak_shape_evaluated)) = 0; 

% calculate objective function penalizing error 
deviation = measured_peak - library_peak_shape_evaluated; 
objective_function = sum(deviation .* deviation);

% if generate_plots
%     plot(library_time_vector, library_peak_shape_scaled, 'k');
%     hold on
%     plot(measured_peak_time_vector_shifted, library_peak_shape_evaluated, 'ko');
%     plot(measured_peak_time_vector_shifted, measured_peak, 'ro');
% end

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [best_transit_time, best_delay, horiz_optim_score] = optimize_horizontal_fit(normalized_peak, ...
    measured_times, library, transit_time_digits, optim_params)
 
obj_fun = @(fun_params) calc_objective_function(normalized_peak, measured_times, library, ...
     fun_params(1), 1, fun_params(2), false);
% options = gaoptimset('Display', 'iter'); % set this up once and leave it 
options = gaoptimset('Display', 'none');
lower_bounds = [optim_params.min_transit_time, optim_params.min_delay];
upper_bounds = [optim_params.max_transit_time, optim_params.max_delay];
[optimal_fit, optimal_obj_function, ~, ga_output] = ga(obj_fun, 2, [], [], [], [], lower_bounds, ...
      upper_bounds, [], options);

best_transit_time = round(optimal_fit(1), transit_time_digits);
best_delay = optimal_fit(2);
horiz_optim_score = optimal_obj_function; 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [best_amplitude, vert_optim_score] = optimize_vertical_fit(measured_peak, measured_times, library, best_transit_time, ...
    best_delay, optim_params)
obj_fun = @(fun_param) calc_objective_function(measured_peak, measured_times, ...
    library, best_transit_time, fun_param, best_delay, false); 
options = optimoptions('fmincon');
options.Display = 'off';
[best_amplitude, vert_optim_score] = fmincon(obj_fun, optim_params.amplitude_guess, ...
    [], [], [], [], optim_params.min_amplitude, optim_params.max_amplitude, [], options);
end

