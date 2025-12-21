tiledlayout(2,2,'TileSpacing','loose','Padding','compact'); nexttile;

Fs = 48000;
bufferSize = 256;


% Test signal with 5kHz and 15kHz frequencies
N = bufferSize*40; % about 10k samples
n = 0:N-1;
x = cos(2*pi*5000/Fs*n) + cos(2*pi*20000/Fs*n);
f = n*(Fs/N);
plot(f, abs(fft(x))); xlim([0, Fs/2]); title('X(f) Magnitude'); xlabel('freq (Hz)'); nexttile;

% Generate coefficients
[b, a] = LP_FirstOrder_Coeff(10000, Fs);


% Calculate frequency response custom implementation with impulse as input
impulse = [1, zeros(1, N-1)];
clear IIR_filter_apply
h = IIR_filter_apply(impulse, bufferSize, b, a);
plot(f, 20*log10(abs(fft(h)))); xlim([0 Fs/2]); title('H(f) Magnitude'); ylabel('dB'); xlabel('freq (Hz)'); nexttile;
plot(f, angle(fft(h))); xlim([0 Fs/2]); title('H(f) Phase'); xlabel('freq (Hz)'); nexttile;


% Calculate filtered output
clear IIR_filter_apply
y = IIR_filter_apply(x, bufferSize, b, a);
plot(f, abs(fft(y))); xlim([0 Fs/2]); title('Y(f) Magnitude'); xlabel('freq (Hz)');

% Test that custom IIR function produces correct output
y_ref = filter(b, a, x);
for i = 1:N
  if (abs(y(i) - y_ref(i)) > 0.001)
    fprintf('y(%d) = %f, y_ref(%d) = %f \n', i, y(i), i, y_ref(i));
  end
end
