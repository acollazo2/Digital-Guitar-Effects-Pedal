
% Computes the convolution of two sequences directly.
%   Computes only up to the length of the input. Use
%   conv_direct_remaining to compute remaining M-1 terms.
% x: input sequence
% L: size of input
% h: filter sequence (ideally the shorter input)
% M: size of filter
% y: output convolution, size L+M-1
function y = conv_direct(x, L, h, M)
  N = L+M-1;
  y = zeros(1, L+M-1);

  for n = 0:N-1
    for m = 0:M-1
      x_index = n-m;
      if (x_index >= 0 && x_index < length(x))
        y(n+1) = y(n+1) + h(m+1)*x(x_index + 1);
      end
    end
  end

end
