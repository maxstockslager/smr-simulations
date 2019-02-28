function peak_list = peak_params_to_peak_list(peak_params)

peak_list = format_like_measured_data(get_peak_signal(peak_params(1)), peak_params(1).datarate);

for ii = 1:numel(peak_params)
    current_peak = get_peak_signal(peak_params(ii));
    
    [dim1, dim2] = size(current_peak.filt_signal_downsampled);
    current_peak.filt_signal_downsampled = ... # add white noise
        current_peak.filt_signal_downsampled + ...
        normrnd(0, peak_params(ii).noise_sd, dim1, dim2);
    formatted_peak = format_like_measured_data(current_peak, peak_params(ii).datarate);
    peak_list(ii) = formatted_peak;
end
