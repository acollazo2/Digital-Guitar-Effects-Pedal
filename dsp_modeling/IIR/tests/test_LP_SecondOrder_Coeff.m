clear; clc;

addpath(fullfile(pwd, '..'));

tiledlayout(2,2,'TileSpacing','loose','Padding','compact'); nexttile;

Fs = 48000;
Fc = 10000;
N = 10000;


% Custom coefficient generator
[b,a] = LP_SecondOrder_Coeff(Fc, Fs);
[H,w] = freqz(b, a, N);
plot((w*Fs)/(2*pi), 20*log10(abs(H))); title('H(f) Magnitude'); ylabel('dB'); xlabel('freq (Hz)'); nexttile;
plot((w*Fs)/(2*pi), angle(H)); title('H(f) Phase'); xlabel('freq (Hz)'); nexttile;

% Matlab's coefficient generator
[b_ref, a_ref] = butter(2, Fc/(Fs/2));
[H_ref,w] = freqz(b_ref, a_ref, N);
plot((w*Fs)/(2*pi), 20*log10(abs(H_ref))); title('H(f) Magnitude (Reference)'); ylabel('dB'); xlabel('freq (Hz)'); nexttile;
plot((w*Fs)/(2*pi), angle(H_ref)); title('H(f) Phase (Reference)'); xlabel('freq (Hz)');

% Verify coefficients
errors = 0;
for i = 1:length(a)
  if (abs(a - a_ref) > 0.001)
    fprintf('a_%d = %f, a_ref_%d = %f \n', i, a(i), i, a_ref(i));
    errors = errors + 1;
  end
end
for i = 1:length(b)
  if (abs(b - b_ref) > 0.001)
    fprintf('b_%d = %f, b_ref_%d = %f \n', i, b(i), i, b_ref(i));
    errors = errors + 1;
  end
end
if (errors == 0)
  fprintf("Test passed.\n");
else
  fprintf("Test failed.\n");
end