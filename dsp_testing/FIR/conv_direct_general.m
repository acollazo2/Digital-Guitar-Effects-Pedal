
% Computes the convolution of two sequences directly.
%   Computes only from the given start and stop indices
% x: input sequence
% L: size of input
% h: filter sequence (ideally the shorter input)
% M: size of filter
% start: mathematical index to start computing from
% stop: mathematical index to stop computing at
% y: output convolution, size stop-start+1
function y = conv_direct_general(x, L, h, M, start, stop)
  y = zeros(1, stop-start+1);
  if (start >= L+M-1 || stop >= L+M-1 || start < 0 || stop < 0 || stop < start)
    return;
  end

  for n = start:stop
    for m = 0:M-1
      x_index = n-m;
      if (x_index >= 0 && x_index < length(x))
        y(n-start +1) = y(n-start +1) + h(m +1)*x(x_index +1);
      end
    end
  end

end

