
% Applies an FIR filter to a long input sequence using
%   the overlap app method.
% x: long input sequence, length multiple of L.
% L: input chunk size.
% fir: FIR_struct instance containing necessary FIR parameters.
% y: output convolution chunk, length equal to input size.
function y = FIR_filter_apply_long(x, L, fir)
  % zeropad x so it is a multiple length of L
  numOfChunks = ceil(length(x)/L);
  %x = [x, zeros(1, L*numOfChunks - length(x))];

  y = zeros(1, numOfChunks*L); % Create space for output

  % Go through every chunk in x
  % This is what would be done to each buffer in a real-time system
  for i = 0:numOfChunks-1
    lowerbound = i*L;
    upperbound = lowerbound + L-1;

    x_i = x(lowerbound +1 : upperbound +1);
    y(lowerbound +1:upperbound +1) = FIR_filter_apply(x_i, L, fir);
  end
end
