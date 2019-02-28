function [library, transit_time_digits] = read_peak_library(peak_library_file)

    peak_library_filename = peak_library_file;
    raw = csvread(peak_library_filename);
    library.transit_times = raw(1, :);
    library.attenuation = raw(2, :); 
    library.time_per_sample = raw(3, :);
    library.peak_shapes = raw(4:end, :); 
    transit_time_digits = round(-log10(library.transit_times(2) - library.transit_times(1)));

end