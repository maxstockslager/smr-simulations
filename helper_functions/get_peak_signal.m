function peak_shape = get_peak_signal(peak_params)


filter_settings.bandwidth = peak_params.bandwidth*2*pi; 
filter_settings.type = 'butterworth';
filter_settings.loopOrder = peak_params.order; 

transit_time = peak_params.transit_time;
peak_height = peak_params.true_height; 
channel_length = peak_params.channel_length; 
datarate = peak_params.datarate; 
n = peak_params.mode; 


% get the mode shape and peak shape 
[u, ~] = get_mode_shape(n, channel_length);
df = get_peak_shape(u);
df = df * peak_height; 

dt = peak_params.transit_time/length(df); % still correct after change
timeToPadZeros = max([4*1/filter_settings.bandwidth, peak_params.transit_time]); % sec 
zerosToPad = ceil(timeToPadZeros/dt); 
% zerosToPad = round(max([length(df), length(df)/(filter_settings.bandwidth*peakSettings.transit_time)]));

df_padded = [zeros(1, zerosToPad), df, zeros(1, zerosToPad)]; 




[timeVector, dt] = getTimeVector(transit_time, numel(df), numel(df_padded));
df_filt = filterSignal(timeVector, df_padded, filter_settings);
[t_downsampled, signal_downsampled] = randomDownsample(timeVector, df_filt, datarate);


peak_shape.time_full = timeVector;
peak_shape.ideal_signal_full = df_padded; 
peak_shape.filt_signal_full = df_filt; 
peak_shape.time_downsampled = t_downsampled;
peak_shape.filt_signal_downsampled = signal_downsampled; 
peak_shape.dt_full = dt;
peak_shape.dt_ds = 1/datarate; 

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [u, x] = get_mode_shape(n, channel_length)
% n is the mode number (currently works for 1-3)
% channel_length is the fraction of the cantilever length that the cell travels before
% turning around (0 < L < 1)
% evaluated at the grid in x. 

lambda = [1.8751, 4.6941, 7.855]; % eigenvalues 
L = 1; % cantilever length
An = L/1000; % amplitude. doesn't matter
dx = 0.001; % step size to evaluate mode shape
x = 0:dx:channel_length*L; % vector to evaluate mode shape 
x = [x, x(end:-1:1)]; % add points going the opposite direction
u = An/2 * ( (cosh(lambda(n)*x/L) - cos(lambda(n)*x/L)) - ((cosh(lambda(n))+cos(lambda(n)))/(sinh(lambda(n))+sin(lambda(n)))) * ...
    (sinh(lambda(n)*x/L) - sin(lambda(n)*x/L))); % mode shape
u = u/max(u); % normalize to max amplitude of 1 
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function df = get_peak_shape(u)
% get the peak shape resulting from a cell traveling through the cantilever
% with the mode shape given by u. normalized to 1. 

% what's the resonance frequency shift resulting from the added mass?
dm = 0.01; % added mass. magnitude doesn't actually matter since we just want the peak shape. 
m = 1; % cantilever mass 
df = -1 + (1 + u.^2 * dm/m).^-0.5;

% optional: normalize so that antinodes have height 1
% df = df/abs(min((df(1 : round(length(df)/3)))));
df = df/abs(min(df));
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [timeVector, dt] = getTimeVector(transit_time, signalLength, paddedLength)
% creates time vector to simulate the particle going through the cantilever
% with the specified transit time.
% signalLength is the length of the *peak*. 
% paddedLength is the total length of the signal vector, i.e., padded with
% zeros on either side. 
idx_padded = 0 : (paddedLength-1);
dt = transit_time/signalLength;
timeVector = idx_padded * dt;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function [t_downsampled, signal_downsampled] = randomDownsample(t, signal, datarate)
% downsamples the signal (evaluated at time vector t) at the given datarate. 
% random phase between signal and sampling. 
timeStepSize = (t(end) - t(1)) / numel(t);
sampleTime = 1/datarate;
downsampleRatio = ceil(sampleTime / timeStepSize);
tempRand = rand();
signal_downsampled = signal(ceil(downsampleRatio*tempRand) : downsampleRatio : end);
t_downsampled = t(ceil(downsampleRatio*tempRand) : downsampleRatio : end);
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function signal_filtered = filterSignal(t, signal, filter_settings)
% input bandwidth in rad/s (NOT Hz)
s = tf('s');

switch filter_settings.type
    case 'butterworth'     
        [z, p, k] = butter(filter_settings.loopOrder, filter_settings.bandwidth, 's');
        [num, den] = zp2tf(z, p, k);
        SMR_TF = tf(num,den);
    case 'chebyshev'
       [z,p,k] = cheb1ap(filter_settings.loopOrder, filter_settings.ripple);       % Lowpass filter prototype
       z = z * filter_settings.bandwidth;
       p = p * filter_settings.bandwidth; 
       [num,den] = zp2tf(z,p,k);     % Convert to transfer function form 
       SMR_TF = tf(num, den);
end

signal_filtered = lsim(SMR_TF, signal, t);
end