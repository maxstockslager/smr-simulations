function peak_fits = deblur_peaks(peak_list, library, optim_settings, use_parfor)
n_peaks = numel(peak_list);
peak_fits(n_peaks) = struct(...
    'amplitude', [], ...
    'transit_time', [], ...
    'delay', [], ...
    'attenuation', [], ...
    'height', [], ...
    'vert_optim_score', [], ...
    'horiz_optim_score', [] ...
); 

sim_start_time = tic;

if use_parfor == true
    fprintf('Opening parallel pool...\n');

    parfor (peak_number = 1 : n_peaks, inf)
        peak_start_time = tic;

        current_peak = peak_list(peak_number);
        optim_params = get_optim_params(current_peak, optim_settings);
        peak_fit = run_optimization(current_peak, optim_params, library, optim_settings.transit_time_digits);

        peak_fits(peak_number) = peak_fit;
        fprintf('Processed peak %.0f/%.0f in %.1f sec. Total elapsed time %.0f sec (%.1f min).\n', peak_number, ...
           n_peaks, toc(peak_start_time), toc(sim_start_time), toc(sim_start_time)/60)

    end
    
elseif use_parfor == false
    for peak_number = 1 : n_peaks

        peak_start_time = tic;

        current_peak = peak_list(peak_number);
        optim_params = get_optim_params(peak_list(peak_number), optim_settings);
        peak_fit = run_optimization(current_peak, optim_params, library, optim_settings.transit_time_digits);

        peak_fits(peak_number) = peak_fit;
        fprintf('Processed peak %.0f/%.0f in %.1f sec. Total elapsed time %.0f sec (%.1f min).\n', peak_number, ...
           n_peaks, toc(peak_start_time), toc(sim_start_time), toc(sim_start_time)/60)

    end
end
end