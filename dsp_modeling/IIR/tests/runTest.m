


% Tests the functionality of IIR_filter_apply on a single filter.
%   Compares the output with matlab's implementation.
% b: coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
% a: coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
% x: long input sequence, length multiple of L.
% N: Total length of input x.
% bufferSize: blocks to which break up the input x into.
% Fs: sampling frequency of system.
% title_of_test: Name relating to what the current test is about.
function runTest(b, a, x, N, bufferSize, Fs, title_of_test)
  figure('Name', title_of_test);
  tiledlayout(3,2,'TileSpacing','loose','Padding','compact'); nexttile;
  iir = IIR_struct(b, a);

  % Data range
  n = 0:N-1;
  f = n*(Fs/N);
  
  % Plot transfer function calculated with custom implementation
  impulse = [1, zeros(1, N-1)];
  h = IIR_filter_apply(impulse, bufferSize, iir);
  plot(f, 20*log10(abs(fft(h)))); xlim([0 Fs/2]); title('H(f) Magnitude'); ylabel('dB'); xlabel('freq (Hz)'); nexttile;
  plot(f, angle(fft(h))); xlim([0 Fs/2]); title('H(f) Phase'); xlabel('freq (Hz)'); nexttile;

  % Plot transfer function using matlab's implementation
  [H_ref, w] = freqz(b, a, N/2);
  plot((w*Fs)/(2*pi), 20*log10(abs(H_ref))); title('H(f) Magnitude (Reference)'); ylabel('dB'); xlabel('freq (Hz)'); nexttile;
  plot((w*Fs)/(2*pi), angle(H_ref)); title('H(f) Phase (Reference)'); xlabel('freq (Hz)'); nexttile;
  
  % Plot frequency response of input
  plot(f, abs(fft(x))); xlim([0, Fs/2]); title('X(f) Magnitude'); xlabel('freq (Hz)'); nexttile;

  % Apply filter using custom implementation and plot frequency response
  y = IIR_filter_apply(x, bufferSize, iir);
  plot(f, abs(fft(y))); xlim([0 Fs/2]); title('Y(f) Magnitude'); xlabel('freq (Hz)');

  % Verify filtered output using matlab's implementation
  errors = 0;
  y_ref = filter(b, a, x);
  for i = 1:N
    if (abs(y(i) - y_ref(i)) > 0.001)
      fprintf('y(%d) = %f, y_ref(%d) = %f \n', i, y(i), i, y_ref(i));
      errors = errors + 1;
    end
  end
  if (errors == 0)
    fprintf("Test [%s] passed.\n", title_of_test);
  else
    fprintf("Test [%s] failed.\n", title_of_test);
  end
end
