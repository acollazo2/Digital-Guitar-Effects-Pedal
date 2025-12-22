clear; clc;

addpath(fullfile(pwd, '..'));

% System info
Fs = 48000;
bufferSize = 256;
N = bufferSize*40; % about 10k samples


% Test signal with 5kHz and 15kHz frequencies
n = 0:N-1;
x = cos(2*pi*5000/Fs*n) + cos(2*pi*20000/Fs*n);


% Generate coefficients and test
[b, a] = butter(6, 10000/(Fs/2));
runTest(b, a, x, N, bufferSize, Fs, 'high_order_filter');

[b, a] = butter(1, 10000/(Fs/2));
runTest(b, a, x, N, bufferSize, Fs, 'low_order_filter');

b = butter(3, 10000/(Fs/2));
a = 1;
runTest(b, a, x, N, bufferSize, Fs, 'no_feedback_filter');

[~, a] = butter(3, 10000/(Fs/2));
b = 1;
runTest(b, a, x, N, bufferSize, Fs, 'no_feedforward_filter');

