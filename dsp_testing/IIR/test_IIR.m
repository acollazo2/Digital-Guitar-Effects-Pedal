tiledlayout(2,2,'TileSpacing','loose','Padding','compact'); nexttile;

Fs = 48000;
bufferSize = 256;

% Test signal with 5kHz and 15kHz frequencies
N = bufferSize*39; % about 10k samples
n = 0:N-1;
x = cos(2*pi*5000/Fs*n) + cos(2*pi*20000/Fs*n);

f = n*(Fs/N);


[b, a] = LP_FirstOrder_Freq_Coeff(10000, Fs);
[h,w] = freqz(b,a,N);
plot((w/(2*pi))*Fs, 20*log10(abs(h)));


y = filter(b, a, x);
plot(f, abs(fft(y))); xlim([0 Fs/2]);


%plots
% fft of input
% fft of my filter computed using impulse as input, ideal fft of filter using freqz
% fft of outupt using IIR_filter_apply, ideal fft of output using filter()