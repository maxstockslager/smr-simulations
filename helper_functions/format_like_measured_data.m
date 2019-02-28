function formatted_peak = format_like_measured_data(peak_signals, datarate)
    
sampled_signal = peak_signals.filt_signal_downsampled; % used for convenience

    formatted_peak.start_index = round(1/3 * length(sampled_signal)); % start index of peak (relative to whole signal)
    formatted_peak.end_index = round(2/3 * length(sampled_signal)); % end index of peak (relative to whole signal)
    formatted_peak.indices_length = formatted_peak.end_index - formatted_peak.start_index; % peak duration (indices)
    formatted_peak.start_time = formatted_peak.start_index / datarate; % start time of peak (relative to whole signal)
    formatted_peak.end_time = formatted_peak.end_index / datarate;  % end time of peak (relative to whole signal)
    formatted_peak.time_length = formatted_peak.indices_length / datarate; % peak duration (sec)
    formatted_peak.indices_to_pad = formatted_peak.start_index; % hack
    formatted_peak.time_to_pad = formatted_peak.indices_to_pad / datarate; 
    formatted_peak.padded_start_index = formatted_peak.start_index - formatted_peak.indices_to_pad; % start time of padded region (relative to signal)
    formatted_peak.padded_end_index = formatted_peak.end_index; % end time of padded region (relative to signal)
    formatted_peak.padded_indices_duration = formatted_peak.padded_end_index - formatted_peak.padded_start_index; % duration in indices
    formatted_peak.padded_time_duration = formatted_peak.padded_indices_duration / datarate; % duration in sec
    formatted_peak.signal = sampled_signal(:);
    formatted_peak.rough_amplitude = max(abs(formatted_peak.signal));
    formatted_peak.signal_norm = formatted_peak.signal/formatted_peak.rough_amplitude; 
    formatted_peak.cell_time = formatted_peak.padded_start_index / datarate; 
    formatted_peak.time_vector_from_zero = peak_signals.time_downsampled; 
    
end