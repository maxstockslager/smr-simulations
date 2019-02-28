function peak_params = sim_params_to_peak_params(sim_params)

for peak_number = 1:numel(sim_params.transit_time_vector)
    
    peak_params(peak_number) = struct(...
        'datarate', sim_params.datarate, ...
        'transit_time', sim_params.transit_time_vector(peak_number), ...
        'noise_sd', sim_params.noise_sd, ...
        'true_height', sim_params.true_height, ...
        'bandwidth', sim_params.bandwidth, ...
        'order', sim_params.order, ...
        'channel_length', sim_params.channel_length, ...
        'mode', sim_params.mode);
    
end

peak_params = repelem(peak_params, sim_params.n_replicates);