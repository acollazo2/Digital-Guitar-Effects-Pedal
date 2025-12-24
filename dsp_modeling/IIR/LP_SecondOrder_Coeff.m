
% IIR coefficents for a second order butterworth low pass filter.
% cutoff_freq: cut off frequency of low pass filter.
% Fs: sampling frequency of system.
% b: coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
% a: coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
function [b, a] = LP_SecondOrder_Coeff(cutoff_freq, Fs)
  b = zeros(1, 3);
  a = zeros(1, 3);

  alpha = 1/tan(pi*cutoff_freq/Fs); % Prewarp cutoff_freq
  r = alpha*alpha + alpha*1.414 + 1;
  b(1) = 1 / r;
  b(2) = 2/ r;
  b(3) = b(1);
  a(1) = 1;
  a(2) = (2 - 2*alpha*alpha) / r;
  a(3) = (alpha*alpha - alpha*1.414 + 1) / r;
end

