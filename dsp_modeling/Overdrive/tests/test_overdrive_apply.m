clear; clc;
addpath(fullfile(pwd, '..')); % access to overdrive stuff
addpath(fullfile(pwd, '../../FIR/')); % access to FIR stuff
addpath(fullfile(pwd, '../../IIR/')); % access to IIR stuff

tiledlayout(3,2,'TileSpacing','loose','Padding','compact'); nexttile;

fileName = 'FIR_antialiasing_filter.txt';

Fs = 48000;
bufferSize = 256;

% Test signal
N = bufferSize*40; % about 10k samples
n = 0:N-1;
f = n*(Fs/N);
x = cos(2*pi*(200/Fs)*n);

fc_HP = 50;
fc_LP = 10000;

% FIR lowpass antialiasing (10k to 12k transistion, 1dB pass ripple, -60dB attenuation)
h = fscanf(fopen(fileName), '%f');
antialiasing_filter = FIR_struct(h);

% IIR first order highpass (fc < 2000)
[b, a] = HP_FirstOrder_Coeff(fc_HP, Fs);
pre_filter = IIR_struct(b, a);

% IIR second order lowpass (fc > 2500)
[b, a] = LP_SecondOrder_Coeff(fc_LP, Fs);
post_filter = IIR_struct(b, a);

% Create overdrive struct
od = OD_struct(2, 1/3, antialiasing_filter, pre_filter, post_filter);


% Plot input signal
plot(n, x); xlim([0 1000]); title('x(n)'); nexttile;
plot(f, abs(fft(x))); xlim([0 2000]); title('X(f) Magnitude'); nexttile;

% Process input
y = overdrive_apply_long(x, bufferSize, od);
plot(n, y); xlim([0 1000]); title('y(n)'); nexttile;
plot(f, abs(fft(y))); xlim([0 2000]); title('Y(f) Magnitude'); nexttile;

% Process input using matlab's implementations
y_ref_1 = conv(x, h);
[b, a] = butter(1, fc_HP/(Fs/2), "high");
y_ref_2 = filter(b, a, y_ref_1(1:N));
y_ref_3 = clip_signal(y_ref_2, N, od);
[b, a] = butter(2, fc_LP/(Fs/2));
y_ref = filter(b, a, y_ref_3);
plot(n, y_ref); xlim([0 1000]); title('y(n) (Reference)'); nexttile;
plot(f, abs(fft(y_ref))); xlim([0 2000]); title('Y(f) Magnitude (Reference)');

% Verify output
errors = 0;
for i = 1:N
  if (abs(y(i) - y_ref(i)) > 0.001)
    fprintf('y(%d) = %f, y_l(%d) = %f \n', i, y(i), i, y_ref(i));
    errors = errors + 1;
  end
end
if (errors)
  fprintf("Test failed.\n");
else
  fprintf("Test passed.\n");
end


