function optim_params = get_optim_params(current_peak_data, optim_settings)

% Transit time 
optim_params.min_transit_time = current_peak_data.time_length * (1 - optim_settings.transit_time_search_factor);
optim_params.max_transit_time = current_peak_data.time_length * (1 + optim_settings.transit_time_search_factor);

% Delay 
delay_search_time = current_peak_data.time_length * optim_settings.delay_search_factor; % time to search either way
optim_params.min_delay = current_peak_data.time_to_pad - delay_search_time; 
optim_params.max_delay =  current_peak_data.time_to_pad + delay_search_time; 

if optim_params.min_delay < 0
    optim_params.min_delay = 0; 
end
if optim_params.max_delay > current_peak_data.padded_time_duration 
    optim_params.max_delay = current_peak_data.padded_time_duration; 
end

% Amplitude
optim_params.min_amplitude = current_peak_data.rough_amplitude*optim_settings.peak_amplitude_lower_bound;
optim_params.max_amplitude = current_peak_data.rough_amplitude*optim_settings.peak_amplitude_upper_bound; 
optim_params.amplitude_guess = current_peak_data.rough_amplitude; 
end
