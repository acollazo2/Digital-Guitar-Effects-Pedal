

% IIR coefficents for a first order low pass filter.
%   Coefficents are for the time representation of the output.
% x_coeff: [x(n), x(n-1), ...]
% y_coeff: [y(n-1), y(n-2), ...]

function [x_coeff, y_coeff] = LP_FirstOrder_Time_Coeff(cutoff_freq, sampling_freq)
  x_coeff = zeros(1, 2);
  y_coeff = zeros(1, 1);

  wcT = 2*tan(pi*cutoff_freq/sampling_freq); % Prewarp cutoff_freq
  x_coeff(1) = wcT / (2 + wcT);
  x_coeff(2) = x_coeff(1);
  y_coeff(1) = (2 - wcT) / (wcT + 2);
end

