
% Applies an FIR filter to a long input sequence using
%   the overlap app method.
% x: long input sequence, length multiple of L.
% L: input chunk size.
% fir: FIR_struct instance containing necessary FIR parameters.
% y: output convolution chunk, length equal to input size.
function y = FIR_filter_apply(x, L, fir)
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
    y(lowerbound +1:upperbound +1) = overlap_add(x_i, L, fir);
  end
end


% Applies convolution to a block of input. Uses the overlap
%   add method so next block produces the correct output.
% x: input of size L
% L: size of input
% fir: FIR_struct instance containing necessary FIR parameters.
% y: output convolution, also size L
function y = overlap_add(x, L, fir)
  M = fir.M;
  
  % Perform convolution to produce first L terms
  y = conv_direct_range(x, L, fir.h, M, 0, L-1); % length L

  % Add saved samples to beginning of y_l
  for i = 0:M-1 -1
    y(i +1) = y(i +1) + fir.past_x(i +1);
  end

  % Compute remaining M-1 terms which are saved for next block
  fir.past_x = conv_direct_range(x, L, fir.h, M, L, L+M-1-1);
end
