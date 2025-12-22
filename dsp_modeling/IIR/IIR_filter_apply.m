

% Applies an arbitrary order IIR filter to a long input sequence
%   by breaking the input into blocks and applying the filter to
%   each block while taking into account edge effects.
% x: long input sequence, length multiple of L
% L: input chunk size
% b: coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
% a: coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
function y = IIR_filter_apply(x, L, b, a)
  numOfChunks = ceil(length(x)/L);
  y = zeros(1, numOfChunks*L); % Create space for output

  % Go through every chunk in x
  % This is what would be done to each buffer in a real-time system
  for i = 0:numOfChunks-1
    lowerbound = i*L;
    upperbound = lowerbound + L-1;

    x_i = x(lowerbound +1 : upperbound +1);
    y(lowerbound +1:upperbound +1) = IIR_filter_apply_block(x_i, L, b, a);
  end
end


% Applies IIR filter to input block.
%   Saves necessary past inputs/outputs necessary for next block.
% x: input block of size L
% L: size of block
% b: coefficients for numerator of transfer function [b0, b1*z^-1, b2*bz^-2,...]
% a: coefficients for denominator of transfer function [a0, a1*z^-1, a2*z^-2,...]
function y = IIR_filter_apply_block(x, L, b, a)
  
  % Buffers to hold past inputs and outputs.
  % These would be part of an IIR struct in the final C implementation.
  persistent past_x; % [x(-1), x(-2), ...]
  if (isempty(past_x))
    past_x = zeros(1, length(b) - 1);
  end
  persistent past_y; % [y(-1), y(-2), ...]
  if (isempty(past_y))
    past_y = zeros(1, length(a) - 1);
  end
  
  y = zeros(1, L);

  for i = 0:L-1
    % Go through x coefficients
    for j = 0:length(b)-1
      index = i - j;
      if (index < 0)
        y(i +1) = y(i +1) + b(j +1)*past_x(-index-1 +1);
      else
        y(i +1) = y(i +1) + b(j +1)*x(index +1);
      end
    end
    % Go through y coefficients
    for j = 1:length(a)-1
      index = i - j;
      if (index < 0)
        y(i +1) = y(i +1) - a(j +1)*past_y(-index-1 +1);
      else
        y(i +1) = y(i +1) - a(j +1)*y(index +1);
      end
    end
  end

  % Update past_x
  j = L-1;
  for i = 0:length(past_x)-1
    past_x(i +1) = x(j +1);
    j = j-1;
  end
  % Update past_y
  j = L-1;
  for i = 0:length(past_y)-1
    past_y(i +1) = y(j +1);
    j = j-1;
  end
  
end
