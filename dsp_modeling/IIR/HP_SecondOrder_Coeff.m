
% IIR coefficents for a second order butterworth high pass filter.
% cutoff_freq: cut off frequency of high pass filter.
% Fs: sampling frequency of system.
% b: coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
% a: coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
function [b, a] = HP_SecondOrder_Coeff(cutoff_freq, Fs)
  b = zeros(1, 3);
  a = zeros(1, 3);

  wcT = 2*tan(pi*cutoff_freq/Fs); % Prewarp cutoff_freq
  r = wcT^2 + 2*1.414*wcT + 4;
  b(1) = 4/r;
  b(2) = -8/r;
  b(3) = b(1);
  a(1) = 1;
  a(2) = (2*wcT^2 -8) / r;
  a(3) = (wcT^2 - 2*1.414*wcT + 4)/r;
end
