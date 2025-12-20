tiledlayout(2,2,'TileSpacing','loose','Padding','compact'); nexttile;

Fs = 48000;
bufferSize = 256;

% Test signal with 10kHz and 15kHz frequencies
N = bufferSize*39; % about 10k samples
n = 0:N-1;
x = cos(2*pi*10000/Fs*n) + cos(2*pi*15000/Fs*n);


