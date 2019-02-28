function exportPeakShapes

clear all, close all

outputFilename = 'peakshapes 200Hzbw order2 0.95length 0.1 - 0.1 - 200ms';
transitTimeVector = [0.1 : 0.1 : 1000]/1000;

% adjustable settings
peakSettings.startTime = 0/1000; % unused but leaving for now 
peakSettings.trueHeight = 1; % Hz
peakSettings.nReplicates = 1; 
peakSettings.bandwidth = 200; % peaks are measured by a PLL w/ this bw
peakSettings.channelLength = 0.95; 
peakSettings.mode = 2; 
peakSettings.datarate = 4000; % NOT ACTUALLY USED 
 
samplesPerPeak = 1000; % export this number of data points per peak shape 


outputArray = zeros(samplesPerPeak, numel(transitTimeVector));
attenuationArray = zeros(1, numel(transitTimeVector));
sampleTimeArray = zeros(1, numel(transitTimeVector));
for ii = 1 : numel(transitTimeVector)
    fprintf('Processing peak %.0f/%.0f\n', ii, numel(transitTimeVector));
    
    peakSettings.transitTime = transitTimeVector(ii);
    peakSignals = getPeakSignals(peakSettings);
    
    timeVector = peakSignals.time_full;
    filtSignal = peakSignals.filtSignal_full; 
    
    
    % crop signal so the peak shape begins at zero
    zeroThresholdValue = 0.001*max(abs(filtSignal)); % values less than this considered baseline
    ind1 = min(find(abs(filtSignal) > zeroThresholdValue));
    ind2 = max(find(abs(filtSignal) > zeroThresholdValue));
    
    filtSignal = filtSignal(ind1:ind2);
    timeVector = timeVector(ind1:ind2);

    attenuation = max(abs(filtSignal)); % positive
    filtSignal_normalized = filtSignal ./ attenuation; 
    filtSignal_resampled = interp1(1:numel(filtSignal_normalized), ...
        filtSignal_normalized, linspace(1, numel(filtSignal_normalized), samplesPerPeak));
    sampleTime = (max(timeVector)-min(timeVector))/(length(filtSignal_resampled)-1);
    
    
    % resample to fixed length defined by samplesPerPeak(e.g. 1000)
    outputArray(:, ii) = filtSignal_resampled;
    attenuationArray(:, ii) = attenuation; 
    sampleTimeArray(:, ii) = sampleTime;
end

% add the transit times in the first row of outputArray
outputArray = [transitTimeVector; attenuationArray; ...
    sampleTimeArray; outputArray];

% export peak shapes, and export other data as a txt file
csvwrite(strcat(outputFilename, '.csv'), outputArray);
fid = fopen(strcat(outputFilename, '_settings.txt'), 'wt');

fprintf(fid, 'bandwidth: %.0f rad/s (%.0f Hz)\n', peakSettings.bandwidth, ...
    peakSettings.bandwidth/(2*pi));
fprintf(fid, 'mode number: %.0f\n', peakSettings.mode);
fprintf(fid, 'max channel length: %.3f\n', peakSettings.channelLength);
fprintf(fid, 'samples per peak: %.0f\n', samplesPerPeak);
fprintf(fid, 'range of transit times: %.4f - %.4f sec\n', min(transitTimeVector), max(transitTimeVector));
fprintf(fid, 'transit time step size: %.4f sec\n', transitTimeVector(2) - transitTimeVector(1));

fclose(fid);
end