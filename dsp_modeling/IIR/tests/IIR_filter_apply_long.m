
% Applies an arbitrary order IIR filter to a long input sequence
%   by breaking the input into blocks and applying the filter to
%   each block while taking into account edge effects.
% x: long input sequence, length multiple of L
% L: input chunk size
% iir: IIR_struct instance containing necessary IIR parameters
function y = IIR_filter_apply_long(x, L, iir)
  numOfChunks = ceil(length(x)/L);
  y = zeros(1, numOfChunks*L); % Create space for output

  % Go through every chunk in x
  % This is what would be done to each buffer in a real-time system
  for i = 0:numOfChunks-1
    lowerbound = i*L;
    upperbound = lowerbound + L-1;

    x_i = x(lowerbound +1 : upperbound +1);
    y(lowerbound +1:upperbound +1) = IIR_filter_apply(x_i, L, iir);
  end
end
