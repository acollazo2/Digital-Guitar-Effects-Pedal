


% b: coefficients for numerator of transfer function [1, z^-1, z^-2,...]
% a: coefficients for denominator of transfer function [1, z^-1, z^-2,...]

function [b, a] = LP_FirstOrder_Freq_Coeff(cutoff_freq, sampling_freq)
  b = zeros(1, 2);
  a = zeros(1, 2);
  
  wcT = 2*tan(pi*cutoff_freq/sampling_freq); % Prewarp cutoff_freq
  b(1) = wcT;
  b(2) = wcT;
  a(1) = 2 + wcT;
  a(2) = wcT - 2;
end

