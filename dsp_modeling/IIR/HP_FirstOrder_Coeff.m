

% IIR coefficents for a first order butterworth high pass filter.
% cutoff_freq: cut off frequency of high pass filter.
% Fs: sampling frequency of system.
% b: coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
% a: coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
function [b, a] = HP_FirstOrder_Coeff(cutoff_freq, Fs)
  b = zeros(1, 2);
  a = zeros(1, 2);

  wcT = 2*tan(pi*cutoff_freq/Fs); % Prewarp cutoff_freq
  b(1) = 2/(wcT+2);
  b(2) = -b(1);
  a(1) = 1;
  a(2) = (wcT-2)/(wcT+2); 
end
