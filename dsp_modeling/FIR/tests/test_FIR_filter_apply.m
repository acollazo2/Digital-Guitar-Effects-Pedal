clear; clc;
addpath(fullfile(pwd, '..'));


tiledlayout(2,2,'TileSpacing','loose','Padding','compact'); nexttile;

fileName = 'LP_FIR_coeff.txt';

Fs = 48000;
bufferSize = 256;

% Test signal with 10kHz and 15kHz frequencies
N = bufferSize*40; % about 10k samples
n = 0:N-1;
f = n*(Fs/N);
x = cos(2*pi*(10000/Fs)*n) + cos(2*pi*(15000/Fs)*n);

% Plot frequency response of filter
h = fscanf(fopen(fileName), '%f');
H = fft(h, N); % zero pad
plot(f, 20*log10(abs(H))); xlim([0 Fs/2]); title('H(f)'); ylabel('Gain dB'); nexttile;
plot(f, angle(H)); xlim([0 Fs/2]); title('H(f) phase'); nexttile;

% Plot frequency response of test signal
plot(f, abs(fft(x))); xlim([0 Fs/2]); title('X(f)'); nexttile;

% Apply and plot filtered signal frequency response
fir = FIR_struct(h);
y = FIR_filter_apply_long(x, bufferSize, fir);
plot(f, abs(fft(y))); xlim([0 Fs/2]); title('Y(f)');

% Test that custom convolution function produces correct output
y_l = conv(x,h);
errors = 0;
for i = 1:N
  if (abs(y(i) - y_l(i)) > 0.001)
    fprintf('y(%d) = %f, y_l(%d) = %f \n', i, y(i), i, y_l(i));
    errors = errors + 1;
  end
end
if (errors)
  fprintf("Test failed.\n");
else
  fprintf("Test passed.\n");
end
