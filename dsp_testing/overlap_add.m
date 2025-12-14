

% x: long input sequence, length multiple of L
% h: impulse response
% L: input chunk size
% y: output convolution chunk, length equal to input size
function y = overlap_add(x, h, L)
% zeropad x so it is a multiple length of L
  numOfChunks = ceil(length(x)/L);
  %x = [x, zeros(1, L*numOfChunks - length(x))];

  y = zeros(1, numOfChunks*L); % Create space for output chunks
  M = length(h);
  overlapped_symbols = zeros(1, M-1);

  % Go through every chunk in x
  for i = 0:numOfChunks-1
    lowerbound = i*L;
    upperbound = lowerbound + L-1;
    x_i = x(lowerbound +1 : upperbound +1);
    y_i = conv_direct(x_i, h); % length L+M-1
    
    % Add saved samples to beginning of y_i
    for j = 0:M-1 -1
      y_i(j +1) = y_i(j +1) + overlapped_symbols(j +1);
    end

    % save last M-1 samples of y_i
    for j = 0:M-1 - 1
      overlapped_symbols(j +1) = y_i(L+j +1);
    end

    y(lowerbound +1:upperbound +1) = y_i(1:L);
  end
end
